import 'package:flutter/material.dart';
import '../../../../core/widgets/app_button.dart';
import 'otp_page.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'demo@shop.com');
  final _passwordController = TextEditingController(text: 'password');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left primary blue blob
          Positioned(
            top: -180,
            left: -140,
            child: Container(
              width: 360,
              height: 360,
              decoration: const BoxDecoration(
                color: Color(0xFF0054F6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Lighter blue overlay to mimic layered shape
          Positioned(
            top: -40,
            left: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFFE4ECFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Mid-right blue blob
          Positioned(
            top: 180,
            right: -70,
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                color: Color(0xFF006BFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // Bottom pale background blob
          Positioned(
            bottom: -160,
            left: -40,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF1FF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Login',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Good to see you back!',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.favorite,
                            size: 14,
                            color: Colors.black87,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Theme(
                        data: Theme.of(context).copyWith(
                          inputDecorationTheme:
                              Theme.of(context).inputDecorationTheme.copyWith(
                                    filled: true,
                                    fillColor: const Color(0xFFF9FAFF),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: Colors.black26,
                                          fontSize: 14,
                                        ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                      vertical: 16,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(32),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0054F6),
                                        width: 1.4,
                                      ),
                                    ),
                                  ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              controller: _emailController,
                              label: 'Email',
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (auth.errorMessage != null) ...[
                        Text(
                          auth.errorMessage!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      Theme(
                        data: Theme.of(context).copyWith(
                          filledButtonTheme: FilledButtonThemeData(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF0054F6),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                        child: AppButton(
                          label: 'Next',
                          isLoading: auth.isLoading,
                          onPressed: auth.isLoading
                              ? null
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => const OtpPage(),
                                    ),
                                  );
                                },
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'This is a mock auth flow. Replace the auth data source and repository with your real API calls.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.black45,
                            ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

