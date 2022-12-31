import 'dart:developer';

import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class GetCompanyRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiMDI2Y2NiNDQ0OTdlMDliODNjZWVh.WWMYdR8wZdejv6bT7lEd8bAqMuNfcXRGXffQWLgIzpA'
  };
  Future<GetCompanyResponseModel> getCompanyRepo({String? text = ""}) async {
    log("URL :- ${ApiUrl.getCompany}");
    var response = await APIService().getResponse(
        url: ApiUrl.getCompany, apitype: APIType.aGet, header: headers);
    GetCompanyResponseModel getCompanyResponseModel =
        GetCompanyResponseModel.fromJson(response);
    print('GetCompanyResponseModel $response');
    return getCompanyResponseModel;
  }
}
