import 'package:flutter/material.dart';

import '../../../../config/text_style.dart';

class CardItemDeviceDetail extends StatelessWidget {
  final String subTitle;
  final String titleString;
  final IconData iconData;
  final Function()? onTap;
  const CardItemDeviceDetail({
    Key? key,
    required this.subTitle,
    required this.titleString,
    required this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        leading: Icon(iconData),
        title: Text(titleString,style: TextStyles.defaultStyle.bold,),
        subtitle: Text(subTitle,style: TextStyles.defaultStyle.italic),
      ),
    );
  }
}
