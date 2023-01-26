import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/delete_movers_repo.dart';
import 'package:finwizz_admin/Model/Repo/edit_movers_repo.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Screens/company/add_company_screen.dart';
import 'package:finwizz_admin/ViewModel/add_movers_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_movers_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:finwizz_admin/controller/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoversScreen extends StatefulWidget {
  const MoversScreen({Key? key}) : super(key: key);

  @override
  State<MoversScreen> createState() => _MoversScreenState();
}

class _MoversScreenState extends State<MoversScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController startPriceController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController imageTypeController = TextEditingController();
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
  DateTime? stDate;
  DateTime? lsDate;
  DateTime? fsDate;
  DateTime? edDate;
  bool typeMover = false;

  int? imageTypeSelected;

  List<int> imageType = [1, 2, 3, 4, 5];

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
                              'Movers',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                              ),
                            ),
                            const Spacer(),
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
                                  child: Text(
                                      firstDate == null || endDate == null
                                          ? 'Pick Date'
                                          : '${firstDate}  /  ${endDate}'),
                                ),
                              ),
                            ),
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

                                      addMoverDialog(context, typeMover, '');
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
                              flex: 2,
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
                              flex: 1,
                              child: Container(
                                // padding: const EdgeInsets.only(left: 20),
                                color: AppColor.mainColor,
                                alignment: Alignment.center,
                                child: Text(
                                  'Stock Ticker',
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
                                  'Image Type',
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
                                  'From Price',
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
                                  'to Price',
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
                            SizedBox(
                              width: 20,
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
                          String startDate = controller.moversData['data']
                                  [index]['createdAt']
                              .toString()
                              .split(" ")
                              .first;
                          String lastDate = controller.moversData['data'][index]
                                  ['updatedAt']
                              .toString()
                              .split(" ")
                              .first;

                          if (firstDate != null) {
                            stDate = DateTime.parse(startDate);
                            lsDate = DateTime.parse(lastDate);
                            fsDate = DateTime.parse(firstDate!);
                            edDate = DateTime.parse(endDate!);
                          }
                          return firstDate == null ||
                                  fsDate!.isBefore(stDate!) == true &&
                                      edDate!.isAfter(stDate!) == true
                              ? Container(
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
                                        flex: 2,
                                        child: Container(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          color: Colors.transparent,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${controller.moversData['data'][index]['companyId']['name']}',
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
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          color: Colors.transparent,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${controller.moversData['data'][index]['companyId']['name']}',
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
                                            '${controller.moversData['data'][index]['imageType']}',
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
                                            '${controller.moversData['data'][index]['percentage']}%',
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
                                            '${controller.moversData['data'][index]['startPrice']}',
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
                                            '${controller.moversData['data'][index]['currentPrice']}',
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
                                            '${controller.moversData['data'][index]['startDate'].toString().split(" ")[0]}',
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
                                            '${controller.moversData['data'][index]['endDate'].toString().split(" ")[0]}',
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
                                                await DeleteMoversRepo()
                                                    .deleteMoversRepo(
                                                        text:
                                                            '${controller.moversData['data'][index]['_id']}');
                                                await getMoversViewModel
                                                    .getMoversViewModel(
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
                                            borderRadius:
                                                BorderRadius.circular(3),
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
                                          getCompanyViewModel
                                                  .selectedCompanyValue =
                                              controller.moversData['data']
                                                      [index]['companyId']
                                                      ['_id']
                                                  .toString();
                                          titleController.text = controller
                                              .moversData['data'][index]
                                                  ['title']
                                              .toString();

                                          descriptionController.text =
                                              controller.moversData['data']
                                                      [index]['description']
                                                  .toString();

                                          priceController.text = controller
                                              .moversData['data'][index]
                                                  ['currentPrice']
                                              .toString();
                                          startPriceController.text = controller
                                              .moversData['data'][index]
                                                  ['startPrice']
                                              .toString();

                                          percentageController.text = controller
                                              .moversData['data'][index]
                                                  ['percentage']
                                              .toString();
                                          imageTypeController.text = controller
                                              .moversData['data'][index]
                                                  ['imageType']
                                              .toString();
                                          firstDate = controller
                                              .moversData['data'][index]
                                                  ['createdAt']
                                              .toString()
                                              .split('T')
                                              .first;
                                          endDate = controller
                                              .moversData['data'][index]
                                                  ['updatedAt']
                                              .toString()
                                              .split('T')
                                              .first;

                                          addMoverDialog(
                                              context,
                                              typeMover,
                                              controller.moversData['data']
                                                  [index]['_id']);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
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
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox();
                          ;
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

  addMoverDialog(BuildContext context, bool typeMovers, String moverId) {
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
                              const Text(
                                'Company',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GetBuilder<GetCompanyViewModel>(
                                builder: (companyController) {
                                  if (companyController
                                          .getCompanyApiResponse.status ==
                                      Status.COMPLETE) {
                                    GetCompanyResponseModel getCompany =
                                        companyController
                                            .getCompanyApiResponse.data;
                                    return Container(
                                      height: 40,
                                      width: 380,
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          border: Border.all(
                                              color: AppColor.grey100),
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: const Text('Select Company'),
                                          value: companyController
                                              .selectedCompanyValue,
                                          items: getCompany.data!
                                              .map(
                                                (e) => DropdownMenuItem(
                                                  value: e!.id,
                                                  child: Text(
                                                    '${e.name}',
                                                    style: TextStyle(
                                                      color:
                                                          AppColor.blackColor,
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onChanged: (val) {
                                            setStat(() {
                                              companyController
                                                  .updateValue(val!);
                                            });
                                            log('Company ID;- ${companyController.selectedCompanyValue}');
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                  return SizedBox();
                                },
                              ),
                              SizedBox(
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
                              SizedBox(
                                height: 20,
                              ),
                              // addDataForm(
                              //     header: 'Title',
                              //     hint: 'Title',
                              //     textEditingController: titleController),
                              // const SizedBox(
                              //   height: 20,
                              // ),
                              addDataForm(
                                  header: 'Price Start',
                                  hint: 'Price Start',
                                  textEditingController: startPriceController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Current Price',
                                  hint: 'Current Price',
                                  textEditingController: priceController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Percentage',
                                  hint: 'Percentage',
                                  textEditingController: percentageController),
                              const SizedBox(
                                height: 20,
                              ),
                              // addDataForm(
                              //     inputFormatter: [
                              //       FilteringTextInputFormatter.digitsOnly,
                              //     ],
                              //     header: 'Image Type',
                              //     hint: 'Type',
                              //     textInputType: TextInputType.number,
                              //     textEditingController: imageTypeController),
                              Text(
                                'Image Type',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 40,
                                width: 380,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    border: Border.all(color: AppColor.grey100),
                                    borderRadius: BorderRadius.circular(7)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: const Text('Select ImageType'),
                                    value: imageTypeSelected,
                                    items: List.generate(
                                      imageType.length,
                                      (index) => DropdownMenuItem(
                                        value: imageType[index],
                                        child: Text(
                                          'Image Type - ${imageType[index]}',
                                          style: TextStyle(
                                            color: AppColor.blackColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onChanged: (val) {
                                      setStat(() {
                                        imageTypeSelected = val as int;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Text(
                              //   'Description',
                              //   style: const TextStyle(
                              //     fontSize: 16,
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                              // const SizedBox(
                              //   height: 10,
                              // ),
                              // SizedBox(
                              //   height: 150,
                              //   width: 380,
                              //   child: TextField(
                              //     controller: descriptionController,
                              //     maxLines: 5,
                              //     decoration: InputDecoration(
                              //       border: outlineBorder,
                              //       focusedBorder: outlineBorder,
                              //       enabledBorder: outlineBorder,
                              //       fillColor: Colors.grey.shade50,
                              //       filled: true,
                              //       contentPadding: const EdgeInsets.only(
                              //         top: 25,
                              //         left: 10,
                              //       ),
                              //       hintText: 'Type',
                              //     ),
                              //   ),
                              // ),
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
                                                if (typeMovers == false) {
                                                  if (priceController
                                                          .text.isNotEmpty &&
                                                      percentageController
                                                          .text.isNotEmpty &&
                                                      getCompanyViewModel
                                                              .selectedCompanyValue !=
                                                          null) {
                                                    await addMoversViewModel
                                                        .addMoversViewModel(
                                                            model: {
                                                          "companyId":
                                                              "${getCompanyViewModel.selectedCompanyValue}",
                                                          "currentPrice":
                                                              priceController
                                                                  .text
                                                                  .trim()
                                                                  .toString(),
                                                          "percentage":
                                                              percentageController
                                                                  .text
                                                                  .trim()
                                                                  .toString(),
                                                          "startDate":
                                                              '${_selectedDateRange!.start}',
                                                          "endDate":
                                                              '${_selectedDateRange!.end}',
                                                          "startPrice":
                                                              startPriceController
                                                                  .text
                                                                  .trim()
                                                                  .toString(),
                                                          "imageType":
                                                              imageTypeSelected
                                                        });

                                                    if (addMoversViewModel
                                                            .addMoversApiResponse
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
                                                    if (addMoversViewModel
                                                            .addMoversApiResponse
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
                                                  await EditMoverRepo()
                                                      .editMoversRepo(body: {
                                                    "companyId":
                                                        "${getCompanyViewModel.selectedCompanyValue}",
                                                    "currentPrice":
                                                        priceController.text
                                                            .trim()
                                                            .toString(),
                                                    "percentage":
                                                        percentageController
                                                            .text
                                                            .trim()
                                                            .toString(),
                                                    "startDate": '$firstDate',
                                                    "imageType":
                                                        imageTypeSelected,
                                                    "endDate": '$endDate',
                                                    "startPrice":
                                                        startPriceController
                                                            .text
                                                            .trim()
                                                            .toString(),
                                                  }, text: moverId);
                                                }
                                                await getMoversViewModel
                                                    .getMoversViewModel(
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

Widget addDataForm(
    {String? header,
    String? hint,
    TextInputType? textInputType = TextInputType.emailAddress,
    TextEditingController? textEditingController,
    dynamic inputFormatter}) {
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$header',
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      SizedBox(
        height: 40,
        width: 380,
        child: TextField(
          inputFormatters: inputFormatter,
          keyboardType: textInputType,
          controller: textEditingController,
          decoration: InputDecoration(
            border: outlineBorder,
            focusedBorder: outlineBorder,
            enabledBorder: outlineBorder,
            fillColor: Colors.grey.shade50,
            filled: true,
            contentPadding: const EdgeInsets.only(top: 5, left: 10),
            hintText: '$hint',
          ),
        ),
      ),
    ],
  );
}
