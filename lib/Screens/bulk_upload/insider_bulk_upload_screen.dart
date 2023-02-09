import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/dashboard_panel_tabs.dart';
import 'package:finwizz_admin/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ViewModel/add_movers_view_model.dart';
import '../../ViewModel/get_latest_mover_view_model.dart';
import '../../ViewModel/insider_view_model.dart';

class InsiderBulkUploadScreen extends StatefulWidget {
  const InsiderBulkUploadScreen({Key? key}) : super(key: key);

  @override
  State<InsiderBulkUploadScreen> createState() =>
      _InsiderBulkUploadScreenState();
}

class _InsiderBulkUploadScreenState extends State<InsiderBulkUploadScreen> {
  List companies = [];
  List companiesId = [];
  List sharedSold = [];
  List sharesSoldPerson = [];
  List sharedBought = [];
  List sharesBoughtPerson = [];
  List personCategories = [];
  List shares = [];
  List shareValue = [];
  List transactionType = [];
  List transactionMode = [];

  DashBoardController dashBoardController = Get.put(DashBoardController());
  InsiderViewModel insiderViewModel = Get.put(InsiderViewModel());

  GetLatestMoverViewModel getLatestMoverViewModel =
      Get.put(GetLatestMoverViewModel());
  AddMoversViewModel addMoversViewModel = Get.put(AddMoversViewModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("DATe==>>${DateTime.now()}");
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
                    companies.isNotEmpty
                        ? SizedBox(
                            height: 40,
                            width: 83,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.mainColor,
                              ),
                              onPressed: () async {
                                if (companies.isNotEmpty &&
                                    sharedSold.isNotEmpty &&
                                    sharesSoldPerson.isNotEmpty &&
                                    sharedBought.isNotEmpty &&
                                    sharesBoughtPerson.isNotEmpty &&
                                    transactionType.isNotEmpty &&
                                    transactionMode.isNotEmpty &&
                                    shares.isNotEmpty &&
                                    shareValue.isNotEmpty) {
                                  try {
                                    for (int i = 0;
                                        i <= companies.length;
                                        i++) {
                                      await insiderViewModel
                                          .addInsiderViewModel(model: {
                                        "companyId": "${companiesId[i]}",
                                        "sharesSold": {
                                          "shares": int.parse(
                                              sharedSold[i].toString()),
                                          "person": int.parse(
                                              sharesSoldPerson[i].toString()),
                                        },
                                        "sharesBought": {
                                          "shares": int.parse(
                                              sharedBought[i].toString()),
                                          "person": int.parse(
                                              sharesBoughtPerson[i].toString()),
                                        },
                                        "table": {
                                          "personCategory":
                                              "${personCategories[i]}",
                                          "shares":
                                              int.parse(shares[i].toString()),
                                          "value": int.parse(
                                              shareValue[i].toString()),
                                          "transactionType":
                                              "${transactionType[i]}",
                                          "mode": "${transactionMode[i]}"
                                        }
                                      });
                                    }
                                  } catch (e) {
                                    // TODO
                                  } finally {
                                    dashBoardController.currentScreen.value =
                                        DashBoardPanelScreens.insider;
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

                              companiesId.add(row.first!.value);
                              companies.add(row[1]!.value);
                              sharedSold.add(row[2]!.value);
                              sharesSoldPerson.add(row[3]!.value);
                              sharedBought.add(row[4]!.value);
                              sharesBoughtPerson.add(row[5]!.value);
                              personCategories.add(row[6]!.value);
                              shares.add(row[7]!.value);
                              shareValue.add(row[8]!.value);
                              transactionType.add(row[9]!.value);
                              transactionMode.add(row[10]!.value);
                            }
                            setState(() {});
                          }

                          companiesId.removeAt(0);
                          companies.removeAt(0);
                          sharedSold.removeAt(0);
                          sharesSoldPerson.removeAt(0);
                          sharedBought.removeAt(0);
                          sharesBoughtPerson.removeAt(0);
                          personCategories.removeAt(0);
                          shares.removeAt(0);
                          shareValue.removeAt(0);
                          transactionType.removeAt(0);
                          transactionMode.removeAt(0);
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
                          'Company',
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
                          'Shares Sold',
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
                          'Shares Sold Person',
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
                          'Shares Bought',
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
                          'Shares Bought Person',
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
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.center,
                        child: Text(
                          'Person Category',
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
                    Expanded(
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
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.center,
                        child: Text(
                          'Shares Value',
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
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.center,
                        child: Text(
                          'Transaction Type',
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
                    Expanded(
                      child: Container(
                        // padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.center,
                        child: Text(
                          'Transaction Mode',
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
                  companies.isEmpty
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
                          itemCount: companies.length,
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
                                            '${companies[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${sharedSold[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${sharesSoldPerson[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${sharedBought[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${sharesBoughtPerson[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${personCategories[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${shares[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${shareValue[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${transactionType[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${transactionMode[index]}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          companies.removeAt(index);
                                          sharedSold.removeAt(index);
                                          sharesSoldPerson.removeAt(index);
                                          sharedBought.removeAt(index);
                                          sharesBoughtPerson.removeAt(index);
                                          shares.removeAt(index);
                                          shareValue.removeAt(index);
                                          transactionMode.removeAt(index);
                                          transactionType.removeAt(index);
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
