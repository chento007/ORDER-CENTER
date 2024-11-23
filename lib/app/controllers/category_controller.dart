import 'package:coffee_app/app/models/category.dart';
import 'package:coffee_app/app/services/category_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var isLoading = false.obs;
  var categories = <Category>[].obs;

  final CategoryService apiService = CategoryService();

  // Define the default category
  final Category defaultCategory = Category(
    id: -1, // Use a unique negative ID to avoid conflicts with database IDs
    uuid: 'default-popular-uuid',
    createdAt: DateTime.now().toIso8601String(),
    updatedAt: DateTime.now().toIso8601String(),
    deletedAt: null,
    status: true, // Set the default status
    name: "Popular",
    description: "This is a default category for popular items",
  );

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      List<Category> fetchedUsers = await apiService.fetchCategories();
      categories.add(defaultCategory);
      categories.addAll(fetchedUsers);
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }
}
