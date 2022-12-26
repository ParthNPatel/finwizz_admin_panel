import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Model/Response_model/get_news_cetegories_res_model.dart';
import 'package:finwizz_admin/ViewModel/add_news_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_news_view_model.dart';
import 'package:finwizz_admin/ViewModel/news_categories_view_model.dart';
import 'package:finwizz_admin/ViewModel/search_news_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:finwizz_admin/controller/type_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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

  GetNewsCategoriesResponseModel? responseModel;
  @override
  void initState() {
    getNewsCategoriesViewModel.getNewsCategoriesViewModel();
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
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 250,
                                      child: TextField(
                                        controller: searchController,
                                        onChanged: (val) async {
                                          if (searchController
                                              .text.isNotEmpty) {
                                            controller.updateChangeValue(true);
                                            await searchNewsController
                                                .getSearchNewsViewModel(
                                                    isLoading: false,
                                                    text: searchController.text
                                                        .trim()
                                                        .toString());
                                          } else {
                                            controller.updateChangeValue(false);
                                          }
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
                                          addNewsDialog(context, responseModel!,
                                              controller);
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
                          if (controller.changeData == true)
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
                                  log('RESPONSE LIST ;- ${(searchNewsController.searchNewsData['data']['docs'] as List).isEmpty}');
                                  return (searchNewsController
                                                      .searchNewsData['data']
                                                  ['docs'] as List)
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
                                                          .searchNewsData[
                                                      'data']['docs'] as List)
                                                  .isEmpty
                                              ? 0
                                              : (searchNewsController
                                                          .searchNewsData[
                                                      'data']['docs'] as List)
                                                  .length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            log('TOTAL DATA :_ ${searchNewsController.searchNewsData['data']['total']}');
                                            log('TOTAL DATA :_ ${searchNewsController.searchNewsData['data']['total'].runtimeType}');
                                            return Container(
                                              width: width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 25),
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                color: AppColor.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${searchNewsController.searchNewsData['data']['docs'][index]['title']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${searchNewsController.searchNewsData['data']['docs'][index]['description']}',
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                }
                                return const Center(
                                  child: Text('Something went wrong'),
                                );
                              },
                            ),
                          if (controller.changeData == false)
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.,

                                  children: List.generate(
                                    responseModel!.data!.length,
                                    (index) => Row(
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () async {
                                            controller.updateCategories(index);
                                            await getNewsViewModel
                                                .getNewsViewModel(
                                                    id: responseModel!
                                                        .data![controller
                                                            .selectedCategories]
                                                        .id);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: AppColor.mainColor),
                                              color: controller
                                                          .selectedCategories ==
                                                      index
                                                  ? AppColor.mainColor
                                                  : AppColor.whiteColor,
                                            ),
                                            child: Text(
                                              responseModel!
                                                          .data![index].name ==
                                                      null
                                                  ? 'NA'
                                                  : responseModel!
                                                      .data![index].name!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: controller
                                                            .selectedCategories ==
                                                        index
                                                    ? AppColor.whiteColor
                                                    : AppColor.mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (controller.changeData == false)
                            GetBuilder<GetNewsViewModel>(
                              builder: (getNewsController) {
                                if (getNewsController
                                        .getNewsApiResponse.status ==
                                    Status.LOADING) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (getNewsController
                                        .getNewsApiResponse.status ==
                                    Status.COMPLETE) {
                                  return (getNewsController.newsData['data']
                                                  as List)
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
                                          itemCount:
                                              getNewsController.newsData == null
                                                  ? 0
                                                  : (getNewsController
                                                              .newsData['data']
                                                          as List)
                                                      .length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              width: width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 25),
                                              alignment: Alignment.centerLeft,
                                              decoration: BoxDecoration(
                                                color: AppColor.whiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${getNewsController.newsData['data'][index]['title']}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    '${getNewsController.newsData['data'][index]['description']}',
                                                    maxLines: 4,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                }
                                return const Center(
                                  child: Text('Something went wrong'),
                                );
                              },
                            )
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
      GetNewsCategoriesResponseModel newsResponse,
      GetNewsCategoriesViewModel controller) {
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
                                    'Add News',
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
                                'Title',
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
                                    hintText: 'Enter Title',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                'Type',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
                                      value: typeController.selectedType.value,
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
                                        typeController
                                            .updateSelectedType(val.toString());
                                      },
                                    ),
                                  ),
                                ),
                              ),
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
                                            log('Company ID;- ${controller.selectedValue}');
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
                              const Text(
                                'Description',
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
                                          getCompanyViewModel
                                                  .selectedCompanyValue !=
                                              null &&
                                          controller.selectedValue != null) {
                                        await addNewsViewModel.addNewsViewModel(
                                          model: {
                                            "title": titleController.text
                                                .trim()
                                                .toString(),
                                            "description": descriptionController
                                                .text
                                                .trim()
                                                .toString(),
                                            "companyId": getCompanyViewModel
                                                .selectedCompanyValue,
                                            "categoryId":
                                                controller.selectedValue,
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

                                        if (addNewsViewModel
                                                .addNewsApiResponse.status ==
                                            Status.COMPLETE) {
                                          Get.back();
                                          await getNewsViewModel
                                              .getNewsViewModel(
                                                  isLoading: false,
                                                  id: controller.selectedValue);
                                          titleController.clear();
                                          descriptionController.clear();
                                          getCompanyViewModel
                                              .selectedCompanyValue = null;
                                          controller.selectedValue = null;
                                          snackBarGet('Movers Added',
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
    );
  }
}
