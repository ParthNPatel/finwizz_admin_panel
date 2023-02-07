import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/delete_news_repo.dart';
import 'package:finwizz_admin/Model/Repo/edit_news_repo.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Model/Response_model/get_news_cetegories_res_model.dart';
import 'package:finwizz_admin/Screens/company/add_company_screen.dart';
import 'package:finwizz_admin/ViewModel/add_news_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_news_view_model.dart';
import 'package:finwizz_admin/ViewModel/news_categories_view_model.dart';
import 'package:finwizz_admin/ViewModel/search_news_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/date_conveter.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:finwizz_admin/controller/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Widgets/dashboard_panel_tabs.dart';
import '../../controller/dashboard_controller.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxBool genericType = false.obs;

  InputBorder outline =
      OutlineInputBorder(borderSide: BorderSide(color: AppColor.grey400));
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));

  TypeController typeController = Get.put(TypeController());
  GetNewsCategoriesViewModel getNewsCategoriesViewModel =
      Get.put(GetNewsCategoriesViewModel());

  GetNewsViewModel getNewsViewModel = Get.put(GetNewsViewModel());
  GetCompanyViewModel getCompanyViewModel = Get.put(GetCompanyViewModel());
  AddNewsViewModel addNewsViewModel = Get.put(AddNewsViewModel());
  SearchNewsController searchNewsController = Get.put(SearchNewsController());
  DashBoardController dashBoardController = Get.put(DashBoardController());

  GetNewsCategoriesResponseModel? responseModel;
  bool newsSelect = false;
  bool? isShowSticker = false;
  FocusNode passFocus = FocusNode();
  DateTimeRange? _selectedDateRange;
  DateTime? stDate;
  DateTime? lsDate;
  DateTime? fsDate;
  DateTime? edDate;
  String? firstDate;
  String? endDate;

  @override
  void initState() {
    getNewsCategoriesViewModel.getNewsCategoriesViewModel();
    searchNewsController.getSearchNewsViewModel(
        text: searchController.text.trim().toString(), companyId: '');
    getCompanyViewModel.getCompanyViewModel();
    passFocus.addListener(() {
      if (passFocus.hasFocus) {
        setState(() {
          isShowSticker = false;
        });
      }
    });
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
        child: GetBuilder<GetNewsCategoriesViewModel>(
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
                responseModel = controller.getNewsCategoriesApiResponse.data;
              } catch (e) {
                controller.updateError(true);
              }
              getNewsViewModel.getNewsViewModel(
                  id: responseModel!.data![controller.selectedCategories].id
                      .toString());
              return controller.catchError == false
                  ? SingleChildScrollView(
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
                                  'News',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    dashBoardController.currentScreen.value =
                                        DashBoardPanelScreens.newsBulkUpload;
                                  },
                                  child: Container(
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all()),
                                    child: Center(
                                      child: Text('Import Content'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
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
                                SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  children: [
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
                                            width: 200,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                    color: AppColor.grey100),
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                hint: const Text('All'),
                                                value: companyController
                                                    .selectedCompanyValue,
                                                items: getCompany.data!
                                                    .map(
                                                      (e) => DropdownMenuItem(
                                                        value: e!.id,
                                                        child: SizedBox(
                                                          height: 40,
                                                          width: 150,
                                                          child: Center(
                                                            child: Text(
                                                              '${e.name}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                color: AppColor
                                                                    .blackColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (val) async {
                                                  companyController
                                                      .updateValue(val!);
                                                  await searchNewsController
                                                      .getSearchNewsViewModel(
                                                          isLoading: false,
                                                          text: searchController
                                                              .text
                                                              .trim()
                                                              .toString(),
                                                          companyId: val
                                                              .toString()
                                                              .trim()
                                                              .toString());
                                                  log('SEARCH Company ID :- ${val}');
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
                                          await searchNewsController
                                              .getSearchNewsViewModel(
                                                  isLoading: false,
                                                  companyId: getCompanyViewModel
                                                              .selectedCompanyValue ==
                                                          null
                                                      ? ''
                                                      : getCompanyViewModel
                                                          .selectedCompanyValue,
                                                  text: searchController.text
                                                      .trim()
                                                      .toString());
                                        },
                                        decoration: InputDecoration(
                                          border: outline,
                                          focusedBorder: outline,
                                          enabledBorder: outline,
                                          contentPadding: const EdgeInsets.only(
                                              top: 5, left: 10),
                                          suffixIcon: Icon(
                                            Icons.search,
                                            color: Colors.grey.shade400,
                                            size: 20,
                                          ),
                                          hintText: 'Search....',
                                        ),
                                      ),
                                    ),
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
                                          newsSelect = false;
                                          addNewsDialog(
                                              context,
                                              '',
                                              responseModel!,
                                              controller,
                                              newsSelect);
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
                            height: 10,
                          ),
                          Container(
                            color: AppColor.mainColor,
                            padding: const EdgeInsets.all(13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
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
                                  flex: 1,
                                  child: Container(
                                    // padding: const EdgeInsets.only(left: 20),
                                    color: AppColor.mainColor,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Category',
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
                                      'Generic',
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
                                  flex: 2,
                                  child: Container(
                                    // padding: const EdgeInsets.only(left: 20),
                                    color: AppColor.mainColor,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Heading',
                                      style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
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
                                      'Source',
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

                                    child: Column(
                                      children: [
                                        Text(
                                          'Categories /',
                                          style: TextStyle(
                                            color: AppColor.whiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 2,
                                        ),
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
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // if (controller.changeData == true)
                          GetBuilder<SearchNewsController>(
                            builder: (searchNewsController) {
                              if (searchNewsController
                                      .getSearchNewsApiResponse.status ==
                                  Status.LOADING) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              if (searchNewsController
                                      .getSearchNewsApiResponse.status ==
                                  Status.COMPLETE) {
                                log('RESPONSE LIST ;- ${(searchNewsController.searchNewsData['data'] as List).isEmpty}');
                                return (searchNewsController
                                                .searchNewsData['data'] as List)
                                            .isEmpty ==
                                        true
                                    ? Center(
                                        child: Text('No news fount'),
                                      )
                                    : ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 20,
                                          );
                                        },
                                        itemCount: (searchNewsController
                                                        .searchNewsData['data']
                                                    as List)
                                                .isEmpty
                                            ? 0
                                            : (searchNewsController
                                                        .searchNewsData['data']
                                                    as List)
                                                .length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          String startDate =
                                              searchNewsController
                                                  .searchNewsData['data'][index]
                                                      ['createdAt']
                                                  .toString()
                                                  .split(" ")
                                                  .first;
                                          String lastDate = searchNewsController
                                              .searchNewsData['data'][index]
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
                                                  fsDate!.isBefore(stDate!) ==
                                                          true &&
                                                      edDate!.isAfter(
                                                              stDate!) ==
                                                          true
                                              ? Container(
                                                  width: width,
                                                  // margin:
                                                  //     const EdgeInsets.symmetric(
                                                  //         horizontal: 20),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      // horizontal: 25,
                                                      vertical: 25),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: AppColor.whiteColor,
                                                    // borderRadius:
                                                    //     BorderRadius.circular(10),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${searchNewsController.searchNewsData['data'][index]['companyId']['name']}',
                                                            maxLines: 2,
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
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${searchNewsController.searchNewsData['data'][index]['categoryId']['name']}',
                                                            maxLines: 2,
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
                                                            alignment: Alignment
                                                                .center,
                                                            child: Checkbox(
                                                              value: searchNewsController
                                                                          .searchNewsData[
                                                                      'data'][index]
                                                                  ['generic'],
                                                              onChanged:
                                                                  (value) {},
                                                            )),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${searchNewsController.searchNewsData['data'][index]['companyId']['shortName']}',
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
                                                        flex: 2,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${searchNewsController.searchNewsData['data'][index]['title']}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Expanded(
                                                        flex: 3,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${searchNewsController.searchNewsData['data'][index]['description']}',
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
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
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            '${searchNewsController.searchNewsData['data'][index]['source']}',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                searchNewsController.searchNewsData['data'][index]
                                                                            [
                                                                            'type'] ==
                                                                        1
                                                                    ? 'Positive /'
                                                                    : searchNewsController.searchNewsData['data'][index]['type'] ==
                                                                            -1
                                                                        ? 'Negative /'
                                                                        : 'Neutral',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: searchNewsController.searchNewsData['data'][index]
                                                                              [
                                                                              'type'] ==
                                                                          1
                                                                      ? Colors
                                                                          .green
                                                                      : searchNewsController.searchNewsData['data'][index]['type'] ==
                                                                              -1
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .blue,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ),
                                                              Text(
                                                                '${dateConverter(searchNewsController.searchNewsData['data'][index]['updatedAt'].toString())}',
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          deleteDialog(
                                                              onPress:
                                                                  () async {
                                                                await DeleteNewsRepo()
                                                                    .deleteNewsRepo(
                                                                        text:
                                                                            '${searchNewsController.searchNewsData['data'][index]['_id']}');

                                                                await searchNewsController.getSearchNewsViewModel(
                                                                    isLoading:
                                                                        false,
                                                                    text: searchController
                                                                        .text
                                                                        .trim()
                                                                        .toString());
                                                              },
                                                              header:
                                                                  'Are you sure to delete this news ?',
                                                              context: context);
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
                                                            border: Border.all(
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
                                                          newsSelect = true;

                                                          titleController.text =
                                                              searchNewsController
                                                                  .searchNewsData[
                                                                      'data']
                                                                      [index]
                                                                      ['title']
                                                                  .toString();
                                                          sourceController
                                                                  .text =
                                                              searchNewsController
                                                                  .searchNewsData[
                                                                      'data']
                                                                      [index]
                                                                      ['source']
                                                                  .toString();
                                                          descriptionController
                                                                  .text =
                                                              searchNewsController
                                                                  .searchNewsData[
                                                                      'data']
                                                                      [index][
                                                                      'description']
                                                                  .toString();

                                                          getCompanyViewModel
                                                                  .selectedCompanyValue =
                                                              searchNewsController
                                                                  .searchNewsData[
                                                                      'data']
                                                                      [index][
                                                                      'companyId']
                                                                      ['_id']
                                                                  .toString();
                                                          getNewsCategoriesViewModel
                                                                  .selectedValue =
                                                              searchNewsController
                                                                  .searchNewsData[
                                                                      'data']
                                                                      [index][
                                                                      'categoryId']
                                                                      ['_id']
                                                                  .toString();
                                                          addNewsDialog(
                                                              context,
                                                              searchNewsController
                                                                          .searchNewsData[
                                                                      'data'][
                                                                  index]['_id'],
                                                              responseModel!,
                                                              controller,
                                                              newsSelect);
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
                                                            border: Border.all(
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
                                                      SizedBox(
                                                        width: 30,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : SizedBox();
                                        },
                                      );
                              }
                              return const Center(
                                child: Text('Something went wrong'),
                              );
                            },
                          ),
                          // if (controller.changeData == false)
                          //   SingleChildScrollView(
                          //     physics: const BouncingScrollPhysics(),
                          //     scrollDirection: Axis.horizontal,
                          //     child: Padding(
                          //       padding:
                          //           const EdgeInsets.symmetric(horizontal: 20),
                          //       child: Row(
                          //         // mainAxisAlignment: MainAxisAlignment.,
                          //
                          //         children: List.generate(
                          //           responseModel!.data!.length,
                          //           (index) => Row(
                          //             children: [
                          //               InkWell(
                          //                 borderRadius:
                          //                     BorderRadius.circular(20),
                          //                 onTap: () async {
                          //                   controller.updateCategories(index);
                          //                   await getNewsViewModel
                          //                       .getNewsViewModel(
                          //                           id: responseModel!
                          //                               .data![controller
                          //                                   .selectedCategories]
                          //                               .id);
                          //                 },
                          //                 child: Container(
                          //                   padding: const EdgeInsets.all(8),
                          //                   decoration: BoxDecoration(
                          //                     borderRadius:
                          //                         BorderRadius.circular(20),
                          //                     border: Border.all(
                          //                         color: AppColor.mainColor),
                          //                     color: controller
                          //                                 .selectedCategories ==
                          //                             index
                          //                         ? AppColor.mainColor
                          //                         : AppColor.whiteColor,
                          //                   ),
                          //                   child: Text(
                          //                     responseModel!
                          //                                 .data![index].name ==
                          //                             null
                          //                         ? 'NA'
                          //                         : responseModel!
                          //                             .data![index].name!,
                          //                     style: TextStyle(
                          //                       fontWeight: FontWeight.w600,
                          //                       color: controller
                          //                                   .selectedCategories ==
                          //                               index
                          //                           ? AppColor.whiteColor
                          //                           : AppColor.mainColor,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 width: 30,
                          //               )
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // const SizedBox(
                          //   height: 20,
                          // ),
                          // if (controller.changeData == false)
                          //   GetBuilder<GetNewsViewModel>(
                          //     builder: (getNewsController) {
                          //       if (getNewsController
                          //               .getNewsApiResponse.status ==
                          //           Status.LOADING) {
                          //         return const Center(
                          //           child: CircularProgressIndicator(),
                          //         );
                          //       }
                          //       if (getNewsController
                          //               .getNewsApiResponse.status ==
                          //           Status.COMPLETE) {
                          //         return (getNewsController.newsData['data']
                          //                         as List)
                          //                     .isEmpty ==
                          //                 true
                          //             ? Center(
                          //                 child: Text('No news found'),
                          //               )
                          //             : ListView.separated(
                          //                 separatorBuilder: (context, index) {
                          //                   return const SizedBox(
                          //                     height: 20,
                          //                   );
                          //                 },
                          //                 itemCount:
                          //                     getNewsController.newsData == null
                          //                         ? 0
                          //                         : (getNewsController
                          //                                     .newsData['data']
                          //                                 as List)
                          //                             .length,
                          //                 shrinkWrap: true,
                          //                 itemBuilder: (context, index) {
                          //                   return Container(
                          //                     width: width,
                          //                     // margin:
                          //                     //     const EdgeInsets.symmetric(
                          //                     //         horizontal: 20),
                          //                     padding:
                          //                         const EdgeInsets.symmetric(
                          //                             //         horizontal: 25,
                          //                             vertical: 25),
                          //                     alignment: Alignment.centerLeft,
                          //                     decoration: BoxDecoration(
                          //                       color: AppColor.whiteColor,
                          //                       // borderRadius:
                          //                       //     BorderRadius.circular(10),
                          //                     ),
                          //                     child: Row(
                          //                       // '${getNewsController.newsData['data'][index]['title']}',
                          //                       children: [
                          //                         Expanded(
                          //                           flex: 1,
                          //                           child: Container(
                          //                             alignment:
                          //                                 Alignment.center,
                          //                             child: Text(
                          //                               '${getNewsController.newsData['data'][index]['companyId']['name']}',
                          //                               style: TextStyle(
                          //                                 fontSize: 16,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         Expanded(
                          //                           flex: 1,
                          //                           child: Container(
                          //                             alignment:
                          //                                 Alignment.center,
                          //                             child: Text(
                          //                               '${getNewsController.newsData['data'][index]['companyId']['shortName']}',
                          //                               style: TextStyle(
                          //                                 fontSize: 16,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         Expanded(
                          //                           flex: 2,
                          //                           child: Container(
                          //                             alignment:
                          //                                 Alignment.center,
                          //                             child: Text(
                          //                               '${getNewsController.newsData['data'][index]['title']}',
                          //                               style: TextStyle(
                          //                                 fontSize: 16,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         Expanded(
                          //                           flex: 3,
                          //                           child: Container(
                          //                             alignment:
                          //                                 Alignment.center,
                          //                             child: Text(
                          //                               '${getNewsController.newsData['data'][index]['description']}',
                          //                               maxLines: 3,
                          //                               overflow: TextOverflow
                          //                                   .ellipsis,
                          //                               style: TextStyle(
                          //                                 fontSize: 16,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         Expanded(
                          //                           flex: 1,
                          //                           child: Container(
                          //                             alignment:
                          //                                 Alignment.center,
                          //                             child: Text(
                          //                               '${getNewsController.newsData['data'][index]['source']}',
                          //                               style: TextStyle(
                          //                                 fontSize: 16,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         SizedBox(
                          //                           width: 20,
                          //                         ),
                          //                         InkWell(
                          //                           onTap: () {
                          //                             deleteDialog(
                          //                                 onPress: () async {
                          //                                   await DeleteNewsRepo()
                          //                                       .deleteNewsRepo(
                          //                                           text:
                          //                                               '${getNewsController.newsData['data'][index]['_id']}');
                          //
                          //                                   await getNewsViewModel
                          //                                       .getNewsViewModel(
                          //                                           id: responseModel!
                          //                                               .data![controller
                          //                                                   .selectedCategories]
                          //                                               .id);
                          //                                 },
                          //                                 header:
                          //                                     'Are you sure to delete this news ?',
                          //                                 context: context);
                          //                           },
                          //                           child: Container(
                          //                             height: 30,
                          //                             width: 30,
                          //                             decoration: BoxDecoration(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(3),
                          //                               border: Border.all(
                          //                                 color: AppColor
                          //                                     .mainColor,
                          //                               ),
                          //                             ),
                          //                             child: Center(
                          //                               child: Icon(
                          //                                 Icons.delete,
                          //                                 size: 20,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         SizedBox(
                          //                           width: 20,
                          //                         ),
                          //                         InkWell(
                          //                           onTap: () {
                          //                             newsSelect = true;
                          //                             titleController.text =
                          //                                 getNewsController
                          //                                     .newsData['data']
                          //                                         [index]
                          //                                         ['title']
                          //                                     .toString();
                          //                             sourceController.text =
                          //                                 getNewsController
                          //                                     .newsData['data']
                          //                                         [index]
                          //                                         ['source']
                          //                                     .toString();
                          //                             descriptionController
                          //                                     .text =
                          //                                 getNewsController
                          //                                     .newsData['data']
                          //                                         [index][
                          //                                         'description']
                          //                                     .toString();
                          //                             typeController
                          //                                 .selectedType
                          //                                 .value = getNewsController
                          //                                                 .newsData[
                          //                                             'data'][index]
                          //                                         ['type'] ==
                          //                                     1
                          //                                 ? 'Positive'
                          //                                 : getNewsController.newsData[
                          //                                                     'data']
                          //                                                 [
                          //                                                 index]
                          //                                             [
                          //                                             'type'] ==
                          //                                         -1
                          //                                     ? 'Negative'
                          //                                     : 'Neutral';
                          //                             getCompanyViewModel
                          //                                     .selectedCompanyValue =
                          //                                 getNewsController
                          //                                     .newsData['data']
                          //                                         [index]
                          //                                         ['companyId']
                          //                                         ['_id']
                          //                                     .toString();
                          //                             getNewsCategoriesViewModel
                          //                                     .selectedValue =
                          //                                 getNewsController
                          //                                     .newsData['data']
                          //                                         [index]
                          //                                         ['categoryId']
                          //                                         ['_id']
                          //                                     .toString();
                          //                             addNewsDialog(
                          //                                 context,
                          //                                 getNewsController
                          //                                             .newsData[
                          //                                         'data'][index]
                          //                                     ['_id'],
                          //                                 responseModel!,
                          //                                 controller,
                          //                                 newsSelect);
                          //                           },
                          //                           child: Container(
                          //                             height: 30,
                          //                             width: 30,
                          //                             decoration: BoxDecoration(
                          //                               borderRadius:
                          //                                   BorderRadius
                          //                                       .circular(3),
                          //                               border: Border.all(
                          //                                 color: AppColor
                          //                                     .mainColor,
                          //                               ),
                          //                             ),
                          //                             child: Center(
                          //                               child: Icon(
                          //                                 Icons.edit,
                          //                                 size: 20,
                          //                               ),
                          //                             ),
                          //                           ),
                          //                         ),
                          //                         SizedBox(
                          //                           width: 10,
                          //                         ),
                          //                       ],
                          //                     ),
                          //                   );
                          //                 },
                          //               );
                          //       }
                          //       return const Center(
                          //         child: Text('Something went wrong'),
                          //       );
                          //     },
                          //   )
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('Something went wrong'),
                    );
            }
            return const Center(
              child: Text('Something went wrong...'),
            );
          },
        ),
      ),
    );
  }

  addNewsDialog(
      BuildContext context,
      String newsId,
      GetNewsCategoriesResponseModel newsResponse,
      GetNewsCategoriesViewModel controller,
      bool selectNews) {
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
                                  titleController.clear();
                                  descriptionController.clear();
                                  getCompanyViewModel.selectedCompanyValue =
                                      null;
                                  controller.selectedValue = null;
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
                                    selectNews == false
                                        ? 'Add News'
                                        : 'Edit News',
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
                                'Heading',
                                style: TextStyle(
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
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    border: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                    fillColor: Colors.grey.shade50,
                                    filled: true,
                                    contentPadding:
                                        const EdgeInsets.only(top: 5, left: 10),
                                    hintText: 'Enter Heading',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Source',
                                style: TextStyle(
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
                                  controller: sourceController,
                                  decoration: InputDecoration(
                                    border: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                    fillColor: Colors.grey.shade50,
                                    filled: true,
                                    contentPadding:
                                        const EdgeInsets.only(top: 5, left: 10),
                                    hintText: 'Enter source',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Obx(
                                    () => Checkbox(
                                        value: genericType.value,
                                        onChanged: (val) {
                                          genericType.value = val!;
                                          if (genericType.value == true) {
                                            typeController.type =
                                                ['Positive', 'Negative'].obs;
                                          } else {
                                            typeController.type = [
                                              'Positive',
                                              'Negative',
                                              'Neutral'
                                            ].obs;
                                          }
                                          setStat(() {});
                                        }),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Generic ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (genericType.value == false)
                                const Text(
                                  'Type',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (genericType.value == false)
                                const SizedBox(
                                  height: 10,
                                ),
                              if (genericType.value == false)
                                Obx(
                                  () => Container(
                                    height: 40,
                                    width: 380,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        border:
                                            Border.all(color: AppColor.grey100),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        hint: const Text('Select Categories'),
                                        value:
                                            typeController.selectedType.value,
                                        items: typeController.type
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e,
                                                  style: TextStyle(
                                                    color: AppColor.blackColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (val) {
                                          typeController.updateSelectedType(
                                              val.toString());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              if (genericType.value == false)
                                const SizedBox(
                                  height: 20,
                                ),
                              const Text(
                                'Categories',
                                style: TextStyle(
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
                                    hint: const Text('Select Categories'),
                                    value: controller.selectedValue,
                                    items: newsResponse.data!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(
                                              '${e.name}',
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      setStat(() {
                                        controller.updateValue(val!);
                                      });
                                      log('MESSAGE ;- ${controller.selectedValue}');
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              if (genericType.value == false)
                                const Text(
                                  'Company',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              if (genericType.value == false)
                                const SizedBox(
                                  height: 10,
                                ),
                              if (genericType.value == false)
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                              log('Company ID;- ${controller.selectedValue}');
                                            },
                                          ),
                                        ),
                                      );
                                    }
                                    return SizedBox();
                                  },
                                ),
                              if (genericType.value == false)
                                const SizedBox(
                                  height: 20,
                                ),
                              const Text(
                                'Associated News',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 140,
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
                                    hintText: 'Write here...',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 400,
                                  height: 45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                    ),
                                    onPressed: () async {
                                      if (titleController.text.isNotEmpty &&
                                          descriptionController
                                              .text.isNotEmpty &&
                                          controller.selectedValue != null) {
                                        if (newsSelect == false) {
                                          log('ENTER ADD MODE');

                                          await addNewsViewModel
                                              .addNewsViewModel(
                                            model: {
                                              "title": titleController.text
                                                  .trim()
                                                  .toString(),
                                              "description":
                                                  descriptionController.text
                                                      .trim()
                                                      .toString(),
                                              "source": sourceController.text
                                                  .trim()
                                                  .toString(),
                                              "companyId": genericType.value ==
                                                      true
                                                  ? '63bfd030d199b9b481468708'
                                                  : getCompanyViewModel
                                                      .selectedCompanyValue,
                                              "categoryId":
                                                  controller.selectedValue,
                                              "generic": genericType.value,
                                              "type": typeController
                                                          .selectedType.value ==
                                                      'Positive'
                                                  ? 1
                                                  : typeController.selectedType
                                                              .value ==
                                                          'Negative'
                                                      ? -1
                                                      : 0
                                            },
                                          );

                                          log('------BODY--------${{
                                            "title": titleController.text
                                                .trim()
                                                .toString(),
                                            "description": descriptionController
                                                .text
                                                .trim()
                                                .toString(),
                                            "source": sourceController.text
                                                .trim()
                                                .toString(),
                                            "companyId":
                                                genericType.value == true
                                                    ? '63bfd030d199b9b481468708'
                                                    : getCompanyViewModel
                                                        .selectedCompanyValue,
                                            "categoryId":
                                                controller.selectedValue,
                                            "generic": genericType.value,
                                            "type": genericType.value == true
                                                ? 'Positive'
                                                : typeController.selectedType
                                                            .value ==
                                                        'Positive'
                                                    ? 1
                                                    : typeController
                                                                .selectedType
                                                                .value ==
                                                            'Negative'
                                                        ? -1
                                                        : 0
                                          }}');

                                          if (addNewsViewModel
                                                  .addNewsApiResponse.status ==
                                              Status.COMPLETE) {
                                            Get.back();

                                            snackBarGet('News Added',
                                                snackBarBackGroundColor:
                                                    AppColor.greenColor);
                                          }
                                          if (addNewsViewModel
                                                  .addNewsApiResponse.status ==
                                              Status.ERROR) {
                                            Get.back();
                                            titleController.clear();
                                            descriptionController.clear();
                                            getCompanyViewModel
                                                .selectedCompanyValue = null;
                                            controller.selectedValue = null;
                                            snackBarGet(
                                              'Something went wrong1',
                                              snackBarBackGroundColor:
                                                  AppColor.redColor,
                                            );
                                          }
                                        } else {
                                          log('ENTER EDIT MODE');
                                          log('News Id :- ${newsId}');
                                          log('CATEGORIES  Id :- ${controller.selectedValue}');
                                          await EditNewsRepo()
                                              .editNewsRepo(body: {
                                            "title": titleController.text
                                                .trim()
                                                .toString(),
                                            "description": descriptionController
                                                .text
                                                .trim()
                                                .toString(),
                                            "generic": genericType.value,
                                            "source": sourceController.text
                                                .trim()
                                                .toString(),
                                            "companyId": getCompanyViewModel
                                                .selectedCompanyValue,
                                            "categoryId":
                                                controller.selectedValue,
                                            "type": typeController
                                                        .selectedType.value ==
                                                    'Positive'
                                                ? "1"
                                                : typeController.selectedType
                                                            .value ==
                                                        'Negative'
                                                    ? "-1"
                                                    : "0"
                                          }, text: newsId);
                                        }
                                      } else {
                                        snackBarGet(
                                          'Fill necessary details',
                                          snackBarBackGroundColor:
                                              AppColor.redColor,
                                        );
                                      }
                                      await searchNewsController
                                          .getSearchNewsViewModel(
                                              text: '', companyId: '');
                                    },
                                    child: Text(
                                      newsSelect == true ? 'Update' : 'Add',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
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
      genericType.value = false;
      typeController.selectedType.value = 'Positive';
      titleController.clear();
      descriptionController.clear();
      getCompanyViewModel.selectedCompanyValue = null;
      controller.selectedValue = null;
      sourceController.clear();
    });
  }

  Widget buildSticker() {
    return SizedBox(
      height: 400,
      width: 400,
      child: EmojiPicker(
        textEditingController: descriptionController,
        config: Config(emojiSizeMax: 20),
        onEmojiSelected: (emoji, category) {
          print(emoji);
        },
      ),
    );
  }
}
