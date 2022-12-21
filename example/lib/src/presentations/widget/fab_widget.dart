import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FabWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? voidCallBack;
  const FabWidget({
    Key? key,
    required this.voidCallBack,
    required this.title,
    this.iconData = CupertinoIcons.add,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      onPressed: voidCallBack,
      child: Icon(iconData),
    );
  }
}
