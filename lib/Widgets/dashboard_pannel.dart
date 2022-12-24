import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/dashboard_panel_tabs.dart';
import 'package:finwizz_admin/Widgets/images_path.dart';
import 'package:finwizz_admin/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tiles.dart';

class DashBoardPanel extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;

  DashBoardPanel({super.key, required this.drawerKey});

  /// update __icon__ and __text__ color when button is pressed in
  /// dashboard panel
  ///
  /// default color white
  Color _updateColor(Rx<DashBoardPanelScreens> currentScreen,
      DashBoardPanelScreens dashBoardPanelScreens,
      {required BuildContext context}) {
    if (currentScreen.value == dashBoardPanelScreens) {
      return AppColor.whiteColor;
    }
    return AppColor.whiteColor;
  }

  final double iconHeight = 22;
  BorderRadius borderRadius = const BorderRadius.only(
    bottomRight: Radius.circular(100),
    topRight: Radius.circular(100),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: AppColor.mainColor,
      child: GetX<DashBoardController>(
        init: DashBoardController(),
        builder: (controller) => Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            MouseRegion(
              onEnter: (e) {
                controller.updateHover(true);
              },
              onExit: (e) {
                controller.updateHover(false);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.dashboard
                      ? AppColor.selectColor
                      : controller.hover.value == true
                          ? AppColor.selectColor
                          : Colors.transparent,
                  borderRadius: borderRadius,
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.dashboard,
                      height: iconHeight,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.dashboard,
                      context: context),
                  titleMessage: "Dashboard",
                  onTap: () {
                    controller.currentScreen.value =
                        DashBoardPanelScreens.dashboard;
                    drawerKey.currentState!.closeDrawer();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MouseRegion(
              onEnter: (e) {
                controller.updateHover1(true);
              },
              onExit: (e) {
                controller.updateHover1(false);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.company
                      ? AppColor.selectColor
                      : controller.hover1.value == true
                          ? AppColor.selectColor
                          : Colors.transparent,
                  borderRadius: borderRadius,
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.company,
                      height: iconHeight,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.company,
                      context: context),
                  titleMessage: "Company",
                  onTap: () {
                    controller.currentScreen.value =
                        DashBoardPanelScreens.company;
                    drawerKey.currentState!.closeDrawer();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MouseRegion(
              onEnter: (e) {
                controller.updateHover2(true);
              },
              onExit: (e) {
                controller.updateHover2(false);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.newsCategories
                      ? AppColor.selectColor
                      : controller.hover2.value == true
                          ? AppColor.selectColor
                          : Colors.transparent,
                  borderRadius: borderRadius,
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.news,
                      height: iconHeight,
                      color: AppColor.whiteColor,
                    ),
                  ),
                  textColor: _updateColor(controller.currentScreen,
                      DashBoardPanelScreens.newsCategories,
                      context: context),
                  titleMessage: "News Categories",
                  onTap: () {
                    controller.currentScreen.value =
                        DashBoardPanelScreens.newsCategories;
                    drawerKey.currentState!.closeDrawer();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MouseRegion(
              onEnter: (e) {
                controller.updateHover3(true);
              },
              onExit: (e) {
                controller.updateHover3(false);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.news
                      ? AppColor.selectColor
                      : controller.hover3.value == true
                          ? AppColor.selectColor
                          : Colors.transparent,
                  borderRadius: borderRadius,
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.news,
                      color: AppColor.whiteColor,
                      height: iconHeight,
                    ),
                  ),
                  titleMessage: "News",
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.news,
                      context: context),
                  onTap: () {
                    controller.currentScreen.value = DashBoardPanelScreens.news;
                    drawerKey.currentState!.closeDrawer();
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MouseRegion(
              onEnter: (e) {
                controller.updateHover4(true);
              },
              onExit: (e) {
                controller.updateHover4(false);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.movers
                      ? AppColor.selectColor
                      : controller.hover4.value == true
                          ? AppColor.selectColor
                          : Colors.transparent,
                  borderRadius: borderRadius,
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.news,
                      color: AppColor.whiteColor,
                      height: iconHeight,
                    ),
                  ),
                  titleMessage: "Movers",
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.movers,
                      context: context),
                  onTap: () {
                    drawerKey.currentState!.closeDrawer();
                    controller.currentScreen.value =
                        DashBoardPanelScreens.movers;
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MouseRegion(
              onEnter: (e) {
                controller.updateHover5(true);
              },
              onExit: (e) {
                controller.updateHover5(false);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: controller.currentScreen.value ==
                          DashBoardPanelScreens.contactUs
                      ? AppColor.selectColor
                      : controller.hover5.value == true
                          ? AppColor.selectColor
                          : Colors.transparent,
                  borderRadius: borderRadius,
                ),
                child: CustomTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(
                      AppImages.connectUs,
                      color: AppColor.whiteColor,
                      height: iconHeight,
                    ),
                  ),
                  titleMessage: "Contact Us",
                  textColor: _updateColor(
                      controller.currentScreen, DashBoardPanelScreens.contactUs,
                      context: context),
                  onTap: () {
                    drawerKey.currentState!.closeDrawer();
                    controller.currentScreen.value =
                        DashBoardPanelScreens.contactUs;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
