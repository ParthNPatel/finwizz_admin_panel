import 'dart:developer';

import 'package:finwizz_admin/Model/Apis/api_response.dart';
import 'package:finwizz_admin/Model/Repo/add_movers_repo.dart';
import 'package:finwizz_admin/Model/Repo/send_notification_repo.dart';
import 'package:finwizz_admin/Model/Response_model/add_movers_res_model.dart';
import 'package:get/get.dart';

class SendNotificationViewModel extends GetxController {
  bool loader = false;

  updateLoader(val) {
    loader = val;
    update();
  }

  ApiResponse _sendNotificationApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get sendNotificationApiResponse => _sendNotificationApiResponse;
  dynamic notificationSend;
  Future<void> sendNotificationViewModel(
      {bool isLoading = true, Map<String, dynamic>? model}) async {
    updateLoader(true);
    if (isLoading) {
      _sendNotificationApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      notificationSend =
          await SendNotificationRepo().sendNotificationRepo(body: model);
      log("notificationSend=response==>$notificationSend");

      _sendNotificationApiResponse = ApiResponse.complete(notificationSend);
      updateLoader(false);
    } catch (e) {
      log("notificationSend=e==>$e");
      updateLoader(false);
      _sendNotificationApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
