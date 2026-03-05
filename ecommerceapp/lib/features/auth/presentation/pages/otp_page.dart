import 'package:flutter/material.dart';
import 'password_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _digitControllers =
      List.generate(4, (_) => TextEditingController(), growable: false);
  final _focusNodes = List.generate(4, (_) => FocusNode(), growable: false);

  @override
  void dispose() {
    for (final c in _digitControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.length == 1 && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left blob
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
          // Lighter overlay
          Positioned(
            top: -40,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFFE4ECFF),
                shape: BoxShape.circle,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 86,
                        height: 86,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF6EC7),
                        ),
                      ),
                      Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 42,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  'Hello, Romina!!',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Type your password',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: SizedBox(
                        width: 52,
                        height: 56,
                        child: TextField(
                          controller: _digitControllers[index],
                          focusNode: _focusNodes[index],
                          onChanged: (value) => _onDigitChanged(index, value),
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    letterSpacing: 2,
                                  ),
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          obscureText: true,
                          decoration: const InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Color(0xFFF6F7FB),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not you?',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0054F6),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const PasswordPage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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

