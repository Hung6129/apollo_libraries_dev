import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nordic_nrf_mesh_example/src/config/text_style.dart';

void showCustomSnackBar(
  String title,
  String message,
  Color iconColor,
  IconData iconData, {
  bool isError = false,
}) {
  Get.snackbar(title, message,
      titleText: Text(
        title,
        style: TextStyles.defaultStyle.bold,
      ),
      messageText: Text(
        message,
        style: TextStyles.defaultStyle.light,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      icon: Icon(iconData, color: iconColor),
      backgroundColor: Colors.white);
}
