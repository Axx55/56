import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../../core/themes/app_colors.dart';
import '../../core/themes/app_dimensions.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await context.read<AuthProvider>().signIn(
      _phoneController.text.trim(),
      _passwordController.text,
    );
    if (mounted) {
      setState(() => _isLoading = false);
      if (context.read<AuthProvider>().isLoggedIn) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.paddingLg),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Center(
                      child: Text(
                        'م',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMd),
                  const Text(
                    'مسارات',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXxl,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const Text(
                    'النقل المدرسي الآمن',
                    style: TextStyle(
                      fontSize: AppDimensions.fontSm,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXl * 2),
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'رقم الجوال',
                      hintText: '05xxxxxxxx',
                      prefixIcon: const Icon(Icons.phone_android),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'الرجاء إدخال رقم الجوال'
                        : null,
                  ),
                  const SizedBox(height: AppDimensions.paddingMd),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'كلمة المرور',
                      prefixIcon: const Icon(Icons.lock_outlined),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) => v == null || v.isEmpty
                        ? 'الرجاء إدخال كلمة المرور'
                        : null,
                  ),
                  if (auth.error != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimensions.paddingSm,
                      ),
                      child: Text(
                        auth.error!,
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                  const SizedBox(height: AppDimensions.paddingLg),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _signIn,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'دخول',
                              style: TextStyle(fontSize: AppDimensions.fontMd),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingSm),
                  Text(
                    'للتجربة: 0501234567 / 123456',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXs,
                      color: AppColors.textHint,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
