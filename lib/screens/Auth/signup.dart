import 'package:book_management_app/Provider/Auth_Provider.dart';
import 'package:book_management_app/screens/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_colors.dart';
import '../../widgets/auth_textfield.dart';
import '../../widgets/back_button.dart';
import '../../widgets/primary_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  bool _isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Navigator.canPop(context)) const BackButtonWidget(),
                const SizedBox(height: 36),

                // Logo
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        'assets/images/book.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                const Text(
                  'Begin your\nreading journey.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 30,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Create your account and keep your favorite\nbooks and progress with you.',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 32),

                // Section divider
                Row(
                  children: [
                    Expanded(
                      child: Container(height: 1, color: AppColors.divider),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'CREATE ACCOUNT',
                        style: TextStyle(
                          color: AppColors.grey.withOpacity(0.6),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(height: 1, color: AppColors.divider),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                AuthTextField(
                  controller: emailController,
                  label: 'EMAIL ADDRESS',
                  hint: 'you@example.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),

                const SizedBox(height: 18),

                AuthTextField(
                  controller: passwordController,
                  label: 'PASSWORD',
                  hint: 'Create a strong password',
                  prefixIcon: Icons.lock_outline_rounded,
                  obscureText: isPasswordHidden,
                  onVisibilityPressed: () {
                    setState(() => isPasswordHidden = !isPasswordHidden);
                  },
                ),

                const SizedBox(height: 18),

                AuthTextField(
                  controller: confirmPasswordController,
                  label: 'CONFIRM PASSWORD',
                  hint: 'Repeat your password',
                  prefixIcon: Icons.lock_reset_outlined,
                  obscureText: isConfirmPasswordHidden,
                  onVisibilityPressed: () {
                    setState(
                      () =>
                          isConfirmPasswordHidden = !isConfirmPasswordHidden,
                    );
                  },
                ),

                const SizedBox(height: 30),

                PrimaryButton(
                  text: 'Create Account',
                  isLoading: _isLoading,
                  onPressed: () async {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      _showSnack('Passwords do not match', isError: true);
                      return;
                    }
                    setState(() => _isLoading = true);
                    final success = await context.read<AuthProvider>().signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                    if (!mounted) return;
                    setState(() => _isLoading = false);
                    if (success) {
                      _showSnack('Account created successfully!');
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    } else {
                      _showSnack('Signup failed. Please try again.',
                          isError: true);
                    }
                  },
                ),

                const SizedBox(height: 28),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
