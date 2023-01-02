import 'dart:convert';

import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditNewsRepo {
  editNewsRepo({String text = "", Map<String, dynamic>? body}) async {
    var header = {'Content-Type': 'application/json'};

    var response = await http.patch(
        Uri.parse('http://3.109.139.48:4000/news/$text'),
        body: jsonEncode(body),
        headers: header);

    if (response.statusCode == 200) {
      Get.back();
      snackBarGet('News Update Successfully',
          snackBarBackGroundColor: AppColor.greenColor);
    } else {
      print(response.reasonPhrase);
      Get.back();

      snackBarGet('Something went wrong',
          snackBarBackGroundColor: AppColor.redColor);
    }
  }
}
