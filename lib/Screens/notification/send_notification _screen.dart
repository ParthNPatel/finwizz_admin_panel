import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/ViewModel/get_user_stock_view_model.dart';
import 'package:finwizz_admin/ViewModel/notification_view_model.dart';
import 'package:finwizz_admin/ViewModel/send_notification_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendNotificationScreen extends StatefulWidget {
  SendNotificationScreen({Key? key}) : super(key: key);

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));

  TextEditingController notification = TextEditingController();

  TextEditingController search = TextEditingController();

  GetUserStockViewModel getUserStockViewModel =
      Get.put(GetUserStockViewModel());
  SendNotificationViewModel sendNotificationViewModel =
      Get.put(SendNotificationViewModel());
  @override
  void initState() {
    getUserStockViewModel.getUserStockViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1489;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColor.mainColor),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150,
                  width: 380,
                  child: TextField(
                    controller: notification,
                    maxLines: 5,
                    onChanged: (val) {},
                    decoration: InputDecoration(
                      border: outlineBorder,
                      focusedBorder: outlineBorder,
                      enabledBorder: outlineBorder,
                      fillColor: Colors.grey.shade50,
                      filled: true,
                      contentPadding: const EdgeInsets.only(
                        top: 25,
                        left: 10,
                      ),
                      hintText: 'Write your message here...',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 380,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.mainColor),
                        onPressed: () {
                          notification.clear();
                          getUserStockViewModel.updateSelectAll(false);
                        },
                        child: Text('Cancel'),
                      ),
                      GetBuilder<SendNotificationViewModel>(
                        builder: (controller) {
                          return controller.loader == true
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor),
                                  onPressed: () async {
                                    if (notification.text.isNotEmpty) {
                                      await getUserStockViewModel.getItems();
                                      if (getUserStockViewModel
                                          .holder_1.isNotEmpty) {
                                        if (getUserStockViewModel.selectAll ==
                                            true) {
                                          await sendNotificationViewModel
                                              .sendNotificationViewModel(
                                                  model: {
                                                'title': 'Finwiz',
                                                'body': notification.text
                                                    .trim()
                                                    .toString()
                                              });
                                        } else {
                                          await sendNotificationViewModel
                                              .sendNotificationViewModel(
                                                  model: {
                                                'title': 'Finwiz',
                                                'body': notification.text
                                                    .trim()
                                                    .toString(),
                                                'users': getUserStockViewModel
                                                    .holder_1
                                              });
                                        }

                                        if (sendNotificationViewModel
                                                .sendNotificationApiResponse
                                                .status ==
                                            Status.COMPLETE) {
                                          snackBarGet('Notification Send',
                                              snackBarBackGroundColor:
                                                  AppColor.mainColor);
                                          notification.clear();
                                          getUserStockViewModel
                                              .updateSelectAll(false);
                                        }
                                        if (sendNotificationViewModel
                                                .sendNotificationApiResponse
                                                .status ==
                                            Status.ERROR) {
                                          snackBarGet('Notification Not Send',
                                              snackBarBackGroundColor:
                                                  AppColor.redColor);
                                        }
                                      } else {
                                        snackBarGet('Select User',
                                            snackBarBackGroundColor:
                                                AppColor.redColor);
                                      }
                                    } else {
                                      snackBarGet('Write message...',
                                          snackBarBackGroundColor:
                                              AppColor.redColor);
                                    }
                                  },
                                  child: Text('Send'),
                                );
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GetBuilder<GetUserStockViewModel>(
                builder: (controller) {
                  if (controller.getUserStockApiResponse.status ==
                      Status.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.getUserStockApiResponse.status ==
                      Status.COMPLETE) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 15),
                          child: Row(
                            children: [
                              Container(
                                // padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: controller.selectAll,
                                      onChanged: (value) {
                                        controller.updateSelectAll(value);
                                      },
                                    ),
                                    Text('Select All'),
                                    SizedBox(
                                      width: 5,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 300,
                                child: TextField(
                                  controller: search,
                                  onChanged: (value) {
                                    controller.updateSearch(value);
                                  },
                                  decoration: InputDecoration(
                                    border: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                    fillColor: Colors.grey.shade50,
                                    filled: true,
                                    contentPadding: const EdgeInsets.only(
                                      top: 25,
                                      left: 10,
                                    ),
                                    hintText: 'Search here...',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: AppColor.mainColor,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 150,
                              ),
                              Expanded(
                                child: Container(
                                  // padding: const EdgeInsets.only(left: 20),
                                  color: AppColor.mainColor,
                                  alignment: Alignment.centerLeft,

                                  child: Text(
                                    'Phone No',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: controller.stockUserData['data']['docs']
                                              [index]['name']
                                          .toString()
                                          .toLowerCase()
                                          .contains(controller.searchText
                                              .toLowerCase()) ||
                                      controller.searchText == ''
                                  ? 20
                                  : 10,
                            );
                          },
                          itemCount:
                              controller.stockUserData['data']['docs'].length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return controller.stockUserData['data']['docs']
                                            [index]['phone']
                                        .toString()
                                        .toLowerCase()
                                        .contains(controller.searchText
                                            .toLowerCase()) ||
                                    controller.searchText == ''
                                ? Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: Container(
                                        height: 50,
                                        width: width,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Checkbox(
                                              value: controller
                                                      .stockUserData['data']
                                                  ['docs'][index]['value'],
                                              onChanged: (value) {
                                                controller.updateValue(
                                                    value, index);
                                              },
                                            ),
                                            SizedBox(
                                              width: 100,
                                            ),
                                            Expanded(
                                              child: Container(
                                                // padding: const EdgeInsets.only(left: 20),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${controller.stockUserData['data']['docs'][index]['phone'] ?? 'NA'}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          },
                        ),
                      ],
                    );
                  }
                  return Center(
                    child: Text('Something went wrong'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
