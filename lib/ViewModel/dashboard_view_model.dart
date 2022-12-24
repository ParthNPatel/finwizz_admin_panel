import 'package:finwizz_admin/ViewModel/connect_us_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_company_view_model.dart';
import 'package:finwizz_admin/ViewModel/get_news_view_model.dart';
import 'package:get/get.dart';

class DashboardViewModel extends GetxController {
  GetCompanyViewModel getCompanyViewModel = Get.put(GetCompanyViewModel());
  GetNewsViewModel getNewsViewModel = Get.put(GetNewsViewModel());
  ConnectUsViewModel connectUsViewModel = Get.put(ConnectUsViewModel());
  int newsTotal = 0;
  int connectUsTotal = 0;
  int companyTotal = 0;

  bool loading = false;

  updateLoading(bool val) {
    loading = val;
    update();
  }

  @override
  void onInit() {
    fetchDashboardData();
    super.onInit();
  }

  fetchDashboardData() async {
    updateLoading(false);
    await getCompanyViewModel.getCompanyViewModel();
    await connectUsViewModel.connectUsViewModel(limit: 10, page: 1);
    await getNewsViewModel.getNewsViewModel(id: '');
    Future.delayed(const Duration(seconds: 1), () {
      companyTotal = getCompanyViewModel.totalData;
      connectUsTotal = connectUsViewModel.totalData;
      newsTotal = getNewsViewModel.totalData;
      updateLoading(true);
    });
  }
}
