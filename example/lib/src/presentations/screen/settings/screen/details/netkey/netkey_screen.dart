import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../../config/palettes.dart';
import '../../../../../../config/text_style.dart';
import '../../../../../../data/model/mesh_network/mesh_data.dart';
import '../../../../../widget/app_bar.dart';
import 'netkey_detail.dart';

class NetkeyScreen extends StatefulWidget {
  final List<NetKeys> netKey;
  final MeshManagerApi meshManagerApi;
  const NetkeyScreen({Key? key, required this.netKey, required this.meshManagerApi}) : super(key: key);

  @override
  State<NetkeyScreen> createState() => _NetkeyScreenState();
}

class _NetkeyScreenState extends State<NetkeyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(centerTitle: false, title: "NetKeys"),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: widget.netKey.length,
        itemBuilder: (context, index) {
          return Slidable(
            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) async {
                    // final meshNetwork = widget.meshManagerApi.meshNetwork;
                    // await meshNetwork!.removeProvisioner(provisioners[index].provisionerUuid);
                    // widget.meshNetwork.provisioners.then((value) => setState(() => provisioners = value));
                  },
                  backgroundColor: Palettes.p7,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_sweep_rounded,
                  label: 'Xoá',
                ),
              ],
            ),
            child: InkWell(
                // chuyển sang trang cấu hình
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => NetkeyDetail(
                          netKey: widget.netKey[index],
                        ),
                      ),
                    ),
                child: ListTile(
                  leading: const Icon(Icons.language_rounded),
                  subtitle: Text(
                    widget.netKey[index].key.toString(),
                    style: TextStyles.defaultStyle.regular,
                  ),
                  title: Text(
                    widget.netKey[index].name!,
                    style: TextStyles.defaultStyle.fontTitle,
                  ),
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Thêm Netkey mới'),
        icon: const Icon(CupertinoIcons.add),
        onPressed: () async {
          // final iMeshNet = widget.meshManagerApi.meshNetwork;
          // iMeshNet!.addProvisioner(0x0002, 123456, 123456, 123, name: "HungNguyen");
          // setState(() {});
        },
      ),
    );
  }
}
