import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Screens/movres/movers_screen.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/insider_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InsiderScreen extends StatefulWidget {
  const InsiderScreen({Key? key}) : super(key: key);

  @override
  State<InsiderScreen> createState() => _InsiderScreenState();
}

class _InsiderScreenState extends State<InsiderScreen> {
  GetCompanyViewModel getCompanyViewModel = Get.put(GetCompanyViewModel());
  InsiderViewModel insiderViewModel = Get.put(InsiderViewModel());
  TextEditingController sharesSoldController = TextEditingController();
  TextEditingController sharesSoldPersonController = TextEditingController();
  TextEditingController sharesBoughtController = TextEditingController();
  TextEditingController sharesBoughtPersonController = TextEditingController();
  TextEditingController personCategoryController = TextEditingController();
  TextEditingController sharesController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController transactionTypeController = TextEditingController();
  TextEditingController modeController = TextEditingController();

  @override
  void initState() {
    getCompanyViewModel.getCompanyViewModel();
    insiderViewModel.getInsiderViewModel();
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
                      'Insider',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 83,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.mainColor,
                        ),
                        onPressed: () {
                          addInsiderDialog(context);
                          // newsCategoriesAddDialog(context);
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
                        // alignment: Alignment.centerLeft,
                        alignment: Alignment.center,

                        child: Text(
                          'Categories of Person',
                          maxLines: 2,
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
                          'Shares',
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
                          'value',
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
                          'Transcation Type',
                          maxLines: 2,
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
                          'Mode of acquisition',
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
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<InsiderViewModel>(
                    builder: (controller) {
                      if (controller.getInsiderApiResponse.status ==
                          Status.LOADING) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (controller.getInsiderApiResponse.status ==
                          Status.COMPLETE) {
                        return (controller.insiderData['data'] as List)
                                    .isEmpty ==
                                true
                            ? Center(
                                child: Text('No Insider Added'),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount:
                                    (controller.insiderData['data'] as List)
                                        .length,
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: width,
                                    // margin: const EdgeInsets.symmetric(horizontal: 20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: AppColor.whiteColor,
                                      // borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            color: Colors.transparent,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              '${controller.insiderData['data'][index]['name']}',
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
                                              '${controller.insiderData['data'][index]['shortName']}',
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
                                              controller.insiderData['data']
                                                          [index]['insiders'] ==
                                                      null
                                                  ? "NA"
                                                  : '${controller.insiderData['data'][index]['insiders']['table'][0]['personCategory'] ?? 'NA'}',
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
                                              controller.insiderData['data']
                                                          [index]['insiders'] ==
                                                      null
                                                  ? "NA"
                                                  : '${controller.insiderData['data'][index]['insiders']['table'][0]['shares'] ?? 'NA'}',
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
                                              controller.insiderData['data']
                                                          [index]['insiders'] ==
                                                      null
                                                  ? "NA"
                                                  : '${controller.insiderData['data'][index]['insiders']['table'][0]['value'] ?? 'NA'}',
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
                                              controller.insiderData['data']
                                                          [index]['insiders'] ==
                                                      null
                                                  ? "NA"
                                                  : '${controller.insiderData['data'][index]['insiders']['table'][0]['transactionType'] ?? 'NA'}',
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
                                              controller.insiderData['data']
                                                          [index]['insiders'] ==
                                                      null
                                                  ? "NA"
                                                  : '${controller.insiderData['data'][index]['insiders']['table'][0]['mode'] ?? 'NA'}',
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
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

  addInsiderDialog(
    BuildContext context,
  ) {
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
                                    'Add Insider',
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
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Shares Sold',
                                  hint: 'Shares Sold',
                                  textEditingController: sharesSoldController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Shares Sold Person',
                                  hint: 'Shares Sold Person',
                                  textInputType: TextInputType.number,
                                  textEditingController:
                                      sharesSoldPersonController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Shares Bought',
                                  hint: 'Shares Bought',
                                  textEditingController:
                                      sharesBoughtController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Shares Bought Person',
                                  hint: 'Shares Bought Person',
                                  textEditingController:
                                      sharesBoughtPersonController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Person Category',
                                  hint: 'Person Category',
                                  textEditingController:
                                      personCategoryController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Shares',
                                  hint: 'Shares',
                                  textEditingController: sharesController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Share Value',
                                  hint: 'Share Value',
                                  textEditingController: valueController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Transaction Type',
                                  hint: 'Transaction Type',
                                  textEditingController:
                                      transactionTypeController),
                              const SizedBox(
                                height: 20,
                              ),
                              addDataForm(
                                  header: 'Transaction Mode',
                                  hint: 'Transaction Mode',
                                  textEditingController: modeController),
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
                                      await insiderViewModel
                                          .addInsiderViewModel(model: {
                                        "companyId":
                                            "${getCompanyViewModel.selectedCompanyValue}",
                                        "sharesSold": {
                                          "shares": sharesSoldController.text,
                                          "person":
                                              sharesSoldPersonController.text
                                        },
                                        "sharesBought": {
                                          "shares": sharesBoughtController.text,
                                          "person":
                                              sharesBoughtPersonController.text
                                        },
                                        "table": {
                                          "personCategory":
                                              "${personCategoryController.text}",
                                          "shares": sharesController.text,
                                          "value": valueController.text,
                                          "transactionType":
                                              "${transactionTypeController.text}",
                                          "mode": "${modeController.text}"
                                        }
                                      });

                                      if (insiderViewModel
                                              .addInsiderApiResponse.status ==
                                          Status.COMPLETE) {
                                        Get.back();

                                        snackBarGet('Insider Added',
                                            snackBarBackGroundColor:
                                                AppColor.greenColor);
                                      }
                                      if (insiderViewModel
                                              .addInsiderApiResponse.status ==
                                          Status.ERROR) {
                                        Get.back();

                                        snackBarGet('Something went wrong',
                                            snackBarBackGroundColor:
                                                AppColor.redColor);
                                      }
                                      await insiderViewModel
                                          .getInsiderViewModel(
                                              isLoading: false);
                                    },
                                    child: Text(
                                      'Add',
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
      getCompanyViewModel.selectedCompanyValue = null;
      sharesSoldController.clear();
      sharesSoldPersonController.clear();
      sharesBoughtController.clear();
      sharesBoughtPersonController.clear();
      personCategoryController.clear();
      sharesController.clear();
      valueController.clear();
      transactionTypeController.clear();
      modeController.clear();
    });
  }
}
