import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/ViewModel/add_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/dashboard_panel_tabs.dart';
import 'package:finwizz_admin/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ViewModel/get_latest_mover_view_model.dart';

class LatestMoversBulkUploadScreen extends StatefulWidget {
  const LatestMoversBulkUploadScreen({Key? key}) : super(key: key);

  @override
  State<LatestMoversBulkUploadScreen> createState() =>
      _LatestMoversBulkUploadScreenState();
}

class _LatestMoversBulkUploadScreenState
    extends State<LatestMoversBulkUploadScreen> {
  List titles = [];
  List percentages = [];
  List startDate = [];
  List endDate = [];
  List description = [];

  AddCompanyViewModel addCompanyViewModel = Get.put(AddCompanyViewModel());
  DashBoardController dashBoardController = Get.put(DashBoardController());

  GetLatestMoverViewModel getLatestMoverViewModel =
      Get.put(GetLatestMoverViewModel());

  @override
  void initState() {
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
                      'Draft Content',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      width: 20,
                    ),
                    titles.isNotEmpty
                        ? SizedBox(
                            height: 40,
                            width: 83,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.mainColor,
                              ),
                              onPressed: () async {
                                if (titles.isNotEmpty &&
                                    percentages.isNotEmpty &&
                                    startDate.isNotEmpty &&
                                    endDate.isNotEmpty &&
                                    description.isNotEmpty) {
                                  try {
                                    for (int i = 0; i <= titles.length; i++) {
                                      await getLatestMoverViewModel
                                          .addLatestMoversViewModel(body: {
                                        "title": titles[i].toString(),
                                        "description":
                                            description[i].toString(),
                                        "percentage": percentages[i].toString(),
                                        "startDate": '${startDate[i]}',
                                        "endDate": '${endDate[i]}',
                                      });
                                    }
                                  } catch (e) {
                                    // TODO
                                  } finally {
                                    dashBoardController.currentScreen.value =
                                        DashBoardPanelScreens.latestMover;
                                  }
                                }
                              },
                              child: Text(
                                'Upload',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        /// Use FilePicker to pick files in Flutter Web

                        FilePickerResult? pickedFile =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['xlsx'],
                          allowMultiple: false,
                        );

                        /// file might be picked

                        if (pickedFile != null) {
                          var bytes = pickedFile.files.single.bytes;
                          var excel = Excel.decodeBytes(bytes!);
                          for (var table in excel.tables.keys) {
                            for (var row in excel.tables[table]!.rows) {
                              print("====>>${row}");

                              titles.add(row.first!.value);
                              percentages.add(row[1]!.value);
                              startDate.add(row[2]!.value);
                              endDate.add(row[3]!.value);
                              description.add(row[4]!.value);
                            }

                            setState(() {});
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(width: 2)),
                        child: Center(
                          child: Text('Import Sheet'),
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
                    Expanded(
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
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.center,
                        child: Text(
                          'Percentage',
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
                          'Start Date',
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
                          'End Date',
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
                      ),
                    ),
                    SizedBox(
                      width: 30,
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
                  titles.isEmpty
                      ? Center(
                          child: Text(
                            'Bulk upload your existing content',
                            textScaleFactor: 1.5,
                          ),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: titles.length,
                          shrinkWrap: true,
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
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${titles[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${description[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${percentages[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${startDate[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${endDate[index]}',
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
                                          titles.removeAt(index);
                                          description.removeAt(index);
                                          startDate.removeAt(index);
                                          endDate.removeAt(index);
                                          percentages.removeAt(index);
                                          setState(() {});
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
                                        width: 30,
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
