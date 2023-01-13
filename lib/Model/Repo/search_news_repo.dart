import 'dart:convert';

import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:http/http.dart' as http;

class GetSearchNewsRepo {
  Future<dynamic> getSearchNewsRepo(
      {String? categoriesId = '', String? search = ''}) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM'
    };
    var response = await http.get(
        Uri.parse(
            'http://52.66.209.219:4000/news/search?companyId=$categoriesId&text=$search'),
        headers: headers);

    if (response.statusCode == 200) {
      print(await jsonDecode(response.body));
      var data = await jsonDecode(response.body);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }
}
