import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void snackBarGet(
  String message, {
  String? title,
  SnackPosition snackPosition = SnackPosition.TOP,
  int seconds = 2,
  int maxLines = 1,
  TextStyle? textStyle,
  Color snackBarBackGroundColor = Colors.red,
  double width = 300,
}) {
  Get.snackbar(
    "",
    "",
    maxWidth: width,
    messageText: Text(message,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: textStyle ??
            TextStyle(
              color: AppColor.whiteColor,
              fontSize: 14,
            )),
    snackPosition: snackPosition,
    backgroundColor: snackBarBackGroundColor,
    borderRadius: 20,
    margin: const EdgeInsets.all(15),
    colorText: AppColor.whiteColor,
    duration: Duration(seconds: seconds),
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
