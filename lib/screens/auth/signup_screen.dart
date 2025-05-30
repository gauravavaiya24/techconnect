import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techconnect/controllers/auth_controller.dart';
import 'package:techconnect/widgets/custom_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthController _authController = Get.find();
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      bool success = await _authController.signUp(name, email, password);
      if (success) {
        _nameController.clear();
        _emailController.clear();
        _passwordController.clear();
        Get.offNamed('/login');
      } else {
        Get.snackbar('Error', _authController.errorMessage.value,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Obx(
                () => Column(
              children: [
                CustomTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hintText: 'Please enter full name',
                  validator: (value) =>
                  value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 50),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Please enter email-id',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
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
                        : _handleSignup,
                    child: _authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : const Text('Sign Up'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

