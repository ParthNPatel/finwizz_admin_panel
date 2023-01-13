import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/get_latest_movers_repo.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Screens/company/add_company_screen.dart';
import 'package:finwizz_admin/Screens/movres/movers_screen.dart';
import 'package:finwizz_admin/ViewModel/add_movers_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_latest_mover_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_movers_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
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
  GetCompanyViewModel getCompanyViewModel = Get.put(GetCompanyViewModel());
  DateTimeRange? _selectedDateRange;
  String? firstDate;
  String? endDate;
  bool typeMover = false;

  GetLatestMoverViewModel getLatestMoverViewModel =
      Get.put(GetLatestMoverViewModel());

  @override
  void initState() {
    getCompanyViewModel.getCompanyViewModel();
    getLatestMoverViewModel.getLatestMoversViewModel();
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
          child: GetBuilder<GetLatestMoverViewModel>(
            builder: (controller) {
              if (controller.getLatestMoverApiResponse.status ==
                  Status.LOADING) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (controller.getLatestMoverApiResponse.status ==
                  Status.COMPLETE) {
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
                                      typeMover = false;

                                      addLatestMoverDialog(
                                          context, typeMover, '');
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
                            SizedBox(
                              width: 5,
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
                            SizedBox(
                              width: 5,
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
                            SizedBox(
                              width: 5,
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
                            SizedBox(
                              width: 5,
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
                        itemCount: controller.latestMoverData == null
                            ? 0
                            : (controller.latestMoverData['data']['docs']
                                    as List)
                                .length,
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
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.latestMoverData['data']['docs'][index]['title']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.latestMoverData['data']['docs'][index]['description']}',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.latestMoverData['data']['docs'][index]['percentage']}%',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.latestMoverData['data']['docs'][index]['startDate']}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    // padding: const EdgeInsets.only(left: 20),
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${controller.latestMoverData['data']['docs'][index]['endDate']}',
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
                                    deleteDialog(
                                        onPress: () async {
                                          await GetLatestMoversRepo()
                                              .deleteLatestMoversRepo(
                                                  text:
                                                      '${controller.latestMoverData['data']['docs'][index]['_id']}');
                                          await getLatestMoverViewModel
                                              .getLatestMoversViewModel(
                                                  isLoading: false);
                                        },
                                        header:
                                            'Are you sure to delete this mover ?',
                                        context: context);
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
                                    typeMover = true;

                                    titleController.text = controller
                                        .latestMoverData['data']['docs'][index]
                                            ['title']
                                        .toString();

                                    descriptionController.text = controller
                                        .latestMoverData['data']['docs'][index]
                                            ['description']
                                        .toString();

                                    percentageController.text = controller
                                        .latestMoverData['data']['docs'][index]
                                            ['percentage']
                                        .toString();
                                    firstDate =
                                        controller.latestMoverData['data']
                                            ['docs'][index]['startDate'];
                                    endDate = controller.latestMoverData['data']
                                        ['docs'][index]['endDate'];

                                    addLatestMoverDialog(
                                        context,
                                        typeMover,
                                        controller.latestMoverData['data']
                                            ['docs'][index]['_id']);
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

  addLatestMoverDialog(BuildContext context, bool typeMovers, String moverId) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  height: 600,
                  width: 465,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(17),
                          color: AppColor.mainColor,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: AppColor.whiteColor,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.clear,
                                      color: AppColor.mainColor,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    typeMovers == false
                                        ? 'Add Movers'
                                        : 'Update Mover',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              addDataForm(
                                  header: 'Title',
                                  hint: 'Title',
                                  textEditingController: titleController),
                              SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Percentage',
                                  hint: 'Percentage',
                                  textEditingController: percentageController),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Date Rang',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTimeRange? result =
                                      await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime(
                                        2022, 1, 1), // the earliest allowable
                                    lastDate: DateTime(
                                        2030, 12, 31), // the latest allowable
                                    currentDate: DateTime.now(),
                                    saveText: 'Done',
                                  );
                                  if (result != null) {
                                    // Rebuild the UI
                                    print(result.start.toString());
                                    setStat(() {
                                      _selectedDateRange = result;
                                    });
                                    firstDate =
                                        '${_selectedDateRange!.start.day} - ${_selectedDateRange!.start.month} - ${_selectedDateRange!.start.year}';
                                    endDate =
                                        '${_selectedDateRange!.end.day} - ${_selectedDateRange!.end.month} - ${_selectedDateRange!.end.year}';
                                  }
                                  log('SELECTED DATE :- ${_selectedDateRange}');
                                },
                                child: Container(
                                    height: 40,
                                    width: 380,
                                    alignment: Alignment.centerLeft,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        border:
                                            Border.all(color: AppColor.grey100),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                        firstDate == null || endDate == null
                                            ? 'Pick Date'
                                            : '${firstDate}  /  ${endDate}')),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Description',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 150,
                                width: 380,
                                child: TextField(
                                  controller: descriptionController,
                                  maxLines: 5,
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
                                    hintText: 'Type',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: GetBuilder<AddMoversViewModel>(
                                  builder: (controller) {
                                    return controller.loader == true
                                        ? CircularProgressIndicator(
                                            color: AppColor.mainColor,
                                          )
                                        : SizedBox(
                                            width: 400,
                                            height: 45,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.mainColor,
                                              ),
                                              onPressed: () async {
                                                if (typeMover == false) {
                                                  if (percentageController
                                                          .text.isNotEmpty &&
                                                      titleController
                                                          .text.isNotEmpty &&
                                                      descriptionController
                                                          .text.isNotEmpty) {
                                                    await getLatestMoverViewModel
                                                        .addLatestMoversViewModel(
                                                            body: {
                                                          "title":
                                                              titleController
                                                                  .text
                                                                  .trim()
                                                                  .toString(),
                                                          "description":
                                                              descriptionController
                                                                  .text
                                                                  .trim()
                                                                  .toString(),
                                                          "percentage":
                                                              percentageController
                                                                  .text
                                                                  .trim()
                                                                  .toString(),
                                                          "startDate":
                                                              '$firstDate',
                                                          "endDate": '$endDate',
                                                        });

                                                    if (getLatestMoverViewModel
                                                            .addLatestMoverApiResponse
                                                            .status ==
                                                        Status.COMPLETE) {
                                                      Get.back();

                                                      clearData();

                                                      snackBarGet(
                                                          'Movers Added',
                                                          snackBarBackGroundColor:
                                                              AppColor
                                                                  .greenColor);
                                                    }
                                                    if (getLatestMoverViewModel
                                                            .addLatestMoverApiResponse
                                                            .status ==
                                                        Status.ERROR) {
                                                      Get.back();

                                                      snackBarGet(
                                                        'Something went wrong',
                                                        snackBarBackGroundColor:
                                                            AppColor.redColor,
                                                      );
                                                    }
                                                  } else {
                                                    snackBarGet(
                                                      'Fill necessary details',
                                                      snackBarBackGroundColor:
                                                          AppColor.redColor,
                                                    );
                                                  }
                                                } else {
                                                  await GetLatestMoversRepo()
                                                      .editLatestMoversRepo(
                                                          body: {
                                                        "title": titleController
                                                            .text
                                                            .trim()
                                                            .toString(),
                                                        "description":
                                                            descriptionController
                                                                .text
                                                                .trim()
                                                                .toString(),
                                                        "percentage":
                                                            percentageController
                                                                .text
                                                                .trim()
                                                                .toString(),
                                                        "startDate":
                                                            '$firstDate',
                                                        "endDate": '$endDate',
                                                      },
                                                          text: moverId);
                                                }

                                                await getLatestMoverViewModel
                                                    .getLatestMoversViewModel(
                                                        isLoading: false);
                                              },
                                              child: Text(
                                                typeMovers == false
                                                    ? 'Add'
                                                    : 'Update',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: AppColor.whiteColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      clearData();
    });
  }

  clearData() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    startPriceController.clear();
    percentageController.clear();
    firstDate = null;
    endDate = null;
    getCompanyViewModel.selectedCompanyValue = null;
  }
}