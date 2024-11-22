import 'package:flutter/material.dart';

class AddItemDialog extends StatelessWidget {
  final Function(Map<String, dynamic>) onAdd;

  const AddItemDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final discountController = TextEditingController();
    final photoController = TextEditingController();

    return AlertDialog(
      title: const Text('Create New Item'),
      content: Container(
        width: 600,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              decoration: const InputDecoration(labelText: 'Discount'),
            ),
            TextField(
              controller: photoController,
              decoration: const InputDecoration(labelText: 'Photo URL'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            onAdd({
              'title': titleController.text,
              'photo': photoController.text.isNotEmpty
                  ? photoController.text
                  : 'https://via.placeholder.com/150',
              'price': priceController.text,
              'discount': discountController.text,
              'number': 0, // You can set it dynamically based on your data
            });
            Navigator.of(context).pop();
          },
          child: const Text('Add Item'),
        ),
      ],
    );
  }
}
