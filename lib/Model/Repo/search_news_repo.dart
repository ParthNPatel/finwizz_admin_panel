import 'dart:convert';

import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:http/http.dart' as http;

class GetSearchNewsRepo {
  Future<dynamic> getSearchNewsRepo(
      {String? categoriesId = '', String? search = ''}) async {
    var response = await http.get(Uri.parse('${ApiUrl.getSearchNews}$search'));

    if (response.statusCode == 200) {
      print(await jsonDecode(response.body));
      var data = await jsonDecode(response.body);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }
}
