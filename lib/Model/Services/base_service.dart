class ApiUrl {
  static String addCompany = 'http://52.66.209.219:4000/company';
  static String getCompany = 'http://52.66.209.219:4000/stocks/search';
  static String deleteCompany = 'http://52.66.209.219:4000/company/';
  static String addNewsCategories = 'http://52.66.209.219:4000/news/category';
  static String getNewsCategories = 'http://52.66.209.219:4000/news/category';
  static String addMovers = 'http://52.66.209.219:4000/movers';
  static String addInsider = 'http://52.66.209.219:4000/insider';
  static String getInsider = 'http://52.66.209.219:4000/insider';
  static String getNews = 'http://52.66.209.219:4000/news?categoryId=';
  static String getSearchNews =
      'http://52.66.209.219:4000/news/search?companyId=&text=';
  static String getMovers = 'http://52.66.209.219:4000/movers/search?&text=';
  static String addNews = 'http://52.66.209.219:4000/news';
  static String getLatestMover = 'http://52.66.209.219:4000/movers/latest';
  static String addLatestMover = 'http://52.66.209.219:4000/movers/latest';
  static String stockUsers = 'http://52.66.209.219:4000/stocks/users';
  static String sendNotification =
      'http://52.66.209.219:4000/notification/broadcast';
}
