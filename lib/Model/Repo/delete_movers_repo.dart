import 'dart:convert';

import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteMoversRepo {
  deleteMoversRepo({String text = ""}) async {
    var response =
        await http.delete(Uri.parse('http://52.66.209.219:4000/movers/$text'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      Get.back();
      snackBarGet('Mover Deleted Successfully',
          snackBarBackGroundColor: AppColor.greenColor);
    } else {
      print(response.reasonPhrase);
      Get.back();

      snackBarGet('Something went wrong',
          snackBarBackGroundColor: AppColor.redColor);
    }
  }
}
