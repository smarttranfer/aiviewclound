import 'dart:io';

import 'package:aiviewcloud/constants/app_theme.dart';
import 'package:aiviewcloud/constants/strings.dart';
import 'package:aiviewcloud/data/camera_repository.dart';
import 'package:aiviewcloud/data/network/constants/endpoints.dart';
import 'package:aiviewcloud/data/network/dio_client.dart';
import 'package:aiviewcloud/data/repository.dart';
import 'package:aiviewcloud/data/sharedpref/constants/preferences.dart';
import 'package:aiviewcloud/data/user_repository.dart';
import 'package:aiviewcloud/di/components/injection.dart';
import 'package:aiviewcloud/stores/camera/camerap2p_store.dart';
import 'package:aiviewcloud/stores/device/device_store.dart';
import 'package:aiviewcloud/stores/global/global_store.dart';
import 'package:aiviewcloud/stores/library/library_store.dart';
import 'package:aiviewcloud/ui/device_management/device_management.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/stores/language/language_store.dart';
import 'package:aiviewcloud/stores/post/post_store.dart';
import 'package:aiviewcloud/stores/theme/theme_store.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/ui/login.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/message_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keychain/flutter_keychain.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'device_management/internet_connection.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyApp();
}

class _MyApp extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = ThemeStore(getIt<Repository>());
  final GlobalStore _globalStore = GlobalStore(getIt<Repository>());
  final PostStore _postStore = PostStore(getIt<Repository>());
  final DeviceStore _deviceStore = DeviceStore(getIt<Repository>());
  final LanguageStore _languageStore = LanguageStore(getIt<Repository>());
  final CameraP2PStore _cameraP2PStore =
      CameraP2PStore(getIt<CameraP2PRepository>());
  final UserStore _userStore = UserStore(getIt<UserRepository>());
  final LibraryStore _libraryStore = LibraryStore();

  late Stream<String> _tokenStream;
  late AppLifecycleState _notification;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state.index == 1) {
      if (_userStore.isLoggedIn) {
        String? username = await FlutterKeychain.get(key: Preferences.username);
        String? password = await FlutterKeychain.get(key: Preferences.password);
        _userStore.login({
          "UserName": username,
          "Password": password,
          "ClientID": Endpoints.getClientId,
          "OS": Platform.isIOS ? 1 : 2
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.

    super.initState();
    () async {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      Endpoints.initEnvMode();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      FirebaseMessaging.instance
          .getToken(
              vapidKey:
                  'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
          .then((String? token) {
        prefs.setString(Preferences.fcmToken, token!);
      });
      _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
      _tokenStream.listen((String? token) {
        prefs.setString(Preferences.fcmToken, token!);
      });
    }();
    // TokenMonitor((token) {
    //   _token = token;
    //   print(token);
    //   prefs.setString(Preferences.fcmToken, token);
    // });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(context, '/message',
            arguments: MessageArguments(message, true));
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));
    });
    InternetConnection.instance.listenInternetConnection(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeStore>(create: (_) => _themeStore),
        Provider<PostStore>(create: (_) => _postStore),
        Provider<DeviceStore>(create: (_) => _deviceStore),
        Provider<UserStore>(create: (_) => _userStore),
        Provider<CameraP2PStore>(create: (_) => _cameraP2PStore),
        Provider<LanguageStore>(create: (_) => _languageStore),
        Provider<GlobalStore>(create: (_) => _globalStore),
        Provider<LibraryStore>(create: (_) => _libraryStore),
      ],
      child: Observer(
        name: 'global-observer',
        builder: (context) {
          print(_languageStore.locale);
          return Listener(
              onPointerDown: (_) {
                WidgetsBinding.instance?.focusManager.primaryFocus?.unfocus();
              },
              child: ScreenUtilInit(
                  designSize: Size(375, 812),
                  builder: () => MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: Strings.appName,
                        theme: _themeStore.darkMode ? themeDataDark : themeData,
                        routes: Routes.routes,
                        locale: Locale(_languageStore.locale),
                        supportedLocales: _languageStore.supportedLanguages
                            .map((language) =>
                                Locale(language.locale!, language.code))
                            .toList(),
                        localizationsDelegates: [
                          // A class which loads the translations from JSON files
                          AppLocalizations.delegate,
                          // Built-in localization of basic text for Material widgets
                          GlobalMaterialLocalizations.delegate,
                          // Built-in localization for text direction LTR/RTL
                          GlobalWidgetsLocalizations.delegate,
                          // Built-in localization of basic text for Cupertino widgets
                          GlobalCupertinoLocalizations.delegate,
                        ],
                        home: _userStore.isLoggedIn
                            ? DeviceManagement()
                            : LoginScreen(),
                      )));
        },
      ),
    );
  }
}
