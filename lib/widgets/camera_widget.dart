import 'package:adobe_xd/adobe_xd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CameraLabelWidget extends StatelessWidget {
  const CameraLabelWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinned.fromPins(
      Pin(size: 80.0, middle: 0.5),
      Pin(size: 60.0, start: 0.0),
      child:
          // Adobe XD layer: 'Group 6625' (group)
          Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 0.0, end: 0.0),
            child:
                // Adobe XD layer: 'Group 6539' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Video' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 17.6, end: 0.0),
                        Pin(start: 8.9, end: 8.9),
                        child:
                            // Adobe XD layer: 'Fill 1' (shape)
                            SvgPicture.string(
                          _svg_dmh94t,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 23.9),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'Fill 3' (shape)
                            SvgPicture.string(
                          _svg_jd3rlp,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_dmh94t =
    '<svg viewBox="210.4 132.9 17.6 42.2" ><path transform="translate(210.35, 132.91)" d="M 14.97214984893799 0.8647467494010925 C 13.29613304138184 -0.1910902559757233 11.23611259460449 -0.2844913005828857 9.480094909667969 0.6089093089103699 L 3.552035570144653 3.60180139541626 C 1.360013723373413 4.706369400024414 0 6.939871311187744 0 9.425149917602539 L 0 32.75914764404297 C 0 35.24442672729492 1.360013723373413 37.4738655090332 3.552035570144653 38.58655548095703 L 9.476095199584961 41.57538986206055 C 10.28010368347168 41.98960494995117 11.14011192321777 42.1885871887207 12.00012016296387 42.1885871887207 C 13.03213024139404 42.1885871887207 14.0561408996582 41.89620208740234 14.97214984893799 41.32361221313477 C 16.64816665649414 40.27183532714844 17.6481761932373 38.448486328125 17.6481761932373 36.45051956176758 L 17.6481761932373 5.741902351379395 C 17.6481761932373 3.743933439254761 16.64816665649414 1.920583844184875 14.97214984893799 0.8647467494010925 Z" fill="#fd7b38" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jd3rlp =
    '<svg viewBox="148.0 124.0 56.1 60.0" ><path transform="translate(148.0, 124.0)" d="M 39.62037658691406 59.99998474121094 L 16.45215606689453 59.99998474121094 C 6.764063358306885 59.99998474121094 0 53.31978225708008 0 43.75633239746094 L 0 16.24365043640137 C 0 6.676139831542969 6.764063358306885 0 16.45215606689453 0 L 39.62037658691406 0 C 49.30846786499023 0 56.07253265380859 6.676139831542969 56.07253265380859 16.24365043640137 L 56.07253265380859 43.75633239746094 C 56.07253265380859 53.31978225708008 49.30846786499023 59.99998474121094 39.62037658691406 59.99998474121094 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
