import 'package:yt_ecommerce_admin_panel/data/models/banner_model.dart';

import '../../../../data/abstract/base_data_table_controller.dart';
import 'package:get/get.dart';

import '../../../data/repositorise/banners_repository.dart';

class BannerController extends TBaseController<BannerModel> {
  static BannerController get instance => Get.find();

  final  _bannerRepository = Get.put(BannerRepository());

  @override
  Future<void> deleteItem(BannerModel item) async {
    await _bannerRepository.deleteBanner(item.id ?? '');
  }
  

  @override
  Future<List<BannerModel>> fetchItems() async {
  return await _bannerRepository.getAllBanners();
  }

  // Method for formatting a route string
  String formatRoute(String route) {
    if (route.isEmpty) return '';
    
    // Remove leading '/' if exists
    String formatted = route.substring(1);

    // Capitalize first letter if not empty
      formatted = formatted[0].toUpperCase() + formatted.substring(1);
    
    return formatted;
  }

  @override
  bool containsSearchQuery(BannerModel item, String query) {
    return false;
  }
}