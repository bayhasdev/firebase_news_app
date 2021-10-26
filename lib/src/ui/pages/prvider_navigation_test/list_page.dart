import 'package:flutter/material.dart';

import '../../../utils/custom_widgets/base_view.dart';
import 'details_screen.dart';
import 'test_provider.dart';

class ListPage extends StatefulWidget {
  static const String routeName = '/ListPage';

  const ListPage({Key? key}) : super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListPage'),
      ),
      body: SafeArea(
        child: BaseView<TestProvider>(
          modelProvider: TestProvider(),
          builder: (context, modelNotifier) {
            return ListView.builder(
              itemCount: modelNotifier.dateList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(ItemDetailsScreen.route(context, index));
                  },
                  trailing: const SizedBox(),
                  title: Text(modelNotifier.dateList[index].toString(), style: const TextStyle(fontSize: 33)),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
