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

  
            static const banners = '/banners';
            static const createBanner = '/createBanner';
            static const editBanner = '/editBanner';

            static const products = '/products';
            static const createProduct = '/createProduct';
            static const editProduct = '/editProduct';

            static const customers = '/customers';
            static const createCustomer = '/createCustomer';
            static const customerDetails = '/customerDetails';

            static const orders = '/orders';
            static const orderDetails = '/orderDetails';

            static const coupons = '/coupons';
            static const settings = '/settings';
            static const profile = '/profile';
        

  static List sidebarMenuItems = [
    dashboard,
    media,
    categories,
    brands,
    banners,
    products,
    customers,
    orders,
    
  ];
}
