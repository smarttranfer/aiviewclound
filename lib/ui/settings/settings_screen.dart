import 'package:aiviewcloud/ui/account_management/widget/item_account.dart';
import 'package:aiviewcloud/ui/settings/page/feedback_page.dart';
import 'package:aiviewcloud/utils/locale/app_localization.dart';
import 'package:aiviewcloud/utils/routes/routes.dart';
import 'package:aiviewcloud/widgets/drawer_widget.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff212529),
      drawer: SMEDrawer(),
      body: ScreenWidget(
        widget: Container(
          child: Column(
            children: [
              ItemAccount(
                onClick: () {
                  Navigator.of(context).pushNamed(Routes.securityPage);
                },
                title: AppLocalizations.of(context).translate('account_secure'),
                icon: SvgPicture.string(
                  security,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                ),
              ),
              ItemAccount(
                onClick: () {
                  Navigator.of(context).pushNamed(Routes.helpPage);
                },
                title: AppLocalizations.of(context).translate('help'),
                icon: SvgPicture.string(
                  help,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                ),
              ),
              ItemAccount(
                onClick: () {
                  Navigator.of(context).pushNamed(Routes.LoginInfoScreen);
                },
                title: AppLocalizations.of(context).translate('CloudPlay'),
                icon: SvgPicture.string(
                  cloudplay,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                ),
              ),
              ItemAccount(
                onClick: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedbackPage()));
                },
                title: AppLocalizations.of(context).translate('reply'),
                icon: SvgPicture.string(
                  feedback,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                ),
              ),
              ItemAccount(
                onClick: () {
                  Navigator.of(context).pushNamed(Routes.LoginInfoScreen);
                },
                title: AppLocalizations.of(context).translate('addition_info'),
                icon: SvgPicture.string(
                  more_info,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                ),
              ),
              ItemAccount(
                onClick: () {
                  Navigator.of(context).pushNamed(Routes.LoginInfoScreen);
                },
                title: AppLocalizations.of(context).translate('inteface'),
                icon: SvgPicture.string(
                  theme,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                ),
              ),
              ItemAccount(
                onClick: () {
                  Navigator.of(context).pushNamed(Routes.language);
                },
                title: AppLocalizations.of(context).translate('language'),
                icon: SvgPicture.string(
                  language,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        headerText: AppLocalizations.of(context).translate('setting'),
        isDrawer: true,
      ),
    );
  }
}

