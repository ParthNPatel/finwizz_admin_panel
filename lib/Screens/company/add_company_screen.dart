import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/delete_company_repo.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Screens/movres/movers_screen.dart';
import 'package:finwizz_admin/ViewModel/add_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({Key? key}) : super(key: key);

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController sortCompanyNameController = TextEditingController();
  AddCompanyViewModel addCompanyViewModel = Get.put(AddCompanyViewModel());
  GetCompanyViewModel getCompanyViewModel = Get.put(GetCompanyViewModel());
  GetCompanyResponseModel? getCompanyResponseModel;
  @override
  void initState() {
    getCompanyViewModel.getCompanyViewModel(searchText: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        child: GetBuilder<GetCompanyViewModel>(
          builder: (controller) {
            if (controller.getCompanyApiResponse.status == Status.LOADING) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.getCompanyApiResponse.status == Status.COMPLETE) {
              GetCompanyResponseModel getCompanyResponseModel =
                  controller.getCompanyApiResponse.data;

              return SingleChildScrollView(
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
                          const Text(
                            'Company',
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
                                companyAddDialog(context);
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
                                'Stock Name',
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
                                'Stock Ticker',
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        getCompanyResponseModel.data!.isEmpty == true
                            ? Center(
                                child: Text('No Company Added'),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: getCompanyResponseModel.data!.length,
                                shrinkWrap: true,
                                reverse: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
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
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${getCompanyResponseModel.data![index].name}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                // padding: const EdgeInsets.only(left: 20),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${getCompanyResponseModel.data![index].name!.split('').first}${getCompanyResponseModel.data![index].name!.split('')[1]}',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                deleteDialog(
                                                    onPress: () async {
                                                      await DeleteCompanyRepo()
                                                          .deleteCompanyRepo(
                                                              text:
                                                                  '${getCompanyResponseModel.data![index].id}');

                                                      await getCompanyViewModel
                                                          .getCompanyViewModel(
                                                              isLoading: false);
                                                    },
                                                    header:
                                                        'Are you sure to delete this company ?',
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text('Something went wrong..'),
            );
          },
        ),
      ),
    );
  }

  companyAddDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              height: 380,
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
                                'Add Company',
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
                            header: 'Company name',
                            textEditingController: companyNameController,
                            hint: 'Company name',
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          addDataForm(
                            header: 'Stock Ticker',
                            textEditingController: sortCompanyNameController,
                            hint: 'Stock Ticker',
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: GetBuilder<AddCompanyViewModel>(
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
                                            if (companyNameController
                                                .text.isNotEmpty) {
                                              await addCompanyViewModel
                                                  .addCompanyViewModel(model: {
                                                "name": companyNameController
                                                    .text
                                                    .trim()
                                                    .toString(),
                                                "shortName":
                                                    sortCompanyNameController
                                                        .text
                                                        .trim()
                                                        .toString()
                                              });

                                              if (addCompanyViewModel
                                                      .addCompanyApiResponse
                                                      .status ==
                                                  Status.COMPLETE) {
                                                Get.back();
                                                await getCompanyViewModel
                                                    .getCompanyViewModel(
                                                        isLoading: false);
                                                snackBarGet('Company Added',
                                                    snackBarBackGroundColor:
                                                        AppColor.greenColor);
                                              }
                                              if (addCompanyViewModel
                                                      .addCompanyApiResponse
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
                                                'Add Company Name',
                                                snackBarBackGroundColor:
                                                    AppColor.redColor,
                                              );
                                            }
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
      companyNameController.clear();
      sortCompanyNameController.clear();
    });
  }
}

Future deleteDialog({BuildContext? context, onPress, String? header}) {
  return showDialog(
    context: context!,
    builder: (context) {
      return AlertDialog(
        title: Text(header!),
        actions: [
          TextButton(
            onPressed: onPress,
            child: Text(
              'Yes',
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              'No',
            ),
          ),
        ],
      );
    },
  );
}
