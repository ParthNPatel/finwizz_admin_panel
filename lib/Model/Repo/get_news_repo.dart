import 'dart:convert';

import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:http/http.dart' as http;

class GetNewsRepo {
  Future<dynamic> getNewsRepo({String? id}) async {
    var response = await http.get(Uri.parse('${ApiUrl.getNews}$id'));

    if (response.statusCode == 200) {
      print(await jsonDecode(response.body));
      var data = await jsonDecode(response.body);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }
}
