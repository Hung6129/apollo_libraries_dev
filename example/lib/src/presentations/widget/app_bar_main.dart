import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';

import '../../config/palettes.dart';
import '../../config/strings.dart';
import '../../config/text_style.dart';
import '../screen/devices/screen/scanning_provisioned_screen.dart';

class CustomAppBarMain extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final NordicNrfMesh nrfMesh;
  final bool isMainBar;
  final String subTitle;
  const CustomAppBarMain({
    Key? key,
    required this.nrfMesh,
    required this.title,
    required this.centerTitle,
    this.isMainBar = true,
    this.subTitle = "",
  }) : super(key: key);

  @override
  State<CustomAppBarMain> createState() => _CustomAppBarMainState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 55);
}

class _CustomAppBarMainState extends State<CustomAppBarMain> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.isMainBar == true
          ? Text(
              widget.title,
              style: TextStyles.defaultStyle.fontHeader.whiteTextColor.bold.textSpacing(1),
            )
          : Column(
              children: [
                Text(
                  widget.title,
                  style: TextStyles.defaultStyle.fontHeader.whiteTextColor.bold.textSpacing(1),
                ),
                Text(
                  widget.subTitle,
                  style: TextStyles.defaultStyle.whiteTextColor,
                )
              ],
            ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: Palettes.gradientAppBar),
      ),
      centerTitle: widget.centerTitle,
      actions: [
        widget.isMainBar == true
            ? TextButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
                      return ProvisionedDevices(nordicNrfMesh: widget.nrfMesh);
                    })),
                child: Text(Strings.connect, style: TextStyles.defaultStyle.bold.whiteTextColor))
            : const SizedBox()
      ],
    );
  }
}
