import 'dart:io';

import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/constants/colors.dart';
import 'package:aiviewcloud/constants/font_family.dart';
import 'package:aiviewcloud/stores/library/library_store.dart';
import 'package:aiviewcloud/ui/library/library_screen.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/drawer_header_widget.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dialog_app.dart';
import 'locally_available_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'video_play_duration.dart';

TextStyle textStyle = TextStyle(
  fontFamily: FontFamily.sfProDisplay,
  fontSize: 14,
  color: AppColors.mWhiteColor,
);

class VideoPageBuilder extends StatefulWidget {
  const VideoPageBuilder({
    Key? key,
    required this.asset,
    required this.libraryStore,
  }) : super(key: key);

  final AssetEntity asset;

  final LibraryStore libraryStore;

  @override
  _VideoPageBuilderState createState() => _VideoPageBuilderState();
}

class _VideoPageBuilderState extends State<VideoPageBuilder> {
  VideoPlayerController get controller => _controller!;
  VideoPlayerController? _controller;

  bool hasLoaded = false;

  bool hasErrorWhenInitializing = false;

  final ValueNotifier<bool> isPlaying = ValueNotifier<bool>(false);

  bool get isControllerPlaying => _controller?.value.isPlaying ?? false;

  bool _isInitializing = false;
  bool _isLocallyAvailable = false;
  double _volumeLevel = 1;
  double _playSpeed = 1;

  @override
  void dispose() {
    _controller
      ?..removeListener(videoPlayerListener)
      ..pause()
      ..dispose();
    super.dispose();
  }

  Future<void> initializeVideoPlayerController() async {
    _isInitializing = true;
    _isLocallyAvailable = true;
    final String? url = await widget.asset.getMediaUrl();
    if (url == null) {
      hasErrorWhenInitializing = true;
      if (mounted) {
        setState(() {});
      }
      return;
    }
    if (Platform.isAndroid) {
      _controller = VideoPlayerController.contentUri(Uri.parse(url));
    } else {
      _controller = VideoPlayerController.network(url);
    }
    try {
      await controller.initialize();
      hasLoaded = true;
      controller
        ..addListener(videoPlayerListener)
        ..setLooping(false)
        ..play();
      controller.setVolume(_volumeLevel);
    } catch (e) {
      hasErrorWhenInitializing = true;
    } finally {
      if (mounted) {
        setState(() {});
      }
    }
  }

  void videoPlayerListener() {
    if (isControllerPlaying != isPlaying.value) {
      isPlaying.value = isControllerPlaying;
    }
  }

