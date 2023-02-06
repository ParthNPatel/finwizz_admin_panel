import 'dart:developer';
import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/connect_us_res_model.dart';
import 'package:finwizz_admin/ViewModel/connect_us_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/date_conveter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  InputBorder outline =
      OutlineInputBorder(borderSide: BorderSide(color: AppColor.grey400));

  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ConnectUsViewModel connectUsViewModel = Get.put(ConnectUsViewModel());
  ConnectUsResponseModel? responseModel;
  DateTimeRange? _selectedDateRange;
  DateTime? stDate;
  DateTime? lsDate;
  DateTime? fsDate;
  DateTime? edDate;
  String? firstDate;
  String? endDate;

  String searchText = "";

  @override
  void initState() {
    connectUsViewModel.connectUsViewModel(limit: 10, page: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: GetBuilder<ConnectUsViewModel>(
          builder: (controller) {
            if (controller.connectUsApiResponse.status == Status.LOADING) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.connectUsApiResponse.status == Status.COMPLETE) {
              try {
                responseModel = controller.connectUsApiResponse.data;
              } catch (e) {
                controller.updateError(true);
              }
              return controller.catchError == false
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Connect Us',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                Spacer(),
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
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
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
                                  child: Container(
                                    color: AppColor.mainColor,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: AppColor.mainColor,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        color: AppColor.whiteColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    color: AppColor.mainColor,
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Detail',
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
                                    child: Text(
                                      'Time stamp',
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: responseModel!.data!.docs!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  String startDate = responseModel!
                                      .data!.docs![index].updatedAt
                                      .toString()
                                      .split(' ')
                                      .first;

                                  if (firstDate != null) {
                                    stDate = DateTime.parse(startDate);
                                    fsDate = DateTime.parse(firstDate!);
                                    edDate = DateTime.parse(endDate!);
                                  }
                                  return firstDate == null ||
                                          fsDate!.isBefore(stDate!) == true &&
                                              edDate!.isAfter(stDate!) == true
                                      ? responseModel!.data!.docs![index].name
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(searchText
                                                      .toLowerCase()) ||
                                              searchText == ''
                                          ? Container(
                                              width: width,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Theme(
                                                data: Theme.of(context)
                                                    .copyWith(
                                                        dividerColor:
                                                            Colors.transparent),
                                                child: Container(
                                                  height: 50,
                                                  width: width,
                                                  // padding: const EdgeInsets.symmetric(
                                                  //     horizontal: 25),
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
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            responseModel!
                                                                    .data!
                                                                    .docs![
                                                                        index]
                                                                    .name ??
                                                                "NA",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          // padding: const EdgeInsets.only(left: 20),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            responseModel!
                                                                    .data!
                                                                    .docs![
                                                                        index]
                                                                    .email ??
                                                                "NA",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Container(
                                                          // padding: const EdgeInsets.only(left: 20),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            responseModel!
                                                                    .data!
                                                                    .docs![
                                                                        index]
                                                                    .message ??
                                                                "NA",
                                                            maxLines: 4,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          // padding: const EdgeInsets.only(left: 20),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            dateConverter(responseModel!
                                                                    .data!
                                                                    .docs![
                                                                        index]
                                                                    .updatedAt
                                                                    .toString()) ??
                                                                "NA",
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                            ),
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
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('Something went wrong'),
                    );
            }
            return const Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }
}
