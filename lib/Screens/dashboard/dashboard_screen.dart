import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/ViewModel/dashboard_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/images_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GetCompanyResponseModel getCompanyResponseModel =
      Get.put(GetCompanyResponseModel());
  DashboardViewModel dashboardViewModel = Get.put(DashboardViewModel());
  @override
  void initState() {
    dashboardViewModel.fetchDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<DashboardViewModel>(
        builder: (controller) {
          return controller.loading == false
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(50, 25, 0, 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 50),
                          height: 465,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.parrotColor,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.company,
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Company'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${controller.companyTotal}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: AppColor.blackColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 50),
                          height: 465,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.orange300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.news,
                                height: 70,
                                width: 70,
                                color: AppColor.blackColor,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'News'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${controller.newsTotal}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 465,
                          margin: const EdgeInsets.only(right: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColor.purple300,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.connectUs,
                                height: 70,
                                width: 70,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Contact'.toUpperCase(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 26),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                '${controller.connectUsTotal}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
