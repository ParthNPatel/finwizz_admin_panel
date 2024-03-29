import 'dart:convert';

import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditMoverRepo {
  editMoversRepo({String text = "", Map<String, dynamic>? body}) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM',
      'Content-Type': 'application/json'
    };

    var response = await http.patch(
        Uri.parse('http://52.66.209.219:4000/movers/$text'),
        body: jsonEncode(body),
        headers: headers);
    print(' Status Code :- ${response.statusCode}');

    if (response.statusCode == 200) {
      print(' Status Code :- ${response.statusCode}');
      print(' Successfully Response :- ${jsonDecode(response.body)}');
      Get.back();
      snackBarGet('Mover Update Successfully',
          snackBarBackGroundColor: AppColor.greenColor);
    } else {
      print(response.reasonPhrase);
      Get.back();

      snackBarGet('Something went wrong',
          snackBarBackGroundColor: AppColor.redColor);
    }
  }
}