const String security =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <rect width="24" height="24" rx="12" fill="#FD7B38"/><path d="M11.8 18C11.8 18 16.6 15.6 16.6 12V7.8L11.8 6L7 7.8V12C7 15.6 11.8 18 11.8 18Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M9.5 11.5L11 13L14 10" stroke="white" stroke-width="1.5"/></svg>';
const String help =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <rect width="24" height="24" rx="12" fill="#FD413C"/><path d="M12 18C8.6878 17.9964 6.00364 15.3122 6 12V11.88C6.06596 8.58273 8.78075 5.95678 12.0784 6.00054C15.376 6.04429 18.0202 8.74134 17.9987 12.0392C17.9771 15.3371 15.2979 17.9993 12 18ZM11.9904 16.8H12C14.65 16.7974 16.7965 14.6476 16.7952 11.9976C16.7939 9.34758 14.6452 7.20001 11.9952 7.20001C9.34517 7.20001 7.19652 9.34758 7.1952 11.9976C7.19387 14.6476 9.34037 16.7974 11.9904 16.8ZM12.6 15.6H11.4V14.4H12.6V15.6ZM12.6 13.8H11.4C11.381 13.0186 11.7877 12.2885 12.462 11.8932C12.858 11.5896 13.2 11.328 13.2 10.8C13.2 10.1373 12.6627 9.60001 12 9.60001C11.3373 9.60001 10.8 10.1373 10.8 10.8H9.6V10.746C9.60964 9.88857 10.076 9.10141 10.8234 8.68105C11.5708 8.26068 12.4856 8.27098 13.2234 8.70805C13.9611 9.14512 14.4096 9.94257 14.4 10.8C14.357 11.4474 14.0098 12.0362 13.464 12.387C12.9706 12.6967 12.6508 13.2197 12.6 13.8Z" fill="white" stroke="white" stroke-width="0.3"/></svg>';
const String cloudplay =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <rect width="24" height="24" rx="12" fill="#4AA541"/><path d="M9.00047 15.95C7.36353 15.9509 5.99458 14.7252 5.86061 13.1257C5.72856 11.5491 6.84093 10.1403 8.41978 9.85244C9.16504 8.61397 10.5262 7.85186 11.9985 7.85003M9.00047 15.95L15.4971 15.8L15.4968 15.95M9.00047 15.95L15.4968 15.95M9.00047 15.95L15.4968 15.95M11.9985 7.85003C12.932 7.84674 13.8391 8.1541 14.5701 8.72205C15.2613 9.25691 15.7607 9.99183 15.9969 10.8207C17.3134 11.0651 18.2458 12.2392 18.1422 13.5603C18.036 14.9133 16.8798 15.9521 15.4971 15.95C15.497 15.95 15.4969 15.95 15.4968 15.95M11.9985 7.85003C11.9984 7.85003 11.9984 7.85003 11.9983 7.85003L11.9989 8.00003L11.9987 7.85003C11.9986 7.85003 11.9986 7.85003 11.9985 7.85003ZM11.999 9.12504L11.9991 9.12504C13.3094 9.1227 14.4484 9.99238 14.763 11.2268L14.763 11.2269L14.924 11.8567L14.9486 11.9533L15.0473 11.968L15.7047 12.0654C15.7047 12.0654 15.7047 12.0654 15.7048 12.0654C16.4046 12.1707 16.8977 12.7823 16.8439 13.4631C16.79 14.1444 16.2059 14.6757 15.4972 14.675H15.4971H9.0005C8.03677 14.672 7.24128 13.9504 7.16348 13.0213C7.08571 12.0926 7.75003 11.2553 8.69994 11.0999C8.70004 11.0999 8.70014 11.0999 8.70024 11.0999L9.17391 11.0244L9.24486 11.0131L9.28052 10.9507L9.51406 10.5423C9.51412 10.5422 9.51418 10.5421 9.51424 10.542C10.019 9.66876 10.9678 9.12623 11.999 9.12504Z" fill="white" stroke="white" stroke-width="0.3"/></svg>';
const String feedback =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <rect width="24" height="24" rx="12" fill="#4AA541"/><path d="M7.51385 12.0551L7.51386 12.0551L7.51358 12.0539L7.51167 12.0454L7.4141 12.0673L7.51167 12.0454C7.46059 11.8176 7.43333 11.5795 7.43333 11.3333V10.6667C7.43333 8.88095 8.88095 7.43333 10.6667 7.43333H13.3333C15.1191 7.43333 16.5667 8.88095 16.5667 10.6667V11.3333C16.5667 13.1191 15.1191 14.5667 13.3333 14.5667H12H11.9V14.6667V15.774L9.68353 14.7665C8.5588 14.2553 7.76403 13.2429 7.51564 12.0636L7.51385 12.0551ZM13.292 18.091L13.4333 18.1553V18V16.099C16.0197 16.0457 18.1 13.9325 18.1 11.3333V10.6667C18.1 8.03411 15.9659 5.9 13.3333 5.9H10.6667C8.03411 5.9 5.9 8.03411 5.9 10.6667V11.3333C5.9 11.6929 5.93983 12.0433 6.01537 12.3803C6.36308 14.0301 7.47473 15.4468 9.04904 16.1624L13.292 18.091Z" fill="white" stroke="white" stroke-width="0.2"/></svg>';
const String more_info =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <rect width="24" height="24" rx="12" fill="#E37238"/><circle cx="12" cy="12" r="5.25" stroke="white" stroke-width="1.5"/><path d="M12 9V13" stroke="white" stroke-width="1.5"/><path d="M12 14V15" stroke="white" stroke-width="1.5"/></svg>';
const String theme =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"> <rect width="24" height="24" rx="12" fill="#E37238"/><path d="M10.3333 18H6.33333C5.59695 18 5 17.403 5 16.6667V10C5 9.26362 5.59695 8.66667 6.33333 8.66667H7V7.33333C7 6.59695 7.59695 6 8.33333 6H17C17.7364 6 18.3333 6.59695 18.3333 7.33333V14.6667C18.3333 15.403 17.7364 16 17 16H11.6667V16.6667C11.6667 17.403 11.0697 18 10.3333 18ZM6.33333 10V16.6667H10.3333V10H6.33333ZM8.33333 8.66667H10.3333C11.0697 8.66667 11.6667 9.26362 11.6667 10V14.6667H17V7.33333H8.33333V8.66667Z" fill="white"/></svg>';
const String language =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect width="24" height="24" rx="12" fill="#4AA541"/><path d="M12 17.8337C15.2217 17.8337 17.8333 15.222 17.8333 12.0003C17.8333 8.77866 15.2217 6.16699 12 6.16699C8.77834 6.16699 6.16667 8.77866 6.16667 12.0003C6.16667 15.222 8.77834 17.8337 12 17.8337Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M6.16667 12H17.8333" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M12 6.16699C13.4591 7.76436 14.2883 9.83735 14.3333 12.0003C14.2883 14.1633 13.4591 16.2363 12 17.8337C10.5409 16.2363 9.71173 14.1633 9.66667 12.0003C9.71173 9.83735 10.5409 7.76436 12 6.16699V6.16699Z" stroke="white" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>';
