import 'package:coffee_app/components/popup/delete_item_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:coffee_app/app/controllers/product_controller.dart';
import 'package:coffee_app/components/button/button_create_new_item.dart';
import 'package:coffee_app/components/button/icon_button_action.dart';
import 'package:coffee_app/components/button/search_button.dart';
import 'package:coffee_app/components/popup/add_item_dialog.dart';

class DashboardPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final primary = Colors.blue;

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final stockQtyController = TextEditingController();
  final discountController = TextEditingController();
  bool light = true;

  // Category selection
  String? selectedCategory;
  final List<String> categories = [
    'Electronics',
    'Books',
    'Clothing',
    'Home & Kitchen',
    'Sports',
    'Toys',
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 1500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchButton(
                        hintText: "Search",
                        onChanged: (value) {
                          print("change: ${value}");
                          // Handle search functionality if needed
                          productController.searchText.value = value;
                          productController.onChangeSearchTitle();
                        },
                      ),
                      ButtonCreateNewItem(
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('ID')),
                            DataColumn(label: Text('Title')),
                            DataColumn(label: Text('Price (\$)')),
                            DataColumn(label: Text('Discount')),
                            DataColumn(label: Text('Popular')),
                            DataColumn(label: Text('Category')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Action')),
                          ],
                          rows: List.generate(
                            productController.productDashboard.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(Text(
                                    '${productController.productDashboard[index].id}')),
                                DataCell(Text(productController
                                    .productDashboard[index].name)),
                                DataCell(Text(productController
                                    .productDashboard[index].price)),
                                DataCell(Text(
                                    '${productController.productDashboard[index].discount ?? 0}')),
                                DataCell(
                                  Switch.adaptive(
                                    applyCupertinoTheme: false,
                                    value: productController
                                        .productDashboard[index].isPopular,
                                    onChanged: (bool value) {
                                      productController.updatePopular(
                                          productController
                                              .productDashboard[index].id);
                                    },
                                  ),
                                ),
                                DataCell(Text(productController
                                    .productDashboard[index].category.name)),
                                DataCell(
                                  Switch.adaptive(
                                    applyCupertinoTheme: false,
                                    value: productController
                                        .productDashboard[index].status,
                                    onChanged: (bool value) {
                                      productController.updateStatus(
                                          productController
                                              .productDashboard[index].id);
                                    },
                                  ),
                                ),
                                DataCell(
                                  Row(
                                    children: [
                                      IconButtonAction(
                                        color: const Color(0xFF0D6EFD),
                                        icon: Icons.edit,
                                        text: "Edit",
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                EditItemDialog(
                                              product: productController
                                                  .productDashboard[index],
                                              onUpdate: (p0) {},
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(width: 10),
                                      IconButtonAction(
                                        color: const Color(0xFFF45A58),
                                        icon: Icons.delete_outline,
                                        text: "Delete",
                                        onTap: () {
                                          // Show the delete confirmation dialog
                                          showDialog(
                                            context: context,
                                            builder: (_) => DeleteItemDialog(
                                              index: productController
                                                  .productDashboard[index]
                                                  .id, // Pass the product id
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Pagination controls
                      Container(
                        width: 500,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Previous Button
                            ElevatedButton(
                              onPressed: productController.currentPage.value > 1
                                  ? productController.previousPage
                                  : null, // Disable button if on first page
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text('Previous',
                                      style: TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),

                            // Spacer
                            SizedBox(width: 20),

                            // Page Indicator Text
                            Text(
                              'Page ${productController.currentPage.value}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),

                            // Spacer
                            SizedBox(width: 20),

                            // Next Button
                            ElevatedButton(
                              onPressed: productController
                                              .productDashboard.length ==
                                          productController.pageSize &&
                                      productController.currentPage.value <
                                          productController.totalPages.value
                                  ? productController.nextPage
                                  : null, // Disable next button if fewer than 10 products or on last page
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              child: Row(
                                children: [
                                  Text('Next',
                                      style: TextStyle(color: Colors.blue)),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward, color: Colors.blue),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds a text field with a label, hint, and validation
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      validator: (value) =>
          value == null || value.isEmpty ? '$label is required' : null,
    );
  }

  /// Builds a numeric text field with a label and hint
  Widget _buildNumericField({
    required TextEditingController controller,
    required String label,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        } else if (double.tryParse(value) == null) {
          return 'Enter a valid number';
        }
        return null;
      },
    );
  }
}
