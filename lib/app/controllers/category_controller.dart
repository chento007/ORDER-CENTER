import 'package:coffee_app/app/models/category.dart';
import 'package:coffee_app/app/models/user.dart';
import 'package:coffee_app/app/services/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <Category>[].obs;

  final CategoryService apiService = CategoryService();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      List<Category> fetchedUsers = await apiService.fetchCategories();
      categories.addAll(fetchedUsers);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
