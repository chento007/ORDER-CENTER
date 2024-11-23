import 'package:coffee_app/app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: SizedBox(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo or App Name
                Icon(
                  Icons.local_cafe,
                  size: 100,
                  color: Colors.brown,
                ),
                SizedBox(height: 20),
                Text(
                  'POS Coffee',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
                SizedBox(height: 40),

                // Email TextField with Icons and Custom Style
                SizedBox(
                  width: 700,
                  child: TextField(
                    controller: authController.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.brown),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.brown,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: 20),

                // Password TextField with Icons and Custom Style
                SizedBox(
                  width: 700,
                  child: TextField(
                    controller: authController.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.brown),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.brown,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Loading Indicator or Login Button
                Obx(() {
                  return authController.isLoading.value
                      ? CircularProgressIndicator(
                          color: Colors.brown,
                        )
                      : ElevatedButton(
                          onPressed: authController.login,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        );
                }),

                // Forgot Password and Signup Links
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to forgot password page
                        Get.toNamed('/forgot-password');
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to register page
                        Get.toNamed('/register');
                      },
                      child: Text(
                        'Don\'t have an account? Sign Up',
                        style: TextStyle(color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