  Future<void> playButtonCallback() async {
    if (isPlaying.value) {
      controller.pause();
      return;
    }
    if (controller.value.duration == controller.value.position) {
      controller
        ..seekTo(Duration.zero)
        ..play();
      return;
    }
    controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mGreyColor3,
      drawer: SMEDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            DrawerHeaderWidget(
              headerText: AppLocalizations.of(context).translate('view_detail'),
              rightWidget: IconButton(
                onPressed: () {
                  onShowDialog(
                    context: context,
                    onShare: () async {
                      Navigator.pop(context);
                      File? file = await widget.asset.file;
                      if (file != null) {
                        Share.shareFiles([file.path], subject: 'Chia sẻ file');
                      }
                    },
                    onDelete: () {
                      Navigator.pop(context);
                      DialogApp.deleteVideoAndImageBottomSheet(
                        context,
                        yesCallBack: () {
                          Navigator.pop(context);
                          widget.libraryStore
                              .deleteAAssetEntity(widget.asset)
                              .then((isDeleted) {
                            if (isDeleted) {
                              Navigator.pop(context);
                            }
                          });
                        },
                      );
                    },
                    onSave: () {
                      widget.libraryStore.saveAssetEntity(widget.asset);
                    },
                  );
                },
                icon: SvgPicture.asset(Assets.icVerticalDots),
              ),
            ),
            Expanded(
              child: LocallyAvailableBuilder(
                asset: widget.asset,
                builder: (BuildContext context, AssetEntity asset) {
                  if (hasErrorWhenInitializing) {
                    return Center(child: Text('Failed'));
                  }
                  if (!_isLocallyAvailable && !_isInitializing) {
                    initializeVideoPlayerController();
                  }
                  if (!hasLoaded) {
                    return const SizedBox.shrink();
                  }
                  return Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Positioned.fill(
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomCenter,
                              children: [
                                VideoPlayer(controller),
                                Positioned(
                                  top: 12,
                                  left: 12,
                                  child: VideoDisplayLength(
                                      duration: widget.asset.duration),
                                ),
                                Positioned(
                                  left: 16,
                                  right: 16,
                                  bottom: -24,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: ValueListenableBuilder(
                                            valueListenable: controller,
                                            builder: (context,
                                                VideoPlayerValue value, child) {
                                              return Text(
                                                '${formatDuration(value.position.inSeconds)}',
                                                style: textStyle.copyWith(
                                                    height: 1.3),
                                              );
                                            }),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 16),
                                          child: VideoProgressIndicator(
                                            controller,
                                            allowScrubbing: false,
                                            colors: VideoProgressColors(
                                              playedColor:
                                                  AppColors.mOrangeColor,
                                              bufferedColor:
                                                  AppColors.mGreyColor1,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${formatDuration(widget.asset.duration)}',
                                        style: textStyle.copyWith(height: 1.3),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: isPlaying,
                        builder: (_, bool value, __) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: value ? playButtonCallback : null,
                          child: Center(
                            child: AnimatedOpacity(
                              duration: kThemeAnimationDuration,
                              opacity: value ? 0.0 : 1.0,
                              child: GestureDetector(
                                onTap: playButtonCallback,
                                child: DecoratedBox(
                                  decoration: const BoxDecoration(
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(color: Colors.black12)
                                    ],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    value
                                        ? Icons.pause_circle_outline
                                        : Icons.play_circle_filled,
                                    size: 70.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 90.h,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (_volumeLevel == 1) {
                                      _volumeLevel = 0;
                                    } else {
                                      _volumeLevel = 1;
                                    }
                                    controller.setVolume(_volumeLevel);
                                  });
                                },
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.mGreyColor5,
                                    shape: BoxShape.circle,
                                  ),
                                  child: _volumeLevel == 1
                                      ? SvgPicture.asset(Assets.volume)
                                      : Icon(
                                          Icons.volume_mute_rounded,
                                          color: AppColors.mWhiteColor,
                                          size: 34,
                                        ),
                                ),
                              ),
                              ValueListenableBuilder<bool>(
                                valueListenable: isPlaying,
                                builder: (_, bool value, __) {
                                  return GestureDetector(
                                    onTap: playButtonCallback,
                                    child: Container(
                                      width: 52,
                                      height: 52,
                                      alignment: Alignment.center,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 28),
                                      decoration: BoxDecoration(
                                          color: AppColors.mGreyColor5,
                                          shape: BoxShape.circle),
                                      child: value
                                          ? SvgPicture.asset(
                                              Assets.icVideoPlaying)
                                          : Icon(
                                              Icons.play_arrow_rounded,
                                              color: AppColors.mWhiteColor,
                                            ),
                                    ),
                                  );
                                },
                              ),
                              GestureDetector(
                                onTap: () {
                                  DialogApp.videoPlaySpeedList(
                                    context,
                                    onSelectValue: (value) {
                                      Navigator.pop(context);
                                      controller.setPlaybackSpeed(value);
                                      setState(() {
                                        _playSpeed = value;
                                      });
                                    },
                                  );
                                },
                                child: Container(
                                  width: 52,
                                  height: 52,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: AppColors.mGreyColor5,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 2,
                                          color: AppColors.mWhiteColor),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${_playSpeed}x',
                                        style: textStyle.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 9),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String formatDuration(int seconds) {
    return '${Duration(seconds: seconds).inHours.toString().padLeft(2, '0')}:${Duration(seconds: seconds).inMinutes.toString().padLeft(2, '0')}:${Duration(seconds: seconds).inSeconds.toString().padLeft(2, '0')}';
  }
}
