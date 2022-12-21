import 'package:flutter/material.dart';

import '../../config/palettes.dart';
import '../../config/text_style.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final bool centerTitle;
  final List<Widget> listAction;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.centerTitle,
    this.listAction = const [],
    this.subTitle = "",
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: widget.subTitle == ""
          ? Text(
              widget.title,
              style: TextStyles.defaultStyle.fontHeader.whiteTextColor,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyles.defaultStyle.fontHeader.whiteTextColor,
                ),
                Text(
                  widget.subTitle,
                  style: TextStyles.defaultStyle.whiteTextColor,
                ),
              ],
            ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: Palettes.gradientAppBar),
      ),
      centerTitle: widget.centerTitle,
      actions: widget.listAction,
    );
  }
}
