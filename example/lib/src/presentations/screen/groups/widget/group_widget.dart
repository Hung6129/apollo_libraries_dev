import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/palettes.dart';
import '../../../../config/text_style.dart';
import '../group_detail.dart';

class GroupWidget extends StatefulWidget {
  final GroupData group;
  final IMeshNetwork meshNetWork;
  const GroupWidget({Key? key, required this.group, required this.meshNetWork}) : super(key: key);

  @override
  State<GroupWidget> createState() => _GroupWidgetState();
}

class _GroupWidgetState extends State<GroupWidget> {
  List<ElementData> _elements = [];

  @override
  void initState() {
    super.initState();
    widget.meshNetWork.elementsForGroup(widget.group.address).then((value) => setState(() => _elements = value));
  }

  @override
  void didUpdateWidget(covariant GroupWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.meshNetWork.elementsForGroup(widget.group.address).then((value) => setState(() => _elements = value));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // xoá nhóm
      onLongPress: () {
        Get.bottomSheet(
          SizedBox(
            height: 150,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Bạn muốn ?',
                  style: TextStyles.defaultStyle.fontHeader.redTextColor.bold,
                ),
                TextButton(
                    onPressed: () async {
                      await widget.meshNetWork.removeGroup(widget.group.address);
                      Get.back();
                      setState(() {});
                      Get.snackbar(
                        "Cập nhật",
                        "Xoá nhóm ${widget.group.name} thành công",
                        icon: const Icon(Icons.done, color: Colors.green),
                        backgroundColor: Colors.white,
                        snackPosition: SnackPosition.TOP,
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        duration: const Duration(seconds: 2),
                        isDismissible: true,
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Palettes.p7,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Xoá nhóm',
                          style: TextStyles.defaultStyle.redTextColor,
                        ),
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        const Icon(
                          Icons.auto_fix_high_sharp,
                          color: Palettes.p8,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Chỉnh sửa tên nhóm',
                          style: TextStyles.defaultStyle.blueTextColor,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        );
      },
      // chuyển đến trang cấu hình nhóm
      onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
        return GroupDetailScreen(groupData: widget.group);
      })),
      // hiện thị thông tin name,địa chỉ nhóm
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(gradient: Palettes.gradientCircle, borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tên: ${widget.group.name}',
                style: TextStyles.defaultStyle.bold.medium,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Địa chỉ: 0x${widget.group.address.toRadixString(16)}',
                style: TextStyles.defaultStyle.medium,
              ),
              Text(
                '${_elements.length} thiết bị',
                style: TextStyles.defaultStyle.medium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
