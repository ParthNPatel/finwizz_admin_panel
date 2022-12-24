import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/connect_us_res_model.dart';
import 'package:finwizz_admin/ViewModel/connect_us_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Connect Us',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
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
                                    itemCount:
                                        responseModel!.data!.docs!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Container(
                                          width: width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 25),
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
                                                responseModel!.data!
                                                        .docs![index].name ??
                                                    "NA",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                responseModel!.data!
                                                        .docs![index].email ??
                                                    "NA",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                responseModel!.data!
                                                        .docs![index].message ??
                                                    "NA",
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
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
          )),
    );
  }

  // addConnectUsDialog(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     barrierColor: Colors.black12,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setStat) {
  //           return Scaffold(
  //             backgroundColor: Colors.transparent,
  //             body: Center(
  //               child: Container(
  //                 height: 600,
  //                 width: 465,
  //                 clipBehavior: Clip.antiAliasWithSaveLayer,
  //                 decoration: BoxDecoration(
  //                   color: AppColor.whiteColor,
  //                   borderRadius: BorderRadius.circular(10),
  //                 ),
  //                 child: SingleChildScrollView(
  //                   child: Column(
  //                     children: [
  //                       Container(
  //                         padding: const EdgeInsets.all(17),
  //                         color: AppColor.mainColor,
  //                         child: Stack(
  //                           alignment: Alignment.topRight,
  //                           children: [
  //                             GestureDetector(
  //                               onTap: () {
  //                                 Get.back();
  //                               },
  //                               child: CircleAvatar(
  //                                 radius: 10,
  //                                 backgroundColor: AppColor.whiteColor,
  //                                 child: FittedBox(
  //                                   child: Icon(
  //                                     Icons.clear,
  //                                     color: AppColor.mainColor,
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Text(
  //                                   'Add ConnectUs',
  //                                   style: TextStyle(
  //                                     fontWeight: FontWeight.w600,
  //                                     color: AppColor.whiteColor,
  //                                     fontSize: 18,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       Padding(
  //                         padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             addDataForm(
  //                                 textEditingController: titleController,
  //                                 header: 'Name',
  //                                 hint: 'Name'),
  //                             const SizedBox(
  //                               height: 20,
  //                             ),
  //                             addDataForm(
  //                                 textEditingController: titleController,
  //                                 header: 'Email',
  //                                 hint: 'Email'),
  //                             const SizedBox(
  //                               height: 20,
  //                             ),
  //                             const Text(
  //                               'Description',
  //                               style: TextStyle(
  //                                 fontSize: 16,
  //                                 fontWeight: FontWeight.w500,
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               height: 10,
  //                             ),
  //                             SizedBox(
  //                               height: 140,
  //                               width: 380,
  //                               child: TextField(
  //                                 controller: descriptionController,
  //                                 maxLines: 5,
  //                                 decoration: InputDecoration(
  //                                   border: outlineBorder,
  //                                   focusedBorder: outlineBorder,
  //                                   enabledBorder: outlineBorder,
  //                                   fillColor: Colors.grey.shade50,
  //                                   filled: true,
  //                                   contentPadding: const EdgeInsets.only(
  //                                     top: 25,
  //                                     left: 10,
  //                                   ),
  //                                   hintText: 'Write here...',
  //                                 ),
  //                               ),
  //                             ),
  //                             const SizedBox(
  //                               height: 35,
  //                             ),
  //                             Align(
  //                               alignment: Alignment.center,
  //                               child: SizedBox(
  //                                 width: 200,
  //                                 child: ElevatedButton(
  //                                   style: ElevatedButton.styleFrom(
  //                                     backgroundColor: AppColor.mainColor,
  //                                   ),
  //                                   onPressed: () async {
  //                                     await addConnectUs();
  //                                   },
  //                                   child: Text(
  //                                     'Add',
  //                                     style: TextStyle(
  //                                       fontSize: 15,
  //                                       color: AppColor.whiteColor,
  //                                       fontWeight: FontWeight.w500,
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  //
  // addConnectUs() async {
  //   log('ADD');
  //   Get.back();
  // }
}
