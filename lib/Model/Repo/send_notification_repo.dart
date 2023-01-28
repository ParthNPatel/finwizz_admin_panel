import 'package:finwizz_admin/Model/Response_model/add_movers_res_model.dart';
import 'package:finwizz_admin/Model/Services/api_service.dart';
import 'package:finwizz_admin/Model/Services/base_service.dart';

class SendNotificationRepo {
  var headers = {'Content-Type': 'application/json'};
  Future<dynamic> sendNotificationRepo({Map<String, dynamic>? body}) async {
    var response = await APIService().getResponse(
        url: ApiUrl.sendNotification,
        body: body,
        apitype: APIType.aPost,
        header: headers);
    print('SendNotificationRepo $response');
    dynamic data = response;
    print('SendNotificationRepo $response');
    return data;
  }
}
