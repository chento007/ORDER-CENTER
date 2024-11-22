import 'package:coffee_app/app/models/invoice.dart';
import 'package:coffee_app/app/models/invoice_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
  var invoice = Rx<Invoice?>(null);
  var invoiceDetails = <InvoiceDetail>[].obs;

  /// Add an invoice detail to the list
  void addInvoiceDetail(InvoiceDetail detail, int index) {
    print("Trying to add: $detail");

    // Check if the product already exists in the list
    bool exists = invoiceDetails.any((existingDetail) => existingDetail.product.id == detail.product.id);

    if (exists) {
      // Show a toast (snackbar) if the product already exists
      Get.snackbar(
        "Item Already Added",
        "This product is already in your invoice. Quantity will be updated.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );

      // If the product already exists, update its quantity
      var existingDetail = invoiceDetails.firstWhere((existingDetail) => existingDetail.product.id == detail.product.id);
      existingDetail.quantity += detail.quantity; // Increase quantity
      existingDetail.subTotal = existingDetail.quantity * existingDetail.unitPrice;

      // Reassign the list to trigger the UI update
      invoiceDetails.assignAll([...invoiceDetails]);
    } else {
      invoiceDetails.add(detail);
    }

    update();  // Notify GetX that the data has changed
  }




  /// Remove an invoice detail from the list by instance
  void removeInvoiceDetail(InvoiceDetail detail) {
    invoiceDetails.remove(detail);
  }

  /// Remove an invoice detail from the list by ID
  void removeInvoiceDetailById(int id) {
    invoiceDetails.removeWhere((detail) => detail.id == id);
  }

  /// Clear the invoice and details
  void clearInvoice() {
    invoice.value = null;
    invoiceDetails.clear();
  }

  /// Update the current invoice
  void updateInvoice(Invoice newInvoice) {
    invoice.value = newInvoice;
  }

  /// 1. Return Subtotal (Sum of all individual subtotals from invoice details)
  double getSubTotal() {
    double subTotal = 0;
    for (var detail in invoiceDetails) {
      subTotal += detail.subTotal;
    }
    return subTotal;
  }

  /// 2. Apply Discount to all products and return the total discount
  double applyDiscountToAll() {
    double totalDiscount = 0;
    for (var detail in invoiceDetails) {
      double productDiscount = detail.subTotal * (detail.discount / 100);
      totalDiscount += productDiscount;
    }
    return totalDiscount;
  }

  /// 3. Discount Amount (Total amount of discount applied to the entire invoice)
  double getDiscountAmount() {
    return applyDiscountToAll(); // Total discount for all products
  }

  /// 4. Total Payment in USD (after applying discounts)
  double getTotalPaymentUSD() {
    double subTotal = getSubTotal();
    double totalDiscount = applyDiscountToAll();
    double totalPayment = subTotal - totalDiscount;
    return totalPayment;
  }

  /// 5. Total Payment in Riel (Cambodian currency, assuming 1 USD = 4000 Riel)
  double getTotalPaymentRiel() {
    double totalUSD = getTotalPaymentUSD();
    const exchangeRate = 4000; // 1 USD = 4000 Riel (Adjust as per current rate)
    return totalUSD * exchangeRate;
  }


  void increaseQuantity(int index) {
    if (index < 0 || index >= invoiceDetails.length) {
      // Handle invalid index
      return;
    }

    var detail = invoiceDetails[index];

    // Update the quantity first, then calculate the subtotal
    detail.quantity += 1;
    detail.subTotal = detail.quantity * detail.unitPrice;

    // Notify GetX that the list has changed
    invoiceDetails[index] = detail;

    // Trigger UI update
    update();
  }

  void decreaseQuantity(int index) {
    if (index < 0 || index >= invoiceDetails.length) {
      // Handle invalid index
      print("Invalid index");
      return;
    }

    var detail = invoiceDetails[index];

    if (detail.quantity > 1) {
      detail.quantity -= 1;
      detail.subTotal = detail.quantity * detail.unitPrice; // Update subtotal

      // Notify GetX that the list has changed
      invoiceDetails[index] = detail;  // Set the updated detail back into the list

      // Trigger UI update
      update();
    } else {
      print("Cannot decrease quantity below 1");
    }
  }


}
