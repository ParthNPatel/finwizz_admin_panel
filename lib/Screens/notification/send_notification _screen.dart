import 'dart:developer';

import 'package:finwizz_admin/ViewModel/notification_view_model.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendNotificationScreen extends StatelessWidget {
  SendNotificationScreen({Key? key}) : super(key: key);
  NotificationViewModel notificationViewModel =
      Get.put(NotificationViewModel());
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));
  TextEditingController notification = TextEditingController();
  TextEditingController search = TextEditingController();
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
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 150,
                  width: 380,
                  child: TextField(
                    controller: notification,
                    maxLines: 5,
                    onChanged: (val) {},
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
                      hintText: 'Write your message here...',
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 380,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.mainColor),
                        onPressed: () {
                          notification.clear();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.mainColor),
                        onPressed: () {
                          notificationViewModel.getItems();
                          snackBarGet('Notification Send',
                              snackBarBackGroundColor: AppColor.mainColor);
                        },
                        child: Text('Send'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              GetBuilder<NotificationViewModel>(
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 15),
                        child: Row(
                          children: [
                            Container(
                              // padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: controller.selectAll,
                                    onChanged: (value) {
                                      controller.updateSelectAll();
                                    },
                                  ),
                                  Text('Select All'),
                                  SizedBox(
                                    width: 5,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 300,
                              child: TextField(
                                controller: search,
                                onChanged: (value) {
                                  controller.updateSearch(value);
                                },
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
                                  hintText: 'Search here...',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: AppColor.mainColor,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 25,
                            ),
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
                                  'Email',
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
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: controller.name[index]['name']
                                        .toString()
                                        .toLowerCase()
                                        .contains(controller.searchText
                                            .toLowerCase()) ||
                                    controller.searchText == ''
                                ? 20
                                : 0,
                          );
                        },
                        itemCount: controller.name.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return controller.name[index]['name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(controller.searchText
                                          .toLowerCase()) ||
                                  controller.searchText == ''
                              ? Container(
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
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Checkbox(
                                            value: controller.name[index]
                                                ['value'],
                                            onChanged: (value) {
                                              controller.updateValue(
                                                  value, index);
                                            },
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Container(
                                              // padding: const EdgeInsets.only(left: 20),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${controller.name[index]['name']}',
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
                                                'hello$index@gmail.com',
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
                                )
                              : SizedBox();
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckboxWidget extends StatefulWidget {
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

class CheckboxWidgetState extends State {
  Map<String, bool> numbers = {
    'One': false,
    'Two': false,
    'Three': false,
    'Four': false,
    'Five': false,
    'Six': false,
    'Seven': false,
  };

  var holder_1 = [];

  getItems() {
    numbers.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        ElevatedButton(
          child: Text(
            " Get Checked Checkbox Items ",
            style: TextStyle(fontSize: 20),
          ),
          onPressed: getItems,
        ),
        Expanded(
          child: ListView(
            children: numbers.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(key),
                value: numbers[key],
                activeColor: Colors.pink,
                checkColor: Colors.white,
                onChanged: (bool? value) {
                  setState(() {
                    numbers[key] = value!;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}
