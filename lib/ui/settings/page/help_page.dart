import 'package:aiviewcloud/ui/settings/widget/item_security.dart';
import 'package:aiviewcloud/widgets/screen_widget.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  Widget body() {
    return Column(
      children: [
        ItemSecurity(
          title: 'Câu hỏi 1',
          switchButton: true,
          type: optionType.DELETE_ACCOUNT,
        ),
        ItemSecurity(
          title: 'Câu hỏi 2',
          switchButton: false,
          type: optionType.DELETE_ACCOUNT,
        ),
        ItemSecurity(
          title: 'Câu hỏi 3',
          switchButton: false,
          type: optionType.DELETE_ACCOUNT,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff212529),
        body: ScreenWidget(
          widget: body(),
          headerText: 'Thông tin trợ giúp',
        ));
  }
}
