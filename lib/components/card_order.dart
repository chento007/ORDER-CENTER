import 'package:flutter/material.dart';
import 'package:coffee_app/app/models/invoice_detail.dart';
import 'package:coffee_app/app/models/product.dart';
import 'package:coffee_app/components/button_quantity.dart';
import 'package:coffee_app/components/quantity_selector.dart';

class CardOrder extends StatelessWidget {
  final InvoiceDetail invoiceDetail;
  final int qty;
  final VoidCallback handleRemoveItem;
  final VoidCallback incrementQuantity;

  final VoidCallback decrementQuantity;

  const CardOrder(
      {Key? key,
      required this.invoiceDetail,
      required this.handleRemoveItem,
      required this.incrementQuantity,
      required this.qty,
      required this.decrementQuantity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            // Product Details
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  children: [
                    // Product Name and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              invoiceDetail.product.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Text(
                                    "Size: Small", // Example metadata
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                  child: const Text(
                                    "Sugar: Normal", // Example metadata
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: handleRemoveItem,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFF45A58),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Product Price and Quantity Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$ ${invoiceDetail.product.price.toString()}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            QuantitySelector(
                              quantity: qty,
                              incrementQuantity: incrementQuantity,
                              decrementQuantity: decrementQuantity,
                            ),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
