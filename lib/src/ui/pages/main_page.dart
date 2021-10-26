import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:news_app/src/config/themes/app_theme.dart';
import 'package:news_app/src/ui/pages/dashboard/dashboard_page.dart';
import 'package:news_app/src/utils/custom_widgets/button.dart';
import 'package:news_app/src/utils/custom_widgets/dropdown_widget.dart';
import 'setting_page.dart';
import '../../../main_imports.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = '/MainPage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String val = '4';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
        actions: [
          IconButton(onPressed: () => context.navigateName(SettingPage.routeName), icon: const Icon(Icons.settings)),
          IconButton(onPressed: () => context.navigateName(DashboardPage.routeName), icon: const Icon(Icons.dashboard_outlined)),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: 'widget.item.title',
                    keyboardType: TextInputType.name,
                    decoration: AppTheme.getTextFieldDecoration(lable: 'title'),
                  ),
                ),
                Expanded(
                  child: Theme(
                    data: ThemeData.dark(),
                    child: DropDownWidget<String>(
                      dataList: ['4', '5'],
                      initValue: val,
                      onChange: (item) => log(item),
                      buttonShape: true,
                      selectedTextStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            ButtonWidget(
              text: 'dd',
              onPressed: () {
                for (var i = 0; i < 15; i++) {
                  log(DateTime.now().microsecondsSinceEpoch.toString());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
