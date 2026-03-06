import 'package:flutter/material.dart';

import '../../features/cart/presentation/pages/cart_page.dart';
import '../../features/discovery/presentation/pages/home_view.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import 'glassmorphic_nav_bar.dart';

part 'main_shell_state.dart';


/// Main app shell: bottom nav (Home, Cart, Profile) and page container.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => MainShellState();
}
