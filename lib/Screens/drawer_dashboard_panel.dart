import 'package:finwizz_admin/Screens/company/add_company_screen.dart';
import 'package:finwizz_admin/Screens/contact_us/contact_us_screen.dart';
import 'package:finwizz_admin/Screens/dashboard/dashboard_screen.dart';
import 'package:finwizz_admin/Screens/insider/insider_screen.dart';
import 'package:finwizz_admin/Screens/latest_mover/latest_mover_screen.dart';
import 'package:finwizz_admin/Screens/movres/movers_screen.dart';
import 'package:finwizz_admin/Screens/news/add_news_screen.dart';
import 'package:finwizz_admin/Screens/news_categories/news_categories.dart';
import 'package:finwizz_admin/Screens/notification/send_notification%20_screen.dart';
import 'package:finwizz_admin/Screens/notification/user_report.dart';
import 'package:finwizz_admin/Widgets/app_bar.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/dashboard_panel_tabs.dart';
import 'package:finwizz_admin/Widgets/dashboard_pannel.dart';
import 'package:finwizz_admin/Widgets/responsive.dart';
import 'package:finwizz_admin/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bulk_upload/company_bulk_upload_screen.dart';
import 'bulk_upload/latest_movers_bulk_upload_screen.dart';
import 'bulk_upload/news_category_bulk_upload_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.bgColor,
      appBar: customAppBar(
          context: context,
          onPress: () {
            _scaffoldKey.currentState!.openDrawer();
          }),
      drawer: Responsive.isMobile(context)
          ? DashBoardPanel(
              drawerKey: _scaffoldKey,
            )
          : const SizedBox(),
      body: Row(
        children: [
          Responsive.isMobile(context)
              ? const SizedBox()
              : DashBoardPanel(
                  drawerKey: _scaffoldKey,
                ),
          Obx(() {
            return Expanded(
                child: dashBoardController.currentScreen.value ==
                        DashBoardPanelScreens.dashboard
                    ? const DashboardScreen()
                    : dashBoardController.currentScreen.value ==
                            DashBoardPanelScreens.company
                        ? const AddCompanyScreen()
                        : dashBoardController.currentScreen.value ==
                                DashBoardPanelScreens.movers
                            ? const MoversScreen()
                            : dashBoardController.currentScreen.value ==
                                    DashBoardPanelScreens.contactUs
                                ? const ContactUsScreen()
                                : dashBoardController.currentScreen.value ==
                                        DashBoardPanelScreens.newsCategories
                                    ? const AddNewsCategoriesScreen()
                                    : dashBoardController.currentScreen.value ==
                                            DashBoardPanelScreens.insider
                                        ? const InsiderScreen()
                                        : dashBoardController
                                                    .currentScreen.value ==
                                                DashBoardPanelScreens
                                                    .latestMover
                                            ? const LatestMoversScreen()
                                            : dashBoardController
                                                        .currentScreen.value ==
                                                    DashBoardPanelScreens
                                                        .notification
                                                ? SendNotificationScreen()
                                                : dashBoardController
                                                            .currentScreen
                                                            .value ==
                                                        DashBoardPanelScreens
                                                            .userReport
                                                    ? UserReportScreen()
                                                    : dashBoardController
                                                                .currentScreen
                                                                .value ==
                                                            DashBoardPanelScreens
                                                                .companyBulkUpload
                                                        ? CompanyBulkUploadScreen()
                                                        : dashBoardController
                                                                    .currentScreen
                                                                    .value ==
                                                                DashBoardPanelScreens
                                                                    .latestMoversBulkUpload
                                                            ? LatestMoversBulkUploadScreen()
                                                            : dashBoardController
                                                                        .currentScreen
                                                                        .value ==
                                                                    DashBoardPanelScreens
                                                                        .newsCategoryBulkUpload
                                                                ? NewsCategoryBulkUploadScreen()
                                                                : const AddNewsScreen());

            // Expanded(
            //   child: dashBoardController.currentScreen.value ==
            //           DashBoardPanelScreens.dashboard
            //       ? DashboardScreen()
            //       : dashBoardController.currentScreen.value ==
            //               DashBoardPanelScreens.video
            //           ? VideoScreen()
            //           : FAQScreen());
          })
        ],
      ),
    );
  }
}
