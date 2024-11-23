import 'package:coffee_app/app/models/user.dart';
import 'package:coffee_app/app/services/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AuthController extends GetxController {
  // Observable to manage loading state during login
  var isLoading = false.obs;

  final AuthService _authService = AuthService();

  // Define TextEditingController for login form
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    emailController.text = "super@test.com";
    passwordController.text ="Chento@123";
    super.onInit();
  }

  // Method to handle login process
  Future<void> login() async {
    // Check if the form is valid (you can also add form validation if needed)
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter both email and password');
      return;
    }

    // Start the loading state
    isLoading.value = true;

    try {
      // Call the AuthService to handle login
      await _authService.login(emailController.text, passwordController.text);

      // On successful login, navigate to the home page or main screen
      Get.offAllNamed('/home'); // You can change '/home' to your desired page

      // Show success message
      Get.snackbar('Success', 'Logged in successfully!',backgroundColor: Colors.brown,colorText: Colors.white);
    } catch (e) {
      print("login error : $e");
      // Handle errors (e.g., invalid login credentials)
      Get.snackbar('Error', 'Login failed. Please try again.');
    } finally {
      // Stop the loading state
      isLoading.value = false;
    }
  }

  // Optionally, you can create a logout function to clear tokens and redirect to login
  Future<void> logout() async {
    // await _authService.logout();
    Get.offAllNamed('/login'); // Navigate to login page after logout
  }
}
