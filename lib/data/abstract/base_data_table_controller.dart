import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';

import '../../features/controllers/loders.dart';
import '../../utils/constants/sizes.dart';

abstract class TBaseController<T> extends GetxController {
  RxBool isLoading = false.obs;
  RxInt sortColumnIndex = 1.obs;
  RxBool sortAscending = true.obs;
  RxList<T> allItems = <T>[].obs;
  RxList<T> filteredItems = <T>[].obs;
  RxList<bool> selectedRows = <bool>[].obs;
  final searchTextController = TextEditingController();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }


  Future<List<T>> fetchItems();
  Future<void> deleteItem(T item);
  bool containsSearchQuery(T item, String query);

  


  Future<void> fetchData() async {
    try {
      isLoading.value = true;
      List<T> fetchedItems = [];
      if (allItems.isEmpty) {
        fetchedItems = await fetchItems();
      }
      allItems.assignAll(fetchedItems);
      filteredItems.assignAll(allItems);
      selectedRows.assignAll(List.generate(allItems.length, (index) => false));
    } catch (e) {
      isLoading.value = false;
      TFullScreenLoader.stopLoading();
      TLodaers.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  void searchQuery(String query) {
    filteredItems.assignAll(
      allItems.where(
          (item) => containsSearchQuery(item, query)),
    );
  }

  void sortByParenty(int sortColumnIndex, bool ascending , Function(T) property) {
    sortAscending.value = ascending;
    this.sortColumnIndex.value = sortColumnIndex;
    filteredItems.sort((a, b) {
      if (ascending) {
        return property(a).compareTo(property(b));
      } else {
        return property(a).compareTo(property(a));
      }
    });
  }

  

  void addItemToLists(T item) {
    allItems.add(item);
    filteredItems.add(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

  void updateItemFromList(T item) {
    final itemIndex = allItems.indexWhere((i) => i == item);
    final filteredItemIndex = filteredItems.indexWhere((i) => i == item);

    if (itemIndex != -1) allItems[itemIndex] = item;
    if (filteredItemIndex != -1) filteredItems[itemIndex] = item;
  }

  void removeItemFromLists(T item) {
    allItems.remove(item);
    filteredItems.remove(item);
    selectedRows.assignAll(List.generate(allItems.length, (index) => false));
  }

   Future <void> confirmAndDeleteItem(T item ) async {
    // Show a confirmation dialog
    Get.defaultDialog(
      title: 'Delete Item',
      content: const Text('Are you sure you want to delete this item?'),
      confirm: SizedBox(
        width: 60,
        child: ElevatedButton(
          onPressed: () async =>
            await deleteOnConfirm(item),
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
            ),
          ),
          child: const Text('Ok'),
        ),
      ),
      cancel: SizedBox(
        width: 80,
        child: OutlinedButton(
          onPressed: () => Get.back(),
          style: OutlinedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: TSizes.buttonHeight / 2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(TSizes.buttonRadius * 5),
            ),
          ),
          child: const Text('Cancel'),
        ),
      ),
    );
  }

  Future<void> deleteOnConfirm(T item) async {
  try {
    TFullScreenLoader.stopLoading();
    TFullScreenLoader.popUpLoader();
    await deleteItem(item);

    removeItemFromLists(item);
    TFullScreenLoader.stopLoading();
    TLodaers.errorSnackBar(title: 'Item deleted', message: 'your item has been deleted');
  } catch (e) {
    TFullScreenLoader.stopLoading();
    TLodaers.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  }
}
}

