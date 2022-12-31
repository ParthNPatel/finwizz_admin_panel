import 'dart:convert';

import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:http/http.dart' as http;

class GetMoversRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiMDI2Y2NiNDQ0OTdlMDliODNjZWVh.WWMYdR8wZdejv6bT7lEd8bAqMuNfcXRGXffQWLgIzpA'
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
