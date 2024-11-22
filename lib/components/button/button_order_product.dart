import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ButtonOrderProduct extends StatelessWidget {
  // Callback when the button is clicked
  final VoidCallback onPressed;

  // Color properties for the button's gradient
  final Color buttonColor;

  // Title for the button
  final String title;

  // Icon for the button
  final Icon icon;

  const ButtonOrderProduct({
    super.key,
    required this.onPressed,
    this.buttonColor = const Color(0xFFF5BC65), // Default gradient colors
    this.title = "Order Product", // Default title
    this.icon = const Icon(Icons.shopping_cart, color: Colors.white, size: 24), // Default icon
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: Colors.white.withOpacity(0.3), // Splash effect when clicked
      highlightColor: Colors.orange.withOpacity(0.1), // Highlight effect
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Subtle shadow for depth
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon, // Custom icon
              SizedBox(width: 8), // Space between the icon and the text
              Text(
                title, // Custom title
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600, // Bold text
                  color: Colors.white,
                  letterSpacing: 1.2, // Letter spacing for readability
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
