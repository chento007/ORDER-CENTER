import 'package:coffee_app/app/controllers/invoice_controller.dart';
import 'package:coffee_app/components/button/button_order_product.dart';
import 'package:coffee_app/components/card_order.dart';
import 'package:coffee_app/core/utils/screen_type_device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class OrderProduct extends StatelessWidget {
  final InvoiceController invoiceController = Get.put(InvoiceController());

  @override
  Widget build(BuildContext context) {
    // Determine the screen type
    final isPhone = ScreenTypeDevice.isPhone(context);
    final isTablet = ScreenTypeDevice.isTablet(context);
    final isDesktop = ScreenTypeDevice.isDesktop(context);
    final isExtraSmall = ScreenTypeDevice.isExtraSmall(context);

    // Dynamic values for responsive design
    final double padding = isPhone
        ? 4.0 // Further reduced from 6.0
        : isTablet
            ? 8.0 // Further reduced from 10.0
            : isDesktop
                ? 10.0 // Further reduced from 12.0
                : 2.0; // Further reduced for extra small devices from 3.0

    final double fontSize = isPhone
        ? 10.0 // Further reduced from 12.0
        : isTablet
            ? 12.0 // Further reduced from 14.0
            : isDesktop
                ? 14.0 // Further reduced from 16.0
                : 8.0; // Further reduced for extra small devices from 10.0

    return Obx(() {
      return Center(
        child: Stack(
          children: [
            // Scrollable list of items
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: isPhone
                        ? 160.0
                        : (isTablet
                            ? 180.0
                            : 200.0)), // Reserve space for the bottom summary
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: invoiceController.invoiceDetails.length,
                      itemBuilder: (context, index) => CardOrder(
                        qty: invoiceController.invoiceDetails[index].quantity,
                        handleRemoveItem: () {
                          invoiceController.removeInvoiceDetail(
                              invoiceController.invoiceDetails[index]);
                        },
                        invoiceDetail: invoiceController.invoiceDetails[index],
                        decrementQuantity: () {
                          invoiceController.decreaseQuantity(index);
                        },
                        incrementQuantity: () {
                          invoiceController.increaseQuantity(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Invoice summary section at the bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(padding),
                margin: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: padding / 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFECEBE9),
                    width: isPhone ? 2.0 : (isTablet ? 3.0 : 4.0),
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Subtotal section
                    _buildSummaryRow(
                      "Sub total",
                      "\$ ${invoiceController.getSubTotal()}",
                      fontSize,
                    ),
                    SizedBox(height: isPhone ? 8 : 12),
                    // Discount section
                    _buildSummaryRow(
                      "Discount amount",
                      "\$ ${invoiceController.getDiscountAmount()}",
                      fontSize,
                    ),
                    Divider(color: Colors.black),
                    SizedBox(height: isPhone ? 8 : 12),
                    // Total payment in USD
                    _buildSummaryRow(
                      "Total Payment Dollar (\$)",
                      "\$ ${invoiceController.getTotalPaymentUSD()}",
                      fontSize,
                    ),
                    // Total payment in Riel
                    _buildSummaryRow(
                      "Total Payment Riel  (\៛)",
                      "\៛ ${invoiceController.getTotalPaymentRiel()}",
                      fontSize,
                    ),
                    SizedBox(height: isPhone ? 16 : 24),
                    // Action buttons
                    _buildButtonRow(context, isPhone, isTablet, isDesktop),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  // Helper widget to build a row for summary items
  Widget _buildSummaryRow(String label, String value, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // Helper widget to build action buttons
  Widget _buildButtonRow(
      BuildContext context, bool isPhone, bool isTablet, bool isDesktop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Clear all button
        ButtonOrderProduct(
          onPressed: () {
            Get.find<InvoiceController>().clearInvoice();
          },
          title: "Clear all",
          icon: Icon(
            Icons.delete_forever,
            color: Colors.white,
          ),
          buttonColor: Colors.redAccent,
        ),
        SizedBox(width: isPhone ? 12 : (isTablet ? 20 : 30)),
        // Checkout button
        ButtonOrderProduct(
          onPressed: () async {
            await SunmiPrinter.bindingPrinter();
          },
          title: "Checkout out",
        ),
      ],
    );
  }
}
