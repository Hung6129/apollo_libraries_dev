import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../../config/text_style.dart';
import '../../../../../widget/app_bar.dart';
import '../../../../../widget/fab_widget.dart';
import '../../../screen/details/provisioner/provisioner_detail.dart';
import 'package:flutter/material.dart';
import '../../../../../../config/palettes.dart';

class ProvisionerScreen extends StatefulWidget {
  final IMeshNetwork meshNetwork;

  final MeshManagerApi meshManagerApi;
  const ProvisionerScreen({
    Key? key,
    required this.meshManagerApi,
    required this.meshNetwork,
  }) : super(key: key);

  @override
  State<ProvisionerScreen> createState() => _ProvisionerScreenState();
}

class _ProvisionerScreenState extends State<ProvisionerScreen> {
  late List<Provisioner> provisioners = [];
  @override
  void initState() {
    super.initState();
    widget.meshNetwork.provisioners.then((value) => setState(() => provisioners = value));
  }

  @override
  void didUpdateWidget(covariant ProvisionerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.meshNetwork.provisioners.then((value) => setState(() => provisioners = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: false,
        title: "Provisioner",
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: provisioners.length,
        itemBuilder: (context, index) {
          return Slidable(
            enabled: provisioners[index].lastSelected == true ? false : true,
            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) async {
                    final meshNetwork = widget.meshManagerApi.meshNetwork;
                    await meshNetwork!.removeProvisioner(provisioners[index].provisionerUuid);
                    widget.meshNetwork.provisioners.then((value) => setState(() => provisioners = value));
                  },
                  backgroundColor: Palettes.p7,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_sweep_rounded,
                  label: 'Xoá',
                ),
              ],
            ),
            child: GestureDetector(
                // chuyển sang trang cấu hình
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ProvisionerDetail(
                          provisioner: provisioners[index],
                        ),
                      ),
                    ),
                child: ListTile(
                  leading: provisioners[index].lastSelected == true
                      ? const Icon(
                          Icons.key_rounded,
                          color: Palettes.p7,
                        )
                      : const Icon(
                          Icons.note,
                          color: Palettes.p7,
                        ),
                  subtitle: Text(
                    '0x${provisioners[index].provisionerAddress.toRadixString(16).padLeft(4, "0")}',
                    style: TextStyles.defaultStyle.regular,
                  ),
                  title: Text(
                    provisioners[index].provisionerName,
                    style: TextStyles.defaultStyle.fontTitle,
                  ),
                )),
          );
        },
      ),
      floatingActionButton: FabWidget(
          voidCallBack: () async {
            final meshNetwork = widget.meshManagerApi.meshNetwork;
            await meshNetwork!.addProvisioner(0x0888, 0x02F6, 0x0888, 5);
            widget.meshNetwork.provisioners.then((value) => setState(() => provisioners = value));
          },
          title: 'Thêm Provisioner mới'),
    );
  }
}
