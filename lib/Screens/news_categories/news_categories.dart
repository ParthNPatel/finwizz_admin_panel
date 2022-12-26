import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/get_news_cetegories_res_model.dart';
import 'package:finwizz_admin/Screens/movres/movers_screen.dart';
import 'package:finwizz_admin/ViewModel/add_news_categories_view_model.dart';
import 'package:finwizz_admin/ViewModel/news_categories_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
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

  @override
  void initState() {
    getNewsCategoriesViewModel.getNewsCategoriesViewModel();
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
                      'News Categories',
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
                          newsCategoriesAddDialog(context);
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
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
                              ? ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      height: 20,
                                    );
                                  },
                                  itemCount: responseModel!.data!.length,
                                  shrinkWrap: true,
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                          alignment: Alignment.centerLeft,
                                          decoration: BoxDecoration(
                                            color: AppColor.whiteColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            '${responseModel!.data![index].name ?? "NA"}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  newsCategoriesAddDialog(BuildContext context) {
    InputBorder outlineBorder = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(7));
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
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
                                'Add Categories',
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
    );
  }
}
