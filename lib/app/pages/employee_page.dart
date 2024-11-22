import 'package:coffee_app/app/controllers/user_controller.dart';
import 'package:coffee_app/app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:get/get.dart';
import 'package:coffee_app/app/controllers/product_controller.dart';
import 'package:coffee_app/components/button/button_create_new_item.dart';
import 'package:coffee_app/components/button/icon_button_action.dart';
import 'package:coffee_app/components/button/search_button.dart';
import 'package:coffee_app/components/popup/add_item_dialog.dart';

class EmployeePage extends StatefulWidget {
  EmployeePage({super.key});
  final ProductController productController = Get.put(ProductController());
  final UserController userController = Get.put(UserController());

  @override
  _EmployeePageState createState() => _EmployeePageState();
}

class _EmployeePageState extends State<EmployeePage> {
  int _sortColumnIndex = 0;
  bool _isAscending = true;
  int _rowsPerPage = 10;


  // Sort Functionality
  void _sortData(int columnIndex, bool ascending) {
    
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

          // Data Table with Pagination
          Expanded(
            child: Obx(() {
              if (widget.userController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (widget.userController.users.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 1500,
                  child: PaginatedDataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
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
                        label: Text('Order By'),
                      ),
                      DataColumn(
                        label: const Text('Full Name'),
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                      DataColumn(
                        label: const Text('Email'),
                        onSort: (columnIndex, ascending) {
                          _sortData(columnIndex, ascending);
                        },
                      ),
                      const DataColumn(
                        label: Text('Role'),
                      ),
                      const DataColumn(
                        label: Text('Address'),
                      ),
                      const DataColumn(
                        label: Text('Actions'),
                      ),
                    ],
                    source: _ProductDataSource(widget.userController.users),
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
  final List<User> products;

  _ProductDataSource(this.products);

  @override
  DataRow? getRow(int index) {
    if (index >= products.length) return null;

    final product = products[index];
    return DataRow(cells: [
      DataCell(Text((index + 1).toString())),
      DataCell(Text(product.username)),
      DataCell(Text(product.email)),
      DataCell(Text(product.roles.map((role) => role.name).join(', '))),
      DataCell(Text(product.phone)),
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
