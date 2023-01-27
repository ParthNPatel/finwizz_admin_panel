import 'dart:developer';

import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:flutter/material.dart';

class UserReportScreen extends StatelessWidget {
  UserReportScreen({Key? key}) : super(key: key);
  List name = ['A', 'B', 'C', 'D'];
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
        // child: GetBuilder<GetCompanyViewModel>(
        //   builder: (controller) {
        //     if (controller.getCompanyApiResponse.status == Status.LOADING) {
        //       return const Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     if (controller.getCompanyApiResponse.status == Status.COMPLETE) {
        //       GetCompanyResponseModel getCompanyResponseModel =
        //           controller.getCompanyApiResponse.data;
        //
        //       return SingleChildScrollView(
        //         physics: const BouncingScrollPhysics(),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 20, vertical: 20),
        //               alignment: Alignment.centerLeft,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   const Text(
        //                     'Company',
        //                     style: TextStyle(
        //                       fontWeight: FontWeight.w600,
        //                       fontSize: 22,
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 40,
        //                     width: 83,
        //                     child: ElevatedButton(
        //                       style: ElevatedButton.styleFrom(
        //                         backgroundColor: AppColor.mainColor,
        //                       ),
        //                       onPressed: () {
        //                         companyAddDialog(context);
        //                       },
        //                       child: Row(
        //                         children: [
        //                           const Icon(
        //                             Icons.add,
        //                             color: Colors.white,
        //                           ),
        //                           Text(
        //                             'Add',
        //                             maxLines: 1,
        //                             overflow: TextOverflow.ellipsis,
        //                             style: TextStyle(
        //                               color: AppColor.whiteColor,
        //                               fontSize: 14,
        //                             ),
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Container(
        //               color: AppColor.mainColor,
        //               padding: const EdgeInsets.all(13),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   Expanded(
        //                     child: Container(
        //                       // padding: const EdgeInsets.only(left: 20),
        //                       color: AppColor.mainColor,
        //                       alignment: Alignment.center,
        //                       child: Text(
        //                         'Stock Name',
        //                         style: TextStyle(
        //                           color: AppColor.whiteColor,
        //                           fontSize: 16,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: Container(
        //                       // padding: const EdgeInsets.only(left: 20),
        //                       color: AppColor.mainColor,
        //                       alignment: Alignment.center,
        //                       child: Text(
        //                         'Stock Ticker',
        //                         style: TextStyle(
        //                           color: AppColor.whiteColor,
        //                           fontSize: 16,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     width: 10,
        //                   ),
        //                   InkWell(
        //                     onTap: () {},
        //                     child: Container(
        //                       height: 30,
        //                       width: 30,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(3),
        //                         border: Border.all(
        //                           color: AppColor.mainColor,
        //                         ),
        //                       ),
        //                       child: Center(
        //                         child: Icon(
        //                           color: Colors.transparent,
        //                           Icons.edit,
        //                           size: 20,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     width: 20,
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const SizedBox(
        //                   height: 20,
        //                 ),
        //                 getCompanyResponseModel.data!.isEmpty == true
        //                     ? Center(
        //                   child: Text('No Company Added'),
        //                 )
        //                     : ListView.separated(
        //                   separatorBuilder: (context, index) {
        //                     return const SizedBox(
        //                       height: 20,
        //                     );
        //                   },
        //                   itemCount: getCompanyResponseModel.data!.length,
        //                   shrinkWrap: true,
        //                   reverse: true,
        //                   itemBuilder: (context, index) {
        //                     return Container(
        //                       width: width,
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(10),
        //                       ),
        //                       child: Theme(
        //                         data: Theme.of(context).copyWith(
        //                             dividerColor: Colors.transparent),
        //                         child: Container(
        //                           height: 50,
        //                           width: width,
        //                           // padding: const EdgeInsets.symmetric(
        //                           //     horizontal: 25),
        //                           alignment: Alignment.center,
        //                           decoration: BoxDecoration(
        //                             color: AppColor.whiteColor,
        //                             // borderRadius:
        //                             //     BorderRadius.circular(10),
        //                           ),
        //                           child: Row(
        //                             children: [
        //                               Expanded(
        //                                 child: Container(
        //                                   // padding: const EdgeInsets.only(left: 20),
        //                                   alignment: Alignment.center,
        //                                   child: Text(
        //                                     '${getCompanyResponseModel.data![index]!.name}',
        //                                     style: TextStyle(
        //                                       fontWeight: FontWeight.w600,
        //                                       fontSize: 20,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                               Expanded(
        //                                 child: Container(
        //                                   // padding: const EdgeInsets.only(left: 20),
        //                                   alignment: Alignment.center,
        //                                   child: Text(
        //                                     '${getCompanyResponseModel.data![index]!.shortName}',
        //                                     style: TextStyle(
        //                                       fontWeight: FontWeight.w600,
        //                                       fontSize: 20,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 width: 10,
        //                               ),
        //                               InkWell(
        //                                 onTap: () {
        //                                   deleteDialog(
        //                                       onPress: () async {
        //                                         await DeleteCompanyRepo()
        //                                             .deleteCompanyRepo(
        //                                             text:
        //                                             '${getCompanyResponseModel.data![index]!.id}');
        //
        //                                         await getCompanyViewModel
        //                                             .getCompanyViewModel(
        //                                             isLoading: false);
        //                                       },
        //                                       header:
        //                                       'Are you sure to delete this company ?',
        //                                       context: context);
        //                                 },
        //                                 child: Container(
        //                                   height: 30,
        //                                   width: 30,
        //                                   decoration: BoxDecoration(
        //                                     borderRadius:
        //                                     BorderRadius.circular(3),
        //                                     border: Border.all(
        //                                       color: AppColor.mainColor,
        //                                     ),
        //                                   ),
        //                                   child: Center(
        //                                     child: Icon(
        //                                       Icons.delete,
        //                                       size: 20,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 width: 30,
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       );
        //     }
        //     return Center(
        //       child: Text('Something went wrong..'),
        //     );
        //   },
        // ),
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
                      'User Report',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    // SizedBox(
                    //   height: 40,
                    //   width: 83,
                    //   child: ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: AppColor.mainColor,
                    //     ),
                    //     onPressed: () {
                    //       companyAddDialog(context);
                    //     },
                    //     child: Row(
                    //       children: [
                    //         const Icon(
                    //           Icons.add,
                    //           color: Colors.white,
                    //         ),
                    //         Text(
                    //           'Add',
                    //           maxLines: 1,
                    //           overflow: TextOverflow.ellipsis,
                    //           style: TextStyle(
                    //             color: AppColor.whiteColor,
                    //             fontSize: 14,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
                          'Username',
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
                          'Stock',
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
                    itemCount: name.length,
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
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
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
                                      '${name[index]}',
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
                                      'TATA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
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
        ),
      ),
    );
  }
}
