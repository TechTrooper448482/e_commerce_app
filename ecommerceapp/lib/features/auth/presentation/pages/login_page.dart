import 'package:flutter/material.dart';
import '../../../../core/widgets/app_button.dart';
import 'otp_page.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../providers/auth_provider.dart';
import '../widgets/social_login_button.dart';

part 'login_page_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}
