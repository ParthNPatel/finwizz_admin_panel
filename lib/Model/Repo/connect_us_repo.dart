import 'package:finwizz_admin/Model/Response_model/connect_us_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';

class ConnectUsRepo {
  Future<ConnectUsResponseModel> connectUsRepo(
      {int? limit = 10, int page = 1}) async {
    var response = await APIService().getResponse(
      url: 'http://52.66.209.219:4000/contact?limit=$limit&page=$page',
      apitype: APIType.aGet,
    );
    ConnectUsResponseModel connectUsResponseModel =
        ConnectUsResponseModel.fromJson(response);
    print('ConnectUsResponseModel $response');
    return connectUsResponseModel;
  }
}
