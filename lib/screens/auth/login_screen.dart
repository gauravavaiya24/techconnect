import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/widgets/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginScreen({super.key});

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      _authController.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
              () => Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'lib/assets/pngs/wirelessNetworkConnectivityDevice.png',
                      width: 300,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    Text('TechConnect', style: Get.textTheme.headlineMedium),
                  ],
                ),
                Column(
                  children: [
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'Please enter email-id',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        } else if (!RegExp(
                            r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                            .hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 50),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'Password',
                      hintText: 'Please enter password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.length < 6) {
                          return 'Minimum 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _authController.isLoading.value
                            ? null
                            : _handleLogin,
                        child: _authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : const Text('Login'),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 60),
                    TextButton(
                      onPressed: () => Get.toNamed('/signup'),
                      child: const Text('Create new account'),
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
