import 'package:flutter/material.dart';
import 'ready_start_page.dart';

class HelloCardPage extends StatefulWidget {
  const HelloCardPage({super.key});

  @override
  State<HelloCardPage> createState() => _HelloCardPageState();
}

class _HelloCardPageState extends State<HelloCardPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ReadyStartPage(),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.05, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: child,
              ),
            );
          },
        ),
      );
    });
  }

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
          // Slight white overlay to mimic cut-out corner
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 90),
                Center(
                  child: Container(
                    width: 260,
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
                        // Top image area
                        Container(
                          height: 220,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(32),
                            ),
                            color: Color(0xFFFF7FA8),
                          ),
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Icon(
                              Icons.shopping_bag,
                              size: 64,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Hello',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                                'Sed non consectetur turpis. Morbi eu eleifend lacus.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      height: 1.5,
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
                    _PageDot(isActive: false),
                    const SizedBox(width: 8),
                    _PageDot(isActive: true),
                    const SizedBox(width: 8),
                    _PageDot(isActive: false),
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

class _PageDot extends StatelessWidget {
  const _PageDot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? const Color(0xFF0054F6)
            : const Color(0xFFD8DEEA),
      ),
    );
  }
}

