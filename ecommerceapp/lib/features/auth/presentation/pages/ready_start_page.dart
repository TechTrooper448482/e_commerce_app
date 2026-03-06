import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_page_dot.dart';

class ReadyStartPage extends StatelessWidget {
  const ReadyStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left blue blob
          Positioned(
            top: -200,
            left: -160,
            child: Container(
              width: 380,
              height: 380,
              decoration: const BoxDecoration(
                color: Color(0xFF0054F6),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 80),
                Center(
                  child: Container(
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 24,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Top image area - split pastel (light blue left, light pink right)
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                          child: SizedBox(
                            height: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: const Color(0xFFB8E0F0),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        color: const Color(0xFFFFB6C1),
                                      ),
                                    ),
                                  ],
                                ),
                                Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.shopping_bag,
                                        size: 48,
                                        color:
                                            Colors.white.withOpacity(0.9),
                                      ),
                                      const SizedBox(width: 32),
                                      Icon(
                                        Icons.phone_android,
                                        size: 40,
                                        color:
                                            Colors.white.withOpacity(0.9),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Ready?',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 13,
                                      color: Colors.black54,
                                      height: 1.5,
                                    ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: () async {
                                    final auth = context.read<AuthProvider>();
                                    await auth.login(
                                      email: 'demo@shop.com',
                                      password: 'password',
                                    );
                                    if (!context.mounted) return;
                                    Navigator.of(context).popUntil(
                                      (route) => route.isFirst,
                                    );
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF0054F6),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                    ),
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                  ),
                                  child: const Text("Let's Start"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthPageDot(isActive: false),
                    const SizedBox(width: 8),
                    AuthPageDot(isActive: false),
                    const SizedBox(width: 8),
                    AuthPageDot(isActive: false),
                    const SizedBox(width: 8),
                    AuthPageDot(isActive: true),
                  ],
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    width: 70,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

