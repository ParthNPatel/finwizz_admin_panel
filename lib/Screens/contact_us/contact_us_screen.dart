import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/connect_us_res_model.dart';
import 'package:finwizz_admin/ViewModel/connect_us_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ConnectUsViewModel connectUsViewModel = Get.put(ConnectUsViewModel());
  ConnectUsResponseModel? responseModel;
  String? dateInput;
  DateTime? pickDate;
  DateTime? createDate;
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
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        builder: (context, child) {
                                          return Theme(
                                              data: Theme.of(context).copyWith(
                                                colorScheme: ColorScheme.light(
                                                  primary: AppColor.mainColor,
                                                  onPrimary: Colors
                                                      .black, // <-- SEE HERE
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
                                      print(
                                          pickedDate); // 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          size: 18,
                                        ),
                                        SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          dateInput == null
                                              ? 'Date'
                                              : dateInput!,
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
                                    // padding: const EdgeInsets.only(left: 20),
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
                                    // padding: const EdgeInsets.only(left: 20),
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
                                      'Date',
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
                                  createDate = DateTime.parse(responseModel!
                                      .data!.docs![index].updatedAt
                                      .toString()
                                      .split(' ')
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Theme(
                                            data: Theme.of(context).copyWith(
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
                                                                .docs![index]
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
                                                                .docs![index]
                                                                .email ??
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
                                                                .docs![index]
                                                                .message ??
                                                            "NA",
                                                        maxLines: 4,
                                                        overflow: TextOverflow
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
                                                        responseModel!
                                                                .data!
                                                                .docs![index]
                                                                .updatedAt
                                                                .toString()
                                                                .split(' ')
                                                                .first ??
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
