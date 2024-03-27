class Routes {
  static Future<String> get initialRoute async {
    return SPLASH;
  }

  static const ADMIN_ADDDOUSER = '/admin-adddouser';
  static const ADMIN_ADDGENUSER = '/admin-addgenuser';
  static const ADMIN_ADDPRODUCT = '/admin-addproduct';
  static const ADMIN_ADDVENDOR = '/admin-addvendor';
  static const ADMIN_ATTENDANCE = '/admin-attendance';
  static const ADMIN_DASHBOARD = '/admin-dashboard';
  static const ADMIN_DO = '/admin-do';
  static const ADMIN_EMAIL = '/admin-email';
  static const ADMIN_PREVIEWATTENDANCE = '/admin-previewattendance';
  static const DOUSER_ADDCUSTOMER = '/douser-addcustomer';
  static const DOUSER_ATTENDENCE = '/douser-attendence';
  static const DOUSER_DASHBOARD = '/douser-dashboard';
  static const DOUSER_INVOICE = '/douser-invoice';
  static const DOUSER_INVOICEPREVIEW = '/douser-invoicepreview';
  static const DOUSER_PRODUCTCART = '/douser-productcart';
  static const GENUSER_DASHBOARD = '/genuser-dashboard';
  static const LOGIN = '/login';
  static const SPLASH = '/splash';
  static const ADMIN_PREVIEWDO = '/admin-previewdo';
}
