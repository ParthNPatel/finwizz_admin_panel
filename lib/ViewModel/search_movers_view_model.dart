import 'dart:convert';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchMoversController extends GetxController {
  dynamic searchata;

  Future<dynamic> apiCalling({String text = ''}) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM'
    };
    var response = await http.get(
        Uri.parse('http://52.66.209.219:4000//movers/search?&text=$text'),
        headers: headers);

    if (response.statusCode == 200) {
      print('RESPONSE :- ${await jsonDecode(response.body)}');
      var data = jsonDecode(response.body);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }

  dynamic searchMoversData;

  ApiResponse _getSearchNewsApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getSearchNewsApiResponse => _getSearchNewsApiResponse;

  Future<void> getMoversViewModel({
    bool isLoading = true,
    String? text = '',
  }) async {
    if (isLoading) {
      _getSearchNewsApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      searchMoversData = await apiCalling(text: text!);
      // print("searchNewsData=response==>$searchNewsData");

      _getSearchNewsApiResponse = ApiResponse.complete(searchMoversData);
    } catch (e) {
      print("searchNewsData=e==>$e");
      _getSearchNewsApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
