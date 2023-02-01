import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_user_stock_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/date_conveter.dart';
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
  InputBorder outline =
      OutlineInputBorder(borderSide: BorderSide(color: AppColor.grey400));

  DateTimeRange? _selectedDateRange;
  DateTime? stDate;
  DateTime? lsDate;
  DateTime? fsDate;
  DateTime? edDate;
  String? firstDate;
  String? endDate;

  String searchText = "";

  TextEditingController searchController = TextEditingController();

  dynamic selectedCompanyValue;

  GetCompanyViewModel getCompanyViewModel = Get.put(GetCompanyViewModel());

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
                        DateTimeRange? result = await showDateRangePicker(
                          context: context,
                          firstDate:
                              DateTime(2022, 1, 1), // the earliest allowable
                          lastDate:
                              DateTime(2030, 12, 31), // the latest allowable
                          currentDate: DateTime.now(),
                          saveText: 'Done',
                        );
                        if (result != null) {
                          // Rebuild the UI
                          print(result.start.toString());
                          setState(() {
                            _selectedDateRange = result;
                          });
                          firstDate =
                              '${_selectedDateRange!.start.year}-${_selectedDateRange!.start.month < 10 ? '0${_selectedDateRange!.start.month}' : _selectedDateRange!.start.month}-${_selectedDateRange!.start.day < 10 ? '0${_selectedDateRange!.start.day}' : _selectedDateRange!.start.day}';
                          endDate =
                              '${_selectedDateRange!.end.year}-${_selectedDateRange!.end.month < 10 ? '0${_selectedDateRange!.end.month}' : _selectedDateRange!.end.month}-${_selectedDateRange!.end.day < 10 ? '0${_selectedDateRange!.end.day}' : _selectedDateRange!.end.day}';
                        }
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all()),
                        child: Center(
                          child: Text(firstDate == null || endDate == null
                              ? 'Pick Date'
                              : '${firstDate}  /  ${endDate}'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GetBuilder<GetCompanyViewModel>(
                      builder: (companyController) {
                        if (companyController.getCompanyApiResponse.status ==
                            Status.COMPLETE) {
                          GetCompanyResponseModel getCompany =
                              companyController.getCompanyApiResponse.data;
                          return Container(
                            height: 40,
                            width: 200,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                border: Border.all(color: AppColor.grey100),
                                borderRadius: BorderRadius.circular(7)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                hint: const Text('All'),
                                value: selectedCompanyValue,
                                items: getCompany.data!
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e.name,
                                        child: SizedBox(
                                          height: 40,
                                          width: 150,
                                          child: Center(
                                            child: Text(
                                              '${e.name}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (val) {
                                  print('Value==>>${val}');
                                  setState(() {
                                    selectedCompanyValue = val;
                                  });
                                },
                              ),
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: 250,
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) async {
                          setState(() {
                            searchText = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: outline,
                          focusedBorder: outline,
                          enabledBorder: outline,
                          contentPadding:
                              const EdgeInsets.only(top: 5, left: 10),
                          suffixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                          hintText: 'Search....',
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
                                        'Time stamp',
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
                            return SizedBox(
                              height: 20,
                            );
                          },
                          itemCount:
                              controller.stockUserData['data']['docs'].length,
                          shrinkWrap: true,
                          // reverse: true,
                          itemBuilder: (context, index) {
                            String startDate = controller.stockUserData['data']
                                    ['docs'][index]['createdAt']
                                .toString()
                                .split('T')
                                .first;

                            if (firstDate != null) {
                              stDate = DateTime.parse(startDate);

                              fsDate = DateTime.parse(firstDate!);
                              edDate = DateTime.parse(endDate!);
                            }

                            print(
                                '---CONTAIN$index---${controller.stockUserData['data']['docs'][index]['phone'].toString().toLowerCase().contains(controller.searchText.toLowerCase())}');
                            return firstDate == null ||
                                    fsDate!.isBefore(stDate!) == true &&
                                        edDate!.isAfter(stDate!) == true
                                ? controller.stockUserData['data']['docs']
                                                [index]['phone']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                searchText.toLowerCase()) ||
                                        searchText == ''
                                    ? Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: Container(
                                            // height: 50,
                                            width: width,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
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
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                                    FontWeight
                                                                        .w600,
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
                                                                    FontWeight
                                                                        .w600,
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
                                                              '${dateConverter(controller.stockUserData['data']['docs'][index]['addedStocks'][index1]['updatedAt'].toString())}',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
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
                                    : SizedBox()
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
