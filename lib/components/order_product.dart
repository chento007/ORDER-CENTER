import 'package:coffee_app/app/controllers/invoice_controller.dart';
import 'package:coffee_app/app/models/invoice_detail.dart';
import 'package:coffee_app/components/button/button_order_product.dart';
import 'package:coffee_app/components/card_order.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderProduct extends StatelessWidget {
  final InvoiceController invoiceController = Get.put(InvoiceController());


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Center(
        child: Column(
          children: [
            Expanded(
              flex: 12,
              child: Container(
                color: Colors.white,
                child: ListView.builder(
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
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color(0xFFECEBE9), // Border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Align items at the bottom

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sub total",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "\$ ${invoiceController.getSubTotal()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Discount amount",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "\$ ${invoiceController.getDiscountAmount()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Payment Dollar (\$)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "\$ ${invoiceController.getTotalPaymentUSD()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total Payment Riel  (\៛)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "\៛ ${invoiceController.getTotalPaymentRiel()}",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonOrderProduct(
                          onPressed: () {
                            invoiceController.clearInvoice();
                          },
                          title: "Clear all",
                          icon: Icon(
                            Icons.delete_forever,
                            color: Colors.white,
                          ),
                          buttonColor: Colors.redAccent,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ButtonOrderProduct(
                          onPressed: () {
                            print("printing report ...");
                          },
                          title: "Checkout out",
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
