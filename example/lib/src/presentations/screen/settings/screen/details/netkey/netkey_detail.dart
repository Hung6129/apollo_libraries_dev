import 'package:flutter/material.dart';

import '../../../../../../config/text_style.dart';
import '../../../../../../data/model/mesh_network/mesh_data.dart';
import '../../../../../widget/app_bar.dart';

class NetkeyDetail extends StatefulWidget {
  final NetKeys netKey;
  const NetkeyDetail({Key? key, required this.netKey}) : super(key: key);

  @override
  State<NetkeyDetail> createState() => _NetkeyDetailState();
}

class _NetkeyDetailState extends State<NetkeyDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: widget.netKey.name!,
        // subTitle: widget.netKey.key!,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: Text("Edit ${widget.netKey.name!}", style: TextStyles.defaultStyle.bold.fontTitle.redTextColor),
          ),
          ListTile(
            leading: const Icon(Icons.label_important_rounded),
            title: Text("Tên", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.netKey.name!, style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.numbers_rounded),
            title: Text("Key Index", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.netKey.index.toString(), style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: Text("Security", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.netKey.minSecurity.toString(), style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text("Chỉnh sửa lần cuối", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.netKey.timestamp.toString(), style: TextStyles.defaultStyle.regular),
          ),
        ],
      )),
    );
  }
}
