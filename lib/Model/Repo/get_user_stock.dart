import 'dart:convert';

import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:http/http.dart' as http;

class GetStockUserRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM'
  };
  Future<dynamic> getStockUserRepo() async {
    var response =
        await http.get(Uri.parse(ApiUrl.stockUsers), headers: headers);
    if (response.statusCode == 200) {
      print(await jsonDecode(response.body));
      var data = await jsonDecode(response.body);
      return data;
    } else {
      print(response.reasonPhrase);
    }
  }
}
