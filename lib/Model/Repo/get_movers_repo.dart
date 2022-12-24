import 'dart:convert';

import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:http/http.dart' as http;

class GetMoversRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjM5NTc2ODVlYmQ2YzgzNzUwOWUwYmRj.1iadelf8X5NZXjvmoOOCIzDHtnaPkv5Hm0-dPWQ5cLE'
  };
  Future<dynamic> getMoversRepo() async {
    var response =
        await http.get(Uri.parse(ApiUrl.getMovers), headers: headers);

    if (response.statusCode == 200) {
      print('Success :${await jsonDecode(response.body)}');
      var data = await jsonDecode(response.body);
      return data;
    } else {
      print('ERROR ${response.reasonPhrase}');
    }
  }
}
