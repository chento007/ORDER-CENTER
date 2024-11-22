import 'package:coffee_app/app/models/product.dart';
import 'package:coffee_app/app/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var isProductByCategoryLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var products = <Product>[].obs;
  var productsCategory = <Product>[].obs;

  final ProductService apiService = ProductService();

  @override
  void onInit() {
    super.onInit();

  }

  Future<void> fetchProduct() async {
    try {
      isLoading(true);
      List<Product> fetchProducts = await apiService.fetchProducts();
      products.assignAll(fetchProducts);
    } catch (e) {
      print('Error while getting all product data: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProductsByCategory(int categoryId) async {
    try {


      isProductByCategoryLoading.value = true;
      // Fetch the data from the API
      List<Product> fetchProducts = await apiService.fetchProductsByCategory(categoryId);

      // Check if the fetched data is empty
      if (fetchProducts.isEmpty) {
        print('No products found for this category.');
      }

      // Update the observable list with the fetched products
      products.assignAll(fetchProducts);
      return;
    } catch (e) {
      // If an error occurs, update the error state
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      // Stop the loading indicator regardless of success or failure
      isProductByCategoryLoading.value = false;
    }
  }


}
