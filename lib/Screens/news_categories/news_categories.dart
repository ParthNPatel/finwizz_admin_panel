import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/delete_news_categories_repo.dart';
import 'package:finwizz_admin/Model/Response_model/get_news_cetegories_res_model.dart';
import 'package:finwizz_admin/Screens/company/add_company_screen.dart';
import 'package:finwizz_admin/Screens/movres/movers_screen.dart';
import 'package:finwizz_admin/ViewModel/add_news_categories_view_model.dart';
import 'package:finwizz_admin/ViewModel/news_categories_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/date_conveter.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:finwizz_admin/Widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewsCategoriesScreen extends StatefulWidget {
  const AddNewsCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsCategoriesScreen> createState() =>
      _AddNewsCategoriesScreenState();
}

class _AddNewsCategoriesScreenState extends State<AddNewsCategoriesScreen> {
  TextEditingController newsCategoriesController = TextEditingController();
  AddNewsCategoriesViewModel addNewsCategoriesViewModel =
      Get.put(AddNewsCategoriesViewModel());

  GetNewsCategoriesViewModel getNewsCategoriesViewModel =
      Get.put(GetNewsCategoriesViewModel());
  GetNewsCategoriesResponseModel? responseModel;
  DateTimeRange? _selectedDateRange;
  DateTime? stDate;
  DateTime? lsDate;
  DateTime? fsDate;
  DateTime? edDate;
  String? firstDate;
  String? endDate;

  String searchText = "";

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getNewsCategoriesViewModel.getNewsCategoriesViewModel();
    super.initState();
  }

  InputBorder outline =
      OutlineInputBorder(borderSide: BorderSide(color: AppColor.grey400));
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
                      'News Categories',
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
                    SizedBox(
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
                          newsCategoriesAddDialog(context, false);
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
              Container(
                color: AppColor.mainColor,
                padding: const EdgeInsets.all(18),
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
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              'News Category',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.center,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              'Time stamp',
                              style: TextStyle(
                                color: AppColor.whiteColor,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                            Icons.edit,
                            color: Colors.transparent,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  GetBuilder<GetNewsCategoriesViewModel>(
                    builder: (controller) {
                      if (controller.getNewsCategoriesApiResponse.status ==
                          Status.LOADING) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (controller.getNewsCategoriesApiResponse.status ==
                          Status.COMPLETE) {
                        try {
                          responseModel =
                              controller.getNewsCategoriesApiResponse.data;
                        } catch (e) {
                          controller.updateError(true);
                        }
                        return controller.catchError == false
                            ? responseModel!.data!.isEmpty == true
                                ? Center(
                                    child: Text('No Categories Added'),
                                  )
                                : ListView.separated(
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                    itemCount: responseModel!.data!.length,
                                    shrinkWrap: true,
                                    reverse: true,
                                    itemBuilder: (context, index) {
                                      String startDate = responseModel!
                                          .data![index].updatedAt
                                          .toString()
                                          .split(" ")
                                          .first;

                                      if (firstDate != null) {
                                        stDate = DateTime.parse(startDate);
                                        fsDate = DateTime.parse(firstDate!);
                                        edDate = DateTime.parse(endDate!);
                                      }
                                      return firstDate == null ||
                                              fsDate!.isBefore(stDate!) ==
                                                      true &&
                                                  edDate!.isAfter(stDate!) ==
                                                      true
                                          ? responseModel!.data![index].name
                                                      .toString()
                                                      .toLowerCase()
                                                      .contains(searchText
                                                          .toLowerCase()) ||
                                                  searchText == ''
                                              ? Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                          dividerColor: Colors
                                                              .transparent),
                                                  child: Container(
                                                    height: 50,
                                                    width: width,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 25),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColor.whiteColor,
                                                      // borderRadius:
                                                      //     BorderRadius.circular(10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Container(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                '${responseModel!.data![index].name ?? "NA"}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                '${dateConverter(responseModel!.data![index].updatedAt.toString()) ?? "NA"}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            deleteDialog(
                                                                onPress:
                                                                    () async {
                                                                  await DeleteNewsCategoriesRepo().deleteNewsCategoriesRepo(
                                                                      text: responseModel!
                                                                          .data![
                                                                              index]
                                                                          .id
                                                                          .toString());

                                                                  await getNewsCategoriesViewModel
                                                                      .getNewsCategoriesViewModel(
                                                                          isLoading:
                                                                              false);
                                                                },
                                                                header:
                                                                    'Are you sure to delete this category ?',
                                                                context:
                                                                    context);
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              border:
                                                                  Border.all(
                                                                color: AppColor
                                                                    .mainColor,
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
                                                            newsCategoriesAddDialog(
                                                              context,
                                                              true,
                                                              category:
                                                                  '${responseModel!.data![index].name ?? "NA"}',
                                                            );
                                                          },
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          3),
                                                              border:
                                                                  Border.all(
                                                                color: AppColor
                                                                    .mainColor,
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
                                                  ),
                                                )
                                              : SizedBox()
                                          : SizedBox();
                                    },
                                  )
                            : const Center(
                                child: Text('Something went wrong'),
                              );
                        ;
                      }
                      return const Center(
                        child: Text('Something went wrong...'),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  newsCategoriesAddDialog(BuildContext context, bool isEdit,
      {String? category}) {
    InputBorder outlineBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(7));
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
        if (isEdit == true) {
          newsCategoriesController = TextEditingController(text: category);
        }
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 270,
              width: 350,
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
                                isEdit == true
                                    ? 'Edit Categories'
                                    : 'Add Categories',
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
                              header: 'Categories',
                              hint: 'Categories',
                              textEditingController: newsCategoriesController),
                          const SizedBox(
                            height: 35,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GetBuilder<AddNewsCategoriesViewModel>(
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
                                            backgroundColor: AppColor.mainColor,
                                          ),
                                          onPressed: () async {
                                            if (newsCategoriesController
                                                .text.isNotEmpty) {
                                              await addNewsCategoriesViewModel
                                                  .addNewsCategoriesViewModel(
                                                model: {
                                                  "name":
                                                      newsCategoriesController
                                                          .text
                                                          .trim()
                                                          .toString()
                                                },
                                              );

                                              if (addNewsCategoriesViewModel
                                                      .addNewsCategoriesApiResponse
                                                      .status ==
                                                  Status.COMPLETE) {
                                                Get.back();
                                                await getNewsCategoriesViewModel
                                                    .getNewsCategoriesViewModel(
                                                        isLoading: false);
                                                snackBarGet(
                                                    'News Categories Added',
                                                    snackBarBackGroundColor:
                                                        AppColor.greenColor);
                                              }
                                              if (addNewsCategoriesViewModel
                                                      .addNewsCategoriesApiResponse
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
                                                'Add Categories Name',
                                                snackBarBackGroundColor:
                                                    AppColor.redColor,
                                              );
                                            }
                                          },
                                          child: Text(
                                            isEdit == true ? 'Edit' : 'Add',
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
    ).whenComplete(() {
      newsCategoriesController.clear();
    });
  }
}
