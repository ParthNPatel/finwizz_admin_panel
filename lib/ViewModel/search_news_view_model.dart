import 'dart:convert';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchNewsController extends GetxController {
  dynamic searchata;
  Future<dynamic> apiCalling({String text = '', String companyId = ''}) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM'
    };
    var response = await http.get(
        Uri.parse(
            'http://52.66.209.219:4000/news/search?companyId=$companyId&text=$text'),
        headers: headers);

    if (response.statusCode == 200) {
      print('RESPONSE :- ${await jsonDecode(response.body)}');
      var data = jsonDecode(response.body);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }

  dynamic searchNewsData;
  ApiResponse _getSearchNewsApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getSearchNewsApiResponse => _getSearchNewsApiResponse;

  Future<void> getSearchNewsViewModel(
      {bool isLoading = true,
      String? text = '',
      String? companyId = ''}) async {
    if (isLoading) {
      _getSearchNewsApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      searchNewsData = await apiCalling(text: text!, companyId: companyId!);
      // print("searchNewsData=response==>$searchNewsData");

      _getSearchNewsApiResponse = ApiResponse.complete(searchNewsData);
    } catch (e) {
      print("searchNewsData=e==>$e");
      _getSearchNewsApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
