import 'package:flutter/material.dart';
import '../../config/images_assets.dart';
import '../../config/text_style.dart';

class NoFoundScreen extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData iconData;
  final bool isSearchingForNode;
  const NoFoundScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.iconData,
    this.isSearchingForNode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isSearchingForNode == false
              ? const SizedBox(height: 100)
              : Image.asset(height: 200, width: 200, ImagesAssets.bleGif),
          isSearchingForNode == true ? const SizedBox(height: 0) : Icon(iconData, size: 50, color: Colors.blueAccent),
          const SizedBox(height: 10),
          Text(title, style: TextStyles.defaultStyle.bold.blueTextColor),
          const SizedBox(height: 10),
          Text(subTitle, style: TextStyles.defaultStyle.italic.light),
        ],
      ),
    );
  }
}
