import 'package:adobe_xd/pinned.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:aiviewcloud/models/country/country.dart';
import 'package:aiviewcloud/stores/user/user_store.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/widgets/progress_indicator_widget.dart';
import 'package:aiviewcloud/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'collapse_widget.dart';

class SelectCountryWidget extends StatefulWidget {
  SelectCountryWidget({Key? key}) : super(key: key);

  @override
  _SelectCountryWidgetState createState() => _SelectCountryWidgetState();
}

class _SelectCountryWidgetState extends State<SelectCountryWidget> {
  TextEditingController _searcController = TextEditingController();

  late int expandIndex = -1;
  late int lastIndex = -1;
  late String selectedCountryCode = "";
  late Country? selectedCountry;
  @override
  void initState() {
    super.initState();
  }

  late UserStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = Provider.of<UserStore>(context);
    if (_store.continents == null) {
      _store.getContinents();
    }
  }

  Widget _buildListView() {
    return _store.continents != null
        ? ListView.builder(
            itemCount: _store.continents!.length,
            padding: EdgeInsets.only(top: 0),
            itemBuilder: (context, position) {
              return _buildListItem(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
              style: TextStyle(color: Colors.white),
            ),
          );
  }

  List<Widget> _buildCountryList() {
    return _store.countryList!.coutries!
        .map((e) => _buildCountryListItem(e))
        .toList();
  }

  Widget _buildCountryListItem(Country position) {
    return Column(children: [
      Container(
          height: 49,
          child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCountryCode = (position.code == selectedCountryCode
                      ? ""
                      : position.code)!;
                  selectedCountry = position;
                });
              },
              child: Stack(
                children: [
                  Pinned.fromPins(
                    Pin(end: 0.0, start: 0.0),
                    Pin(size: 17.0, middle: 0.5437),
                    child:
                        // Adobe XD layer: 'Việt Nam' (text)
                        Text(
                      position.name ?? '',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 0, end: 0),
                    Pin(size: 1.0, middle: 1),
                    child:
                        // Adobe XD layer: 'Line 17' (shape)
                        SvgPicture.string(
                      line,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  selectedCountryCode == position.code
                      ? SelectedCountry()
                      : UnSelected()
                ],
              ))),
    ]);
  }

  void getCountryList(code) {
    _store.getCountry({"Code": code});
  }

  Widget _buildListItem(int position) {
    return Column(children: [
      Container(
          height: 49,
          // color: Colors.red,
          // margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: GestureDetector(
              onTap: () {
                if (expandIndex != position && lastIndex != position) {
                  getCountryList(_store.continents!.elementAt(position).code);
                }
                setState(() {
                  expandIndex = position == expandIndex ? -1 : position;
                  lastIndex = position;
                });
              },
              child: Stack(
                children: [
                  Pinned.fromPins(
                    Pin(end: 0.0, start: 0.0),
                    Pin(size: 17.0, middle: 0.5437),
                    child:
                        // Adobe XD layer: 'Việt Nam' (text)
                        Text(
                      _store.continents![position].nameVi,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(start: 0, end: 0),
                    Pin(size: 1.0, middle: 1),
                    child:
                        // Adobe XD layer: 'Line 17' (shape)
                        SvgPicture.string(
                      line,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 8.0, end: 16.0),
                    Pin(size: 16.0, middle: 0.5226),
                    child:
                        // Adobe XD layer: 'Line 21' (shape)
                        SvgPicture.string(
                      next,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),

                  // UnSelected()
                ],
              ))),
      ExpandedSection(
        expand: expandIndex == position,
        child: _store.loading
            ? Container()
            : Column(children: _buildCountryList()),
      )
    ]);
  }

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          )..show(context);
        }
      });
    }

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
// Adobe XD layer: 'Group 6390' (group)
    return Stack(
      children: <Widget>[
        Pinned.fromPins(
          Pin(start: 0.0, end: 0.0),
          Pin(start: 0.0, end: 0.0),
          child:
              // Adobe XD layer: 'Rectangle 1838' (shape)
              Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24.0),
                topRight: Radius.circular(24.0),
              ),
              color: const Color(0xff212529),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x1a000000),
                  offset: Offset(0, 0),
                  blurRadius: 40,
                ),
              ],
            ),
          ),
        ),
        Pinned.fromPins(
          Pin(size: 90.0, middle: 0.5018),
          Pin(size: 6.0, start: 16.0),
          child:
              // Adobe XD layer: 'Rectangle 1839' (shape)
              Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40.0),
              color: const Color(0xffffffff),
            ),
          ),
        ),
        Pinned.fromPins(
          Pin(start: 15.0, end: 15.0),
          Pin(start: 40.0, end: 0.0),
          child:
              // Adobe XD layer: 'Group 6217' (group)
              Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(start: 0.0, end: 2.0),
                Pin(size: 48.0, start: 0.0),
                child:
                    // Adobe XD layer: 'Rectangle 241' (shape)
                    SvgPicture.string(
                  searchBG,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
              Pinned.fromPins(
                  Pin(end: 16.0, start: 16.0), Pin(size: 20.0, start: 24.0),
                  child: TextFieldWidget(
                    hint: AppLocalizations.of(context)
                        .translate('search_country_hint'),
                    textController: _searcController,
                    inputAction: TextInputAction.next,
                    autoFocus: false,
                    onChanged: (value) {},
                    textStyle: TextStyle(
                      fontFamily: 'SFProDisplay-Regular',
                      fontSize: 17,
                      color: const Color(0xff818181),
                    ),
                  )),
              Pinned.fromPins(
                Pin(start: 0.0, end: 0.0),
                Pin(start: 0.0, end: 0.0),
                child: Stack(
                  children: <Widget>[
                    Pinned.fromPins(
                        Pin(start: 0.0, end: 0.0), Pin(end: 100.0, start: 64.0),
                        child: Stack(children: [
                          Observer(
                            builder: (context) {
                              return _buildListView();
                            },
                          ),
                        ])),

                    // Adobe XD layer: 'Group' (group)
                  ],
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
            onTap: () {
              try {
                _store.onSelectedCountry(selectedCountry!);
                Navigator.pop(context);
              } catch (error) {
                _showErrorMessage(AppLocalizations.of(context)
                    .translate('not_choose_country'));
              }
            },
            child: Pinned.fromPins(
              Pin(start: 16.0, end: 16.0),
              Pin(size: 48.0, end: 30.0),
              child:
                  // Adobe XD layer: 'Group 6218' (group)
                  Stack(
                children: <Widget>[
                  Pinned.fromPins(
                    Pin(start: 0.0, end: 0.0),
                    Pin(start: 0.0, end: 0.0),
                    child:
                        // Adobe XD layer: 'Path 1709' (shape)
                        SvgPicture.string(
                      btnBg,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromPins(
                    Pin(size: 58.0, middle: 0.5016),
                    Pin(size: 20.0, middle: 0.4643),
                    child:
                        // Adobe XD layer: 'Xong' (text)
                        Text(
                      AppLocalizations.of(context).translate('done'),
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 17,
                        color: const Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class UnSelected extends StatelessWidget {
  const UnSelected({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinned.fromPins(
      Pin(size: 20.0, end: 16.0),
      Pin(size: 20.0, middle: 0.5),
      child:
          // Adobe XD layer: 'Ellipse 74' (group)
          Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 0.0, end: 0.0),
            child:
                // Adobe XD layer: 'Vector' (shape)
                SvgPicture.string(
              '<svg viewBox="338.0 455.0 20.0 20.0" ><path transform="translate(338.0, 455.0)" d="M 20 10 C 20 15.52284812927246 15.52284812927246 20 10 20 C 4.477152347564697 20 0 15.52284812927246 0 10 C 0 4.477152347564697 4.477152347564697 0 10 0 C 15.52284812927246 0 20 4.477152347564697 20 10 Z" fill="none" stroke="#818181" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
          Pinned.fromPins(
            Pin(start: 0.8, end: 0.8),
            Pin(start: 0.8, end: 0.8),
            child:
                // Adobe XD layer: 'Vector' (shape)
                SvgPicture.string(
              '<svg viewBox="338.8 455.8 18.5 18.5" ><path transform="translate(338.75, 455.75)" d="M 18.5 9.25 C 18.5 14.35863399505615 14.35863399505615 18.5 9.25 18.5 C 4.141366004943848 18.5 0 14.35863399505615 0 9.25 C 0 4.141366004943848 4.141366004943848 0 9.25 0 C 14.35863399505615 0 18.5 4.141366004943848 18.5 9.25 Z" fill="none" stroke="#818181" stroke-width="1.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

class SelectedCountry extends StatelessWidget {
  const SelectedCountry({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Pinned.fromPins(
      Pin(size: 20.0, end: 16.0),
      Pin(size: 20.0, middle: 0.5),
      child:
          // Adobe XD layer: 'Group 6210' (group)
          Stack(
        children: <Widget>[
          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 0.0, end: 0.0),
            child:
                // Adobe XD layer: 'Path 1703' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Vector' (shape)
                      SvgPicture.string(
                    '<svg viewBox="338.0 608.0 20.0 20.0" ><path transform="translate(338.0, 608.0)" d="M 10 1.413226629259141e-29 C 11.97781276702881 -3.33066907387547e-15 13.91121101379395 0.5864897966384888 15.55570220947266 1.685303926467896 C 17.20019340515137 2.784118175506592 18.48192024230957 4.34590482711792 19.23879623413086 6.173165798187256 C 19.99567222595215 8.00042724609375 20.19370651245117 10.01109313964844 19.80785369873047 11.95090293884277 C 19.42200088500977 13.89071273803711 18.4695930480957 15.67254257202148 17.07106781005859 17.07106781005859 C 15.67254257202148 18.4695930480957 13.89071273803711 19.42200088500977 11.95090293884277 19.80785369873047 C 10.01109313964844 20.19370651245117 8.00042724609375 19.99567222595215 6.173165798187256 19.23879623413086 C 4.34590482711792 18.48192024230957 2.784118175506592 17.20019340515137 1.685303926467896 15.55570220947266 C 0.5864897966384888 13.91121101379395 7.216449660063518e-16 11.97781276702881 0 10 C 0 7.347835063934326 1.053568363189697 4.804296016693115 2.928932189941406 2.928932189941406 C 4.804296016693115 1.053568363189697 7.347835063934326 3.108624468950438e-15 10 1.332267629550188e-15 L 10 1.413226629259141e-29 Z" fill="none" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Vector' (shape)
                      SvgPicture.string(
                    '<svg viewBox="338.0 608.0 20.0 20.0" ><path transform="translate(338.0, 608.0)" d="M 10 1.5 C 5.313079833984375 1.5 1.5 5.313079833984375 1.5 10 C 1.5 14.68692016601562 5.313079833984375 18.5 10 18.5 C 14.68692016601562 18.5 18.5 14.68692016601562 18.5 10 C 18.5 5.313079833984375 14.68692016601562 1.5 10 1.5 Z M 10 0 C 15.52285003662109 0 20 4.477149963378906 20 10 C 20 15.52285003662109 15.52285003662109 20 10 20 C 4.477149963378906 20 0 15.52285003662109 0 10 C 0 4.477149963378906 4.477149963378906 0 10 0 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
                    allowDrawingOutsideViewBox: true,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          Pinned.fromPins(
            Pin(size: 6.0, middle: 0.5),
            Pin(size: 6.0, middle: 0.5),
            child:
                // Adobe XD layer: 'Ellipse 104' (shape)
                SvgPicture.string(
              '<svg viewBox="345.0 615.0 6.0 6.0" ><path transform="translate(345.0, 615.0)" d="M 6 3 C 6 4.656854152679443 4.656854152679443 6 3 6 C 1.343145728111267 6 0 4.656854152679443 0 3 C 0 1.343145728111267 1.343145728111267 0 3 0 C 4.656854152679443 0 6 1.343145728111267 6 3 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>',
              allowDrawingOutsideViewBox: true,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}

const String line =
    '<svg viewBox="15.5 488.5 343.0 1.0" ><path transform="translate(15.5, 488.5)" d="M 0 0 L 343 0" fill="none" stroke="#626262" stroke-width="0.5" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String btnBg =
    '<svg viewBox="16.0 730.0 343.0 48.0" ><path transform="translate(16.0, 730.0)" d="M 8 0 L 335 0 C 337.1217346191406 1.110223024625157e-15 339.1565551757812 0.8428548574447632 340.6568603515625 2.343145847320557 C 342.1571655273438 3.843436717987061 343 5.878268241882324 343 8 L 343 40 C 343 42.12173080444336 342.1571655273438 44.15656280517578 340.6568603515625 45.65685272216797 C 339.1565551757812 47.15714263916016 337.1217346191406 48 335 48 L 8 48 C 5.878268241882324 48 3.843436717987061 47.15714263916016 2.343145847320557 45.65685272216797 C 0.8428548574447632 44.15656280517578 1.165734175856414e-15 42.12173080444336 0 40 L 0 8 C 3.885780586188048e-16 5.878268241882324 0.8428548574447632 3.843436717987061 2.343145847320557 2.343145847320557 C 3.843436717987061 0.8428548574447632 5.878268241882324 2.442490654175344e-15 8 4.440892098500626e-16 L 8 0 Z" fill="#fd7b38" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String searchBG =
    '<svg viewBox="15.0 352.0 343.0 48.0" ><path transform="translate(15.0, 352.0)" d="M 8 0 L 335 0 C 339.4182739257812 0 343 3.581721782684326 343 8 L 343 40 C 343 44.41827774047852 339.4182739257812 48 335 48 L 8 48 C 3.581721782684326 48 0 44.41827774047852 0 40 L 0 8 C 0 3.581721782684326 3.581721782684326 0 8 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String next =
    '<svg viewBox="351.0 708.0 8.0 16.0" ><path transform="matrix(0.0, -1.0, 1.0, 0.0, 351.0, 724.0)" d="M 0 0 L 8 8 L 16 0" fill="none" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" /></svg>';
