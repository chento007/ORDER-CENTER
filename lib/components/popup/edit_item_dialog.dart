import 'package:flutter/material.dart';

class EditItemDialog extends StatelessWidget {
  final int index;
  final Map<String, dynamic> itemData;
  final Function(Map<String, dynamic>) onUpdate;

  const EditItemDialog({
    Key? key,
    required this.index,
    required this.itemData,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: itemData['title']);
    final priceController = TextEditingController(text: itemData['price']);
    final discountController =
        TextEditingController(text: '0'); // Default to '0'
    final photoController = TextEditingController(text: itemData['photo']);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 600, // Set the width of the dialog
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Edit Item',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: discountController,
              keyboardType: TextInputType.number, // To ensure numeric input
              decoration: const InputDecoration(labelText: 'Discount'),
              onChanged: (value) {
                // If the input is empty, set the text to '0'
                if (value.isEmpty) {
                  discountController.text = '0';
                } else {
                  // Ensure the value entered is a valid number
                  final number = double.tryParse(value);
                  if (number == null) {
                    discountController.text =
                        '0'; // Set to '0' if not a valid number
                  }
                }
              },
            ),

            TextField(
              controller: photoController,
              decoration: const InputDecoration(labelText: 'Photo URL'),
            ),
            const SizedBox(height: 20),
            // Preview photo if URL is valid
            if (photoController.text.isNotEmpty)
              Column(
                children: [
                  Image.asset(
                    photoController.text,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error,
                          size: 50, color: Colors.red);
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onUpdate({
                      'title': titleController.text,
                      'photo': photoController.text.isNotEmpty
                          ? photoController.text
                          : 'https://via.placeholder.com/150',
                      'price': priceController.text,
                      'number': itemData['number'], // Keep the number the same
                    });
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Update Item'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
