import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/custom_widgets/button.dart';
import 'test_provider.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({
    Key? key,
    required this.blocContext,
    required this.index,
  }) : super(key: key);

  final BuildContext blocContext;
  final int index;

  static MaterialPageRoute<void> route(BuildContext context, int id) => MaterialPageRoute(
        builder: (_) => ItemDetailsScreen(blocContext: context, index: id),
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Provider.of<TestProvider>(blocContext),
      child: _ItemDetailsScreen(index: index),
    );
  }
}

class _ItemDetailsScreen extends StatefulWidget {
  const _ItemDetailsScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<_ItemDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Consumer<TestProvider>(
        builder: (context, value, child) {
          return Center(
            child: Column(
              children: [
                Text(
                  value.dateList[widget.index].toString(),
                  style: const TextStyle(fontSize: 55),
                ),
                ButtonWidget(
                    text: 'update',
                    onPressed: () {
                      value.update(widget.index, 44444);
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
