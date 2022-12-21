import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/text_style.dart';
import '../../../../../widget/app_bar.dart';

class ProvisionerDetail extends StatefulWidget {
  final Provisioner provisioner;
  const ProvisionerDetail({Key? key, required this.provisioner}) : super(key: key);

  @override
  State<ProvisionerDetail> createState() => _ProvisionerDetailState();
}

class _ProvisionerDetailState extends State<ProvisionerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: false,
        title: widget.provisioner.provisionerName,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: Text("Edit ${widget.provisioner.provisionerName}",
                style: TextStyles.defaultStyle.bold.fontTitle.redTextColor),
          ),
          ListTile(
            leading: const Icon(Icons.label_important_rounded),
            title: Text("Tên", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.provisioner.provisionerName, style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.label_important_rounded),
            title: Text("In Use", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.provisioner.lastSelected.toString(), style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text("Thời gian để sống", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.provisioner.globalTtl.toString(), style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            leading: const Icon(Icons.view_agenda),
            title: Text("Địa chỉ Unicast", style: TextStyles.defaultStyle.bold),
            subtitle: Text('0x${widget.provisioner.provisionerAddress.toRadixString(16).padLeft(4, "0")}',
                style: TextStyles.defaultStyle.regular),
          ),
          // ListTile(
          //   leading: const Icon(Icons.app_registration),
          //   title: Text("Provisioner uuid", style: TextStyles.defaultStyle.bold),
          //   subtitle: Text(widget.provisioner.lastSelected.toString(), style: TextStyles.defaultStyle.regular),
          // ),
          ListTile(
            title: Text("Unicast", style: TextStyles.defaultStyle.bold),
            subtitle:
                Text(widget.provisioner.allocatedUnicastRanges.toString(), style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            title: Text("Địa chỉ nhóm", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.provisioner.allocatedGroupRanges.toString(), style: TextStyles.defaultStyle.regular),
          ),
          ListTile(
            title: Text("Ngữ cảnh", style: TextStyles.defaultStyle.bold),
            subtitle: Text(widget.provisioner.allocatedSceneRanges.toString(), style: TextStyles.defaultStyle.regular),
          ),
        ],
      )),
    );
  }
}
