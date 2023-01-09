import 'dart:convert';

import 'package:finwizz_admin/Model/Response_model/add_insider_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';
import 'package:http/http.dart' as http;

class InsiderRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiMDI2Y2NiNDQ0OTdlMDliODNjZWVh.WWMYdR8wZdejv6bT7lEd8bAqMuNfcXRGXffQWLgIzpA'
  };

  var addHeader = {'Content-Type': 'application/json'};
  Future<AddInsiderResponseModel> addInsiderRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: ApiUrl.addInsider,
        body: body,
        apitype: APIType.aPost,
        header: addHeader);
    AddInsiderResponseModel addInsiderResponseModel =
        AddInsiderResponseModel.fromJson(response);
    print('AddInsiderResponseModel $response');
    return addInsiderResponseModel;
  }

  Future<dynamic> getInsiderRepo() async {
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
