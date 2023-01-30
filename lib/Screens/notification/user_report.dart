import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/ViewModel/get_user_stock_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserReportScreen extends StatefulWidget {
  UserReportScreen({Key? key}) : super(key: key);

  @override
  State<UserReportScreen> createState() => _UserReportScreenState();
}

class _UserReportScreenState extends State<UserReportScreen> {
  GetUserStockViewModel getUserStockViewModel =
      Get.put(GetUserStockViewModel());
  String? dateInput;
  DateTime? pickDate;
  DateTime? createDate;
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'User Report',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            builder: (context, child) {
                              return Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: AppColor.mainColor,
                                      onPrimary: Colors.black, // <-- SEE HERE
                                      onSurface: Colors.black,
                                    ),
                                  ),
                                  child: child!);
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(pickedDate); // 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate); //2021-03-16
                          setState(() {
                            dateInput = formattedDate;
                          });
                        } else {}
                      },
                      child: Container(
                        height: 40,
                        margin: EdgeInsets.only(right: 20),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              size: 18,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              dateInput == null ? 'Date' : dateInput!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                        Container(
                          color: AppColor.mainColor,
                          padding: const EdgeInsets.all(13),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: Container(
                                  // padding: const EdgeInsets.only(left: 20),
                                  color: AppColor.mainColor,
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Phone No',
                                    style: TextStyle(
                                      color: AppColor.whiteColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  // padding: const EdgeInsets.only(left: 20),
                                  color: AppColor.mainColor,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Stock',
                                        style: TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  // padding: const EdgeInsets.only(left: 20),
                                  color: AppColor.mainColor,
                                  alignment: Alignment.center,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Date',
                                        style: TextStyle(
                                          color: AppColor.whiteColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
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
                            return dateInput == null ||
                                    pickDate!.isAfter(createDate!) ||
                                    createDate == dateInput
                                ? SizedBox(
                                    height: 20,
                                  )
                                : SizedBox(
                                    height: 0,
                                  );
                          },
                          itemCount:
                              controller.stockUserData['data']['docs'].length,
                          shrinkWrap: true,
                          // reverse: true,
                          itemBuilder: (context, index) {
                            createDate = DateTime.parse(controller
                                .stockUserData['data']['docs'][index]
                                    ['createdAt']
                                .toString()
                                .split('T')
                                .first);

                            if (dateInput != null) {
                              pickDate = DateTime.parse(dateInput!);
                            }
                            return dateInput == null ||
                                    pickDate!.isAfter(createDate!) ||
                                    createDate == dateInput
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
                                        // height: 50,
                                        width: width,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                          // borderRadius:
                                          //     BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                // padding: const EdgeInsets.only(left: 20),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${controller.stockUserData['data']['docs'][index]['phone'] ?? 'NA'}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                // padding: const EdgeInsets.only(left: 20),
                                                alignment: Alignment.center,
                                                child: ListView.separated(
                                                  itemCount: controller
                                                      .stockUserData['data']
                                                          ['docs'][index]
                                                          ['addedStocks']
                                                      .length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index1) {
                                                    return Row(
                                                      children: [
                                                        Text(
                                                          '(${index1 + 1})',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                          '${controller.stockUserData['data']['docs'][index]['addedStocks'][index1]['name']}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      height: 5,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                // padding: const EdgeInsets.only(left: 20),
                                                alignment: Alignment.center,
                                                child: ListView.separated(
                                                  itemCount: controller
                                                      .stockUserData['data']
                                                          ['docs'][index]
                                                          ['addedStocks']
                                                      .length,
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index1) {
                                                    return Row(
                                                      children: [
                                                        Text(
                                                          '${controller.stockUserData['data']['docs'][index]['addedStocks'][index1]['updatedAt'].toString().split('T').first}',
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                  separatorBuilder:
                                                      (context, index) {
                                                    return SizedBox(
                                                      height: 5,
                                                    );
                                                  },
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
