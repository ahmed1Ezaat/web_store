class TRoutes {
  static const login = '/Login';
  static const forgetPassword = '/forget-Password/';
  static const restPassword = '/rest-Password';
  static const dashboard = '/dashboard';
  static const media = '/media';


  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';

  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';

  static List sidebarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
  ];
}
