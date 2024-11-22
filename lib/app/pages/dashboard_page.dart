import 'package:coffee_app/app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:get/get.dart';
import 'package:coffee_app/app/controllers/product_controller.dart';
import 'package:coffee_app/components/button/button_create_new_item.dart';
import 'package:coffee_app/components/button/icon_button_action.dart';
import 'package:coffee_app/components/button/search_button.dart';
import 'package:coffee_app/components/popup/add_item_dialog.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});
  final ProductController productController = Get.put(ProductController());

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final int _sortColumnIndex = 0;
  bool _isAscending = true;
  int _rowsPerPage = 10; // Define a default rows per page value

  // Sort Functionality
  void _sortData(int columnIndex, bool ascending) {
    setState(() {});
  }

  @override
  void initState() {
    widget.productController.fetchProduct();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                    setState(() {});
                  },
                ),
                ButtonCreateNewItem(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AddItemDialog(onAdd: (newItem) {}),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Obx(() {
              if (widget.productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (widget.productController.products.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1500,
                  child: PaginatedDataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 5,
                    minWidth: 800,
                    sortColumnIndex: _sortColumnIndex,
                    sortAscending: _isAscending,
                    rowsPerPage: _rowsPerPage,
                    dataRowHeight: 100,
                    onRowsPerPageChanged: (value) {
                      setState(() {
                        _rowsPerPage = value ?? _rowsPerPage;
                      });
                    },
                    onPageChanged: (page) {
                      // Handle page changes if needed
                    },
                    columns: [
                      const DataColumn(
                        label: Center(child: Text('Order By')),
                      ),
                      DataColumn(
                        label: const Center(child: Text('Title')),
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                      const DataColumn2(
                        label: Text('Photo'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: const Text('Price'),
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                      const DataColumn(
                        label: Text('Discount'),
                      ),
                      const DataColumn(
                        label: Text('Category'),
                      ),
                      const DataColumn(
                        label: Text('Actions'),
                      ),
                    ],
                    source:
                        _ProductDataSource(widget.productController.products),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ProductDataSource extends DataTableSource {
  final List<Product> products;

  _ProductDataSource(this.products);

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;

    final product = products[index];
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(product.name)),
      DataCell(Image.network(
        product.thumbnail,
        width: 50,
        height: 100,
        fit: BoxFit.cover,
      )),
      DataCell(Text(product.price.toString())),
      DataCell(Text('${(product.discount != null) ? product.discount : '0'}%')),
      DataCell(Text(product.category.name)),
      DataCell(
        Row(
          children: [
            IconButtonAction(
              color: const Color(0xFF0D6EFD),
              icon: Icons.edit,
              text: "Edit",
              onTap: () {},
            ),
            const SizedBox(width: 10),
            IconButtonAction(
              color: const Color(0xFFF45A58),
              icon: Icons.delete_outline,
              text: "Delete",
              onTap: () {},
            ),
          ],
        ),
      ),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => products.length;

  @override
  int get selectedRowCount => 0;
}
