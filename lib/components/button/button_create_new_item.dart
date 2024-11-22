import 'package:flutter/material.dart';

class ButtonCreateNewItem extends StatelessWidget {
  final void Function() onPressed;
  const ButtonCreateNewItem({
    super.key,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 170,
        decoration: BoxDecoration(
          color: const Color(0xFF0D6EFD),
          borderRadius: BorderRadius.circular(5),
        ),
        child: const Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Add New Item",
              style: TextStyle(color: Colors.white),
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            )
          ],
        )),
      ),
    );
  }
}
