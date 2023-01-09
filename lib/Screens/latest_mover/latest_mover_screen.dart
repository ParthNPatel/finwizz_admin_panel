import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/ViewModel/add_movers_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_movers_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/controller/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LatestMoversScreen extends StatefulWidget {
  const LatestMoversScreen({Key? key}) : super(key: key);

  @override
  State<LatestMoversScreen> createState() => _LatestMoversScreenState();
}

class _LatestMoversScreenState extends State<LatestMoversScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController startPriceController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TypeController typeController = Get.put(TypeController());
  InputBorder outline =
      OutlineInputBorder(borderSide: BorderSide(color: AppColor.grey400));
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));
  AddMoversViewModel addMoversViewModel = Get.put(AddMoversViewModel());
  GetMoversViewModel getMoversViewModel = Get.put(GetMoversViewModel());
  GetCompanyViewModel getCompanyViewModel = Get.put(GetCompanyViewModel());
  DateTimeRange? _selectedDateRange;
  String? firstDate;
  String? endDate;
  bool typeMover = false;

  @override
  void initState() {
    getMoversViewModel.getMoversViewModel();
    getCompanyViewModel.getCompanyViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1489;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    log('width :- $width');
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
          child: GetBuilder<GetMoversViewModel>(
            builder: (controller) {
              if (controller.getMoversApiResponse.status == Status.LOADING) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.getMoversApiResponse.status == Status.COMPLETE) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Latest Movers',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 83,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                    ),
                                    onPressed: () {
                                      // typeMover = false;

                                      // addMoverDialog(context, typeMover, '');
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Add',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: AppColor.whiteColor,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: AppColor.mainColor,
                        padding: const EdgeInsets.all(13),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                // padding: const EdgeInsets.only(left: 20),
                                color: AppColor.mainColor,
                                alignment: Alignment.center,
                                child: Text(
                                  'Company Name',
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                // padding: const EdgeInsets.only(left: 20),
                                color: AppColor.mainColor,
                                alignment: Alignment.center,
                                child: Text(
                                  'Associated News',
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // padding: const EdgeInsets.only(left: 20),
                                color: AppColor.mainColor,
                                // alignment: Alignment.centerLeft,
                                alignment: Alignment.center,

                                child: Text(
                                  'Percentage',
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // padding: const EdgeInsets.only(left: 20),
                                color: AppColor.mainColor,
                                alignment: Alignment.center,
                                child: Text(
                                  'From Date',
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                // padding: const EdgeInsets.only(left: 20),
                                color: AppColor.mainColor,
                                alignment: Alignment.center,
                                child: Text(
                                  'To Date',
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () async {},
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: AppColor.mainColor,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.transparent,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                    color: AppColor.mainColor,
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    color: Colors.transparent,
                                    Icons.edit,
                                    size: 20,
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
                          return const SizedBox(
                            height: 20,
                          );
                        },
                        itemCount: controller.moversData == null
                            ? 0
                            : (controller.moversData['data'] as List).length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            width: width,
                            // margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              // borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    color: Colors.transparent,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${controller.moversData['data'][index]['companyId']['name']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${controller.moversData['data'][index]['description']}',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.moversData['data'][index]['percentage']}%',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.moversData['data'][index]['startDate']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    // padding: const EdgeInsets.only(left: 20),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.moversData['data'][index]['endDate']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () async {
                                    // deleteDialog(
                                    //     onPress: () async {
                                    //       await DeleteMoversRepo().deleteMoversRepo(
                                    //           text:
                                    //           '${controller.moversData['data'][index]['_id']}');
                                    //       await getMoversViewModel
                                    //           .getMoversViewModel(
                                    //           isLoading: false);
                                    //     },
                                    //     header:
                                    //     'Are you sure to delete this mover ?',
                                    //     context: context);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.delete,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    // typeMover = true;
                                    // getCompanyViewModel.selectedCompanyValue =
                                    //     controller.moversData['data'][index]
                                    //     ['companyId']['_id']
                                    //         .toString();
                                    // titleController.text = controller
                                    //     .moversData['data'][index]['title']
                                    //     .toString();
                                    //
                                    // descriptionController.text = controller
                                    //     .moversData['data'][index]
                                    // ['description']
                                    //     .toString();
                                    //
                                    // priceController.text = controller
                                    //     .moversData['data'][index]
                                    // ['currentPrice']
                                    //     .toString();
                                    // startPriceController.text = controller
                                    //     .moversData['data'][index]['startPrice']
                                    //     .toString();
                                    //
                                    // percentageController.text = controller
                                    //     .moversData['data'][index]['percentage']
                                    //     .toString();
                                    // firstDate = controller.moversData['data']
                                    // [index]['createdAt']
                                    //     .toString()
                                    //     .split('T')
                                    //     .first;
                                    // endDate = controller.moversData['data']
                                    // [index]['updatedAt']
                                    //     .toString()
                                    //     .split('T')
                                    //     .first;

                                    // addMoverDialog(
                                    //     context,
                                    //     typeMover,
                                    //     controller.moversData['data'][index]
                                    //     ['_id']);
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.edit,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              return Center(
                child: Text('Something went wrong'),
              );
            },
          )),
    );
  }
}
