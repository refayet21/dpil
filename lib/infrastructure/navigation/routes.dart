class Routes {
  static Future<String> get initialRoute async {
    return SPLASH;
  }

  static const ADMIN_ADDDOUSER = '/admin-adddouser';
  static const ADMIN_ADDGENUSER = '/admin-addgenuser';
  static const ADMIN_ADDPRODUCT = '/admin-addproduct';
  static const ADMIN_ADDVENDOR = '/admin-addvendor';
  static const ADMIN_DASHBOARD = '/admin-dashboard';
  static const DOUSER_ATTENDENCE = '/douser-attendence';
  static const DOUSER_DASHBOARD = '/douser-dashboard';
  static const DOUSER_INVOICE = '/douser-invoice';
  static const DOUSER_INVOICEPREVIEW = '/douser-invoicepreview';
  static const GENUSER_DASHBOARD = '/genuser-dashboard';
  static const LOGIN = '/login';
  static const SPLASH = '/splash';
  static const DOUSER_PRODUCTCART = '/douser-productcart';
}
