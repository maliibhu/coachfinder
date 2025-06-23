import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../theme/app_theme.dart';
import './widgets/auth_form_widget.dart';
import './widgets/auth_logo_widget.dart';
import './widgets/social_login_widget.dart';

class AuthenticationLoginRegister extends StatefulWidget {
  const AuthenticationLoginRegister({super.key});

  @override
  State<AuthenticationLoginRegister> createState() =>
      _AuthenticationLoginRegisterState();
}

class _AuthenticationLoginRegisterState
    extends State<AuthenticationLoginRegister>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();

  // Login controllers
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  // Register controllers
  final TextEditingController _registerNameController = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();

  bool _isLoginPasswordVisible = false;
  bool _isRegisterPasswordVisible = false;
  bool _isLoading = false;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'email': 'coach@example.com',
    'password': 'password123',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Full name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Check mock credentials
    if (_loginEmailController.text == _mockCredentials['email'] &&
        _loginPasswordController.text == _mockCredentials['password']) {
      // Success - trigger haptic feedback
      HapticFeedback.lightImpact();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successful!'),
            backgroundColor: AppTheme.getSuccessColor(true),
          ),
        );
        Navigator.pushReplacementNamed(context, '/home-dashboard');
      }
    } else {
      // Error handling
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Invalid credentials. Use: ${_mockCredentials['email']} / ${_mockCredentials['password']}'),
            backgroundColor: AppTheme.lightTheme.colorScheme.error,
          ),
        );
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleRegister() async {
    if (!_registerFormKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Success - trigger haptic feedback
    HapticFeedback.lightImpact();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: AppTheme.getSuccessColor(true),
        ),
      );
      Navigator.pushReplacementNamed(context, '/home-dashboard');
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _handleSocialLogin(String provider) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$provider login integration coming soon!'),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _handleForgotPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Password'),
        content: Text('Password reset functionality will be implemented soon.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                child: Column(
                  children: [
                    SizedBox(height: 4.h),

                    // Logo Section
                    AuthLogoWidget(),

                    SizedBox(height: 4.h),

                    // Tab Bar
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.lightTheme.dividerColor,
                          width: 1,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: AppTheme.lightTheme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelColor: AppTheme.lightTheme.colorScheme.onPrimary,
                        unselectedLabelColor:
                            AppTheme.lightTheme.colorScheme.onSurface,
                        dividerColor: Colors.transparent,
                        tabs: [
                          Tab(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Tab Bar View
                    SizedBox(
                      height: 50.h,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Login Form
                          AuthFormWidget(
                            formKey: _loginFormKey,
                            isLogin: true,
                            emailController: _loginEmailController,
                            passwordController: _loginPasswordController,
                            nameController: null,
                            isPasswordVisible: _isLoginPasswordVisible,
                            onPasswordVisibilityToggle: () {
                              setState(() {
                                _isLoginPasswordVisible =
                                    !_isLoginPasswordVisible;
                              });
                            },
                            onSubmit: _handleLogin,
                            onForgotPassword: _handleForgotPassword,
                            isLoading: _isLoading,
                            validateEmail: _validateEmail,
                            validatePassword: _validatePassword,
                            validateName: null,
                          ),

                          // Register Form
                          AuthFormWidget(
                            formKey: _registerFormKey,
                            isLogin: false,
                            emailController: _registerEmailController,
                            passwordController: _registerPasswordController,
                            nameController: _registerNameController,
                            isPasswordVisible: _isRegisterPasswordVisible,
                            onPasswordVisibilityToggle: () {
                              setState(() {
                                _isRegisterPasswordVisible =
                                    !_isRegisterPasswordVisible;
                              });
                            },
                            onSubmit: _handleRegister,
                            onForgotPassword: null,
                            isLoading: _isLoading,
                            validateEmail: _validateEmail,
                            validatePassword: _validatePassword,
                            validateName: _validateName,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 3.h),

                    // Social Login Section
                    SocialLoginWidget(
                      onSocialLogin: _handleSocialLogin,
                    ),

                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
