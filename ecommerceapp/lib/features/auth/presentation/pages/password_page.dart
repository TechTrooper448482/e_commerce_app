import 'package:flutter/material.dart';
import 'hello_card_page.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  static const int _maxLength = 6;

  @override
  void initState() {
    super.initState();
    // Autofocus the hidden text field so the keyboard shows immediately.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (value.length > _maxLength) {
      _controller.text = value.substring(0, _maxLength);
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: _controller.text.length),
      );
    }
    setState(() {});

    if (_controller.text.length == _maxLength) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const HelloCardPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final length = _controller.text.length.clamp(0, _maxLength);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left primary blob
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
                const SizedBox(height: 40),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _focusNode.requestFocus(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          _maxLength,
                          (index) {
                            final isFilled = index < length;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                curve: Curves.easeOut,
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isFilled
                                      ? const Color(0xFF0054F6)
                                      : const Color(0xFFD8DEEA),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Invisible text field that just drives the keyboard & value.
                      Opacity(
                        opacity: 0.0,
                        child: SizedBox(
                          width: 240,
                          height: 48,
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            onChanged: _onChanged,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            maxLength: _maxLength,
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                            ),
                          ),
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

