import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/locator.dart';
import 'package:news_app/src/config/constants/constants.dart';
import 'package:news_app/src/config/themes/app_theme.dart';
import 'package:news_app/src/core/controllers/category_provider.dart';
import 'package:news_app/src/core/models/category_model.dart';
import 'package:news_app/src/utils/custom_widgets/button.dart';
import 'package:news_app/src/utils/custom_widgets/loading.dart';
import 'package:news_app/src/utils/utilities/global_var.dart';
import 'package:provider/provider.dart';
import '../../../../main_imports.dart';

class AddCategoryPage extends StatefulWidget {
  static const String routeName = '/AddCategoryPage';

  final CategoryModel item;
  const AddCategoryPage(this.item);
  @override
  _AddCategoryPageState createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  @override
  Widget build(BuildContext context) {
    String title = widget.item.id == null ? str.main.add : str.formAndAction.update;
    CategoryProvider provider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$title Category'),
      ),
      body: SafeArea(
        child: FullScreenLoading(
          inAsyncCall: provider.isBusy,
          child: ListView(
            padding: AppTheme.standardPadding,
            children: [
              TextFormField(
                initialValue: widget.item.name,
                keyboardType: TextInputType.name,
                decoration: AppTheme.getTextFieldDecoration(lable: str.formAndAction.title),
                onChanged: (value) {
                  widget.item.name = value;
                },
              ),
              context.addHeight(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonWidget(
                    text: 'pick Image',
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? res = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
                      if (res != null) {
                        widget.item.image = Blob(await res.readAsBytes());
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: widget.item.image == null ? Image.asset(kNoImage) : Image.memory(widget.item.image!.bytes),
                  )
                ],
              ),
              context.addHeight(32),
              ButtonWidget(
                text: str.formAndAction.save,
                onPressed: () async {
                  CategoryProvider categoryProvider = locator<CategoryProvider>();
                  if (widget.item.id == null) {
                    await categoryProvider.add(widget.item);
                  } else {
                    await categoryProvider.update(widget.item);
                  }
                  context.pop();
                },
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                margin: EdgeInsets.zero,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
