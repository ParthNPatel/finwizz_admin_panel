import 'package:finwizz_admin/Model/Response_model/add_company_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class AddCompanyRepo {
  var headers = {'Content-Type': 'application/json'};
  Future<AddCompanyResponseModel> addCompanyRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: ApiUrl.addCompany,
        body: body,
        apitype: APIType.aPost,
        header: headers);
    print('AddCompanyResponseModel $response');
    AddCompanyResponseModel addCompanyResponseModel =
        AddCompanyResponseModel.fromJson(response);
    print('AddCompanyResponseModel $response');
    return addCompanyResponseModel;
  }
}
