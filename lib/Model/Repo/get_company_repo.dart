import 'dart:developer';

import 'package:finwizz_admin/Model/Response_model/get_company_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class GetCompanyRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjNiZDZkZWIyYzBjZmJkYmQxMWIzMmQ2.XxjWyJcaxqZv0VT9dYV6acZtTeipfJc0abwkkUYgVhM'
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
