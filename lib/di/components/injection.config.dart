// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:sembast/sembast.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../data/camera_repository.dart' as _i13;
import '../../data/local/datasources/post/post_datasource.dart' as _i19;
import '../../data/network/apis/camerap2p/camerap2p_api.dart' as _i14;
import '../../data/network/apis/posts/camera_api.dart' as _i18;
import '../../data/network/apis/posts/post_api.dart' as _i17;
import '../../data/network/apis/user/user_api.dart' as _i11;
import '../../data/network/dio_client.dart' as _i26;
import '../../data/network/rest_client.dart' as _i25;
import '../../data/repository.dart' as _i16;
import '../../data/sharedpref/shared_preference_helper.dart' as _i9;
import '../../data/user_repository.dart' as _i10;
import '../../stores/camera/camerap2p_store.dart' as _i15;
import '../../stores/device/device_store.dart' as _i21;
import '../../stores/error/error_store.dart' as _i4;
import '../../stores/form/form_store.dart' as _i5;
import '../../stores/global/global_store.dart' as _i22;
import '../../stores/language/language_store.dart' as _i23;
import '../../stores/library/library_store.dart' as _i6;
import '../../stores/post/post_store.dart' as _i24;
import '../../stores/theme/theme_store.dart' as _i20;
import '../../stores/user/user_store.dart' as _i12;
import '../module/local_module.dart' as _i27;
import '../module/network_module.dart'
    as _i28; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final localModule = _$LocalModule();
  final networkModule = _$NetworkModule();
  await gh.factoryAsync<_i3.Database>(() => localModule.provideDatabase(),
      preResolve: true);
  gh.factory<_i4.ErrorStore>(() => _i4.ErrorStore());
  gh.factory<_i5.FormStore>(() => _i5.FormStore());
  gh.factory<_i6.LibraryStore>(() => _i6.LibraryStore());
  await gh.factoryAsync<_i7.SharedPreferences>(
      () => localModule.provideSharedPreferences(),
      preResolve: true);
  gh.factory<_i8.Dio>(
      () => networkModule.provideDio(get<_i9.SharedPreferenceHelper>()));
  gh.factory<_i10.UserRepository>(() => localModule.provideUserRepository(
      get<_i11.UserApi>(), get<_i9.SharedPreferenceHelper>()));
  gh.factory<_i12.UserStore>(() => _i12.UserStore(get<_i10.UserRepository>()));
  gh.factory<_i13.CameraP2PRepository>(() =>
      localModule.provideCameraP2PRepository(
          get<_i14.CameraP2PApi>(), get<_i9.SharedPreferenceHelper>()));
  gh.factory<_i15.CameraP2PStore>(
      () => _i15.CameraP2PStore(get<_i13.CameraP2PRepository>()));
  gh.factory<_i16.Repository>(() => localModule.provideRepository(
      get<_i17.PostApi>(),
      get<_i18.CameraApi>(),
      get<_i11.UserApi>(),
      get<_i9.SharedPreferenceHelper>(),
      get<_i19.PostDataSource>()));
  gh.factory<_i20.ThemeStore>(() => _i20.ThemeStore(get<_i16.Repository>()));
  gh.factory<_i21.DeviceStore>(() => _i21.DeviceStore(get<_i16.Repository>()));
  gh.factory<_i22.GlobalStore>(() => _i22.GlobalStore(get<_i16.Repository>()));
  gh.factory<_i23.LanguageStore>(
      () => _i23.LanguageStore(get<_i16.Repository>()));
  gh.factory<_i24.PostStore>(() => _i24.PostStore(get<_i16.Repository>()));
  gh.singleton<_i19.PostDataSource>(_i19.PostDataSource(get<_i3.Database>()));
  gh.singleton<_i25.RestClient>(_i25.RestClient());
  gh.singleton<_i9.SharedPreferenceHelper>(
      _i9.SharedPreferenceHelper(get<_i7.SharedPreferences>()));
  gh.singleton<_i26.DioClient>(_i26.DioClient(get<_i8.Dio>()));
  gh.singleton<_i17.PostApi>(
      _i17.PostApi(get<_i26.DioClient>(), get<_i25.RestClient>()));
  gh.singleton<_i11.UserApi>(
      _i11.UserApi(get<_i26.DioClient>(), get<_i25.RestClient>()));
  gh.singleton<_i18.CameraApi>(
      _i18.CameraApi(get<_i26.DioClient>(), get<_i25.RestClient>()));
  gh.singleton<_i14.CameraP2PApi>(
      _i14.CameraP2PApi(get<_i26.DioClient>(), get<_i25.RestClient>()));
  return get;
}

class _$LocalModule extends _i27.LocalModule {}

class _$NetworkModule extends _i28.NetworkModule {}
