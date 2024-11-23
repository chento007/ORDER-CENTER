import 'package:coffee_app/app/models/product.dart';
import 'package:coffee_app/app/services/product_service.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  var isProductByCategoryLoading = false.obs;
  var createdLoading = false.obs;
  var hasError = false.obs;
  var errorMessage = ''.obs;
  var searchText = ''.obs;
  // Observable lists for products
  var products = <Product>[].obs;
  var productDashboard = <Product>[].obs;

  // Pagination variables
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var pageSize = 10; // Number of items per page

  // The service instance for API calls
  final ProductService apiService = ProductService();

  @override
  void onInit() {
    super.onInit();
    fetchProduct();
  }

  Future<void> fetchProduct() async {
    try {
      createdLoading(true);

      // Fetch products with pagination
      List<Product> fetchedProducts = await apiService.fetchProducts(
          currentPage.value, pageSize, searchText.value);

      // If no products were fetched, set totalPages to 0 and disable next page button
      if (fetchedProducts.length < pageSize) {
        totalPages.value = 0;
      } else {
        totalPages.value = 10;
      }

      productDashboard.assignAll(fetchedProducts);

      // Ensuring UI is updated after fetching products
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      createdLoading(false);
    }
  }

  // Fetch products by category
  Future<void> fetchProductsByCategory(int categoryId) async {
    try {
      createdLoading(true);
      List<Product> fetchedProducts =
          await apiService.fetchProductsByCategory(categoryId);

      if (fetchedProducts.isEmpty) {
        print('No products found for this category.');
      }

      products.assignAll(fetchedProducts);
    } catch (e) {
      hasError(true);
      errorMessage.value = e.toString();
    } finally {
      createdLoading(false);
    }
  }

  // Insert a new product
  Future<void> insertProduct(
    String name,
    String description,
    double price,
    int stockQty,
    int categoryId,
    double discount,
  ) async {
    try {
      createdLoading(true);

      bool isCreated = await apiService.insertProduct(
        name,
        description,
        price,
        stockQty,
        categoryId,
        discount,
      );

      if (isCreated) {
        // Fetch products again after successful creation
        Get.snackbar(
            "Success", "Product added successfully!"); // Show success message
        fetchProduct();
      } else {
        Get.snackbar("Failure", "Product creation failed!");
      }
    } catch (e) {
      hasError(true);
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value); // Show error message
    } finally {
      createdLoading(false);
    }
  }

  // Insert a new product
  Future<void> updateStatus(int id) async {
    try {
      createdLoading(true);

      bool isCreated = await apiService.updateStatus(id);

      if (isCreated) {
        // Fetch products again after successful creation
        Get.snackbar(
            "Success", "Update status successfully!"); // Show success message
        fetchProduct();
      } else {
        Get.snackbar("Failure", "Update product failed!");
      }
    } catch (e) {
      hasError(true);
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value); // Show error message
    } finally {
      createdLoading(false);
    }
  }


    Future<void> updatePopular(int id) async {
    try {
      createdLoading(true);

      bool isCreated = await apiService.updatePopular(id);

      if (isCreated) {
        // Fetch products again after successful creation
        Get.snackbar(
            "Success", "Update status successfully!"); // Show success message
        fetchProduct();
      } else {
        Get.snackbar("Failure", "Update product failed!");
      }
    } catch (e) {
      hasError(true);
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value); // Show error message
    } finally {
      createdLoading(false);
    }
  }


    // Insert a new product
  Future<void> deleteById(int id) async {
    try {
      createdLoading(true);

      await apiService.deleteById(id);

      Get.snackbar(
            "Success", "Delete status successfully!"); // Show success message
        fetchProduct();
    } catch (e) {
      hasError(true);
      errorMessage.value = e.toString();
      Get.snackbar("Error", errorMessage.value); // Show error message
    } finally {
      createdLoading(false);
    }
  }

  // Handle page changes
  void nextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value++;
      fetchProduct();
    }
  }

  void previousPage() {
    if (currentPage.value > 1) {
      currentPage.value--;
      fetchProduct();
    }
  }

  void onChangeSearchTitle() {
    fetchProduct();
  }
}
