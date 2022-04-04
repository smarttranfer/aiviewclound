import 'package:aiviewcloud/constants/assets.dart';
import 'package:aiviewcloud/models/camera_p2p/camera_p2p.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CamItemModal extends StatelessWidget {
  final CameraP2P? camera;
  final bool selected;
  const CamItemModal({Key? key, required this.camera, this.selected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
              child: Center(
                child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    imageUrl: camera!.snapShotUrl ?? '',
                    imageBuilder: (context, imageProvider) => Stack(
                          children: [
                            Opacity(
                                opacity: this.camera!.isConnected ? 1 : 0.4,
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )),
                            this.camera!.isConnected
                                ? Container()
                                : Center(
                                    child:
                                        SvgPicture.asset(Assets.disconnected)),
                          ],
                        ),
                    // Container(
                    //       decoration: BoxDecoration(
                    //         image: DecorationImage(
                    //           image: imageProvider,
                    //           fit: BoxFit.fill,
                    //         ),
                    //       ),
                    //     ),
                    errorWidget: (context, url, error) => Stack(children: [
                          Opacity(
                              opacity: this.camera!.isConnected ? 1 : 0.4,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image:
                                        const AssetImage(Assets.defaultCamera),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )),
                          this.camera!.isConnected
                              ? Container()
                              : Center(
                                  child: SvgPicture.asset(Assets.disconnected))
                        ])),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  color: const Color(0xff2b2f33))),
        ),
        Opacity(
            opacity: this.camera!.isConnected ? 1 : 0.4,
            child: SizedBox(
                width: double.infinity,
                child: Container(
                  height: 33.h,
                  padding: EdgeInsets.symmetric(horizontal: 16.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                      ),
                      color: const Color(0xff404447)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                          child: Text(
                        camera?.cameraName ?? '',
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w400,
                            fontFamily: "SFProDisplay",
                            fontStyle: FontStyle.normal,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 14.0),
                        textAlign: TextAlign.left,
                      )),
                      SvgPicture.asset(
                          selected ? Assets.checked : Assets.unchecked)
                    ],
                  ),
                )))
      ],
    );
    // decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(8)),
    //     color: const Color(0xff2b2f33)));
  }
}
