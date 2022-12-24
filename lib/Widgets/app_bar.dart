import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/images_path.dart';
import 'package:finwizz_admin/Widgets/responsive.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({BuildContext? context, onPress}) {
  return AppBar(
    toolbarHeight: 70,
    elevation: 0,
    backgroundColor: AppColor.whiteColor,
    title: Row(
      children: [
        Image.asset(
          AppImages.logo,
          height: 50,
          width: 50,
        ),
        Text(
          'ADMIN PANEL',
          style: TextStyle(
            color: AppColor.blackColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
    leading: Responsive.isMobile(context!)
        ? IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.menu,
              color: AppColor.blackColor,
            ),
          )
        : const SizedBox(),
    actions: [
      Center(
        child: Text(
          'Hello, Admin',
          style: TextStyle(
            wordSpacing: 2,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w400,
            fontSize: 21,
          ),
        ),
      ),
      const SizedBox(
        width: 100,
      )
    ],
  );
}
