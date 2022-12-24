import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
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
                            Row(
                              children: [
                                // SizedBox(
                                //   height: 40,
                                //   width: 250,
                                //   child: TextField(
                                //     controller: searchController,
                                //     decoration: InputDecoration(
                                //       border: outline,
                                //       focusedBorder: outline,
                                //       enabledBorder: outline,
                                //       contentPadding: const EdgeInsets.only(
                                //           top: 5, left: 10),
                                //       suffixIcon: Icon(
                                //         Icons.search,
                                //         color: Colors.grey.shade400,
                                //         size: 20,
                                //       ),
                                //       hintText: 'Search....',
                                //     ),
                                //   ),
                                // ),
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
                                      addVideoDialog(context);
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
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 25),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: AppColor.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${controller.moversData['data'][index]['title']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${controller.moversData['data'][index]['description']}',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
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

  addVideoDialog(BuildContext context) {
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
                                    'Add Movers',
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
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Price',
                                  hint: 'Price',
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
                                                  value: e.id,
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
                                'Description',
                                style: TextStyle(
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
                                            width: 200,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColor.mainColor,
                                              ),
                                              onPressed: () async {
                                                if (titleController.text.isNotEmpty &&
                                                    descriptionController
                                                        .text.isNotEmpty &&
                                                    priceController
                                                        .text.isNotEmpty &&
                                                    percentageController
                                                        .text.isNotEmpty &&
                                                    getCompanyViewModel
                                                            .selectedCompanyValue !=
                                                        null) {
                                                  await addMoversViewModel
                                                      .addMoversViewModel(
                                                          model: {
                                                        "title": titleController
                                                            .text
                                                            .trim()
                                                            .toString(),
                                                        "description":
                                                            descriptionController
                                                                .text
                                                                .trim()
                                                                .toString(),
                                                        "companyId":
                                                            "${getCompanyViewModel.selectedCompanyValue}",
                                                        "price": priceController
                                                            .text
                                                            .trim()
                                                            .toString(),
                                                        "percentage":
                                                            percentageController
                                                                .text
                                                                .trim()
                                                                .toString()
                                                      });

                                                  if (addMoversViewModel
                                                          .addMoversApiResponse
                                                          .status ==
                                                      Status.COMPLETE) {
                                                    Get.back();
                                                    await getMoversViewModel
                                                        .getMoversViewModel();
                                                    clearData();

                                                    snackBarGet('Movers Added',
                                                        snackBarBackGroundColor:
                                                            AppColor
                                                                .greenColor);
                                                  }
                                                  if (addMoversViewModel
                                                          .addMoversApiResponse
                                                          .status ==
                                                      Status.ERROR) {
                                                    Get.back();
                                                    clearData();
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
                                              },
                                              child: Text(
                                                'Add',
                                                style: TextStyle(
                                                  fontSize: 15,
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
    );
  }

  clearData() {
    titleController.clear();
    descriptionController.clear();
    priceController.clear();
    percentageController.clear();
    getCompanyViewModel.selectedCompanyValue = null;
  }
}

Widget addDataForm(
    {String? header,
    String? hint,
    TextEditingController? textEditingController}) {
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
