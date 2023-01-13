import 'dart:convert';

import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:finwizz_admin/Widgets/app_color.dart';
import 'package:finwizz_admin/Widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetLatestMoversRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM'
  };
  Future<dynamic> getLatestMoversRepo() async {
    var response =
        await http.get(Uri.parse(ApiUrl.getLatestMover), headers: headers);

    if (response.statusCode == 200) {
      print('Success :${await jsonDecode(response.body)}');
      var data = await jsonDecode(response.body);
      return data;
    } else {
      print('ERROR ${response.reasonPhrase}');
    }
  }

  /// ADD LATEST MOVERS
  var header = {'Content-Type': 'application/json'};
  Future<dynamic> addLatestMoversRepo({Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: ApiUrl.addLatestMover,
        body: body,
        apitype: APIType.aPost,
        header: header);

    return response;
  }

  /// EDIT LATEST MOVERS
  editLatestMoversRepo({String text = "", Map<String, dynamic>? body}) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM',
      'Content-Type': 'application/json'
    };

    var response = await http.patch(
        Uri.parse('http://52.66.209.219:4000/movers/latest/$text'),
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

  /// DELETE LATEST MOVERS
  deleteLatestMoversRepo({String text = ""}) async {
    var response = await http
        .delete(Uri.parse('http://52.66.209.219:4000/movers/latest/$text'));

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
