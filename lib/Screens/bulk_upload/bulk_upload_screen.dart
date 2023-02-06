import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BulkUploadScreen extends StatefulWidget {
  const BulkUploadScreen({Key? key}) : super(key: key);

  @override
  State<BulkUploadScreen> createState() => _BulkUploadScreenState();
}

class _BulkUploadScreenState extends State<BulkUploadScreen> {
  List selectedCompanies = [];
  List selectedStockTicker = [];

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
                          selectedCompanies.isNotEmpty
                              ? GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    height: 40,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(width: 2)),
                                    child: Center(
                                      child: Text('Upload'),
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
                                    selectedCompanies.add(row.first!.value);
                                    selectedStockTicker.add(row.last!.value);
                                  }

                                  setState(() {});

                                  print('COMPONIES===>>11${selectedCompanies}');
                                  print(
                                      'COMPONIES===>>22${selectedStockTicker}');
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
                                child: Text('Upload Content'),
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
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        selectedCompanies.isEmpty
                            ? Center(
                                child:
                                    Text('Bulk upload your existing content'),
                              )
                            : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount: selectedStockTicker.length,
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
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                // padding: const EdgeInsets.only(left: 20),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  '${selectedCompanies[index]}',
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
                                                  '${selectedStockTicker[index]}',
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
                                                selectedStockTicker
                                                    .removeAt(index);
                                                selectedCompanies
                                                    .removeAt(index);
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
}
