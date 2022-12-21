import 'package:flutter/material.dart';
import '../../../../../../config/text_style.dart';
import '../../../../../../data/model/mesh_network/mesh_data.dart';
import '../../../../../widget/app_bar.dart';

class AppkeyDetail extends StatefulWidget {
  final AppKeys appKeys;
  const AppkeyDetail({Key? key, required this.appKeys}) : super(key: key);

  @override
  State<AppkeyDetail> createState() => _AppkeyDetailState();
}

class _AppkeyDetailState extends State<AppkeyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.appKeys.name!, centerTitle: false),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: Text("Edit ${widget.appKeys.name!}", style: TextStyles.defaultStyle.bold.fontTitle.redTextColor),
          ),
          ListTile(
            leading: const Icon(Icons.label_important_rounded),
            title: Text("Tên", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.appKeys.name!, style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.numbers),
            title: Text("Key Index", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.appKeys.index.toString(), style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.key),
            title: Text("Key", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.appKeys.key.toString(), style: TextStyles.defaultStyle.regular),
          ),
        ],
      )),
    );
  }
}
