import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:ui';

import 'core/theme/app_theme.dart';
import 'features/auth/data/datasources/mock_auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/presentation/pages/cart_page.dart';
import 'features/cart/presentation/providers/cart_provider.dart';
import 'features/discovery/data/services/mock_product_service.dart';
import 'features/discovery/presentation/pages/home_view.dart';
import 'features/discovery/presentation/providers/favorites_provider.dart';
import 'features/discovery/presentation/providers/home_provider.dart';
import 'features/discovery/presentation/providers/search_filter_provider.dart';
import 'features/products/data/datasources/mock_product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/presentation/providers/product_provider.dart';
import 'features/profile/data/datasources/mock_profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/onboarding/presentation/pages/onboarding_page.dart';
import 'features/onboarding/presentation/providers/onboarding_provider.dart';
import 'features/profile/presentation/pages/profile_page.dart';
import 'features/profile/presentation/providers/profile_provider.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate repositories and data sources here so they can
    // later be swapped with real API implementations without
    // touching the UI layer.
    final AuthRepository authRepository = AuthRepositoryImpl(
      remoteDataSource: MockAuthRemoteDataSource(),
    );
    final loginUseCase = LoginUseCase(authRepository);
    final signupUseCase = SignupUseCase(authRepository);
    final logoutUseCase = LogoutUseCase(authRepository);

    final ProductRepository productRepository = ProductRepositoryImpl(
      remoteDataSource: MockProductRemoteDataSource(),
    );
    final CartRepository cartRepository = CartRepositoryImpl();

    final ProfileRepository profileRepository = ProfileRepositoryImpl(
      remoteDataSource: MockProfileRemoteDataSource(),
    );

    final MockProductService mockProductService =
        MockProductService(productRepository: productRepository);

    return MultiProvider(
      providers: [
        Provider<MockProductService>.value(value: mockProductService),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(productService: mockProductService),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchFilterProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            loginUseCase: loginUseCase,
            signupUseCase: signupUseCase,
            logoutUseCase: logoutUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(productRepository: productRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(cartRepository: cartRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(repository: profileRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'E-commerce App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const _OnboardingGate(),
      ),
    );
  }
}

/// Shows onboarding until the user completes it (Skip or Get Started),
/// then shows the main app (auth flow or shell).
class _OnboardingGate extends StatelessWidget {
  const _OnboardingGate();

  @override
  Widget build(BuildContext context) {
    final onboarding = context.watch<OnboardingProvider>();
    if (!onboarding.hasCompletedOnboarding) {
      return const OnboardingPage();
    }
    return const _RootNavigator();
  }
}

/// Decides whether to show the auth flow or the main app shell
/// based on the current authentication state.
class _RootNavigator extends StatelessWidget {
  const _RootNavigator();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (!auth.isAuthenticated) {
      return const LoginPage();
    }

    return const _MainShell();
  }
}

class _MainShell extends StatefulWidget {
  const _MainShell();

  @override
  State<_MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<_MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = <Widget>[
    const HomeView(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: _GlassmorphicNavBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}

class _GlassmorphicNavBar extends StatelessWidget {
  const _GlassmorphicNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.82),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.black.withOpacity(0.04),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _NavItem(
                icon: Icons.storefront_outlined,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              _NavItem(
                icon: Icons.shopping_bag_outlined,
                label: 'Cart',
                isActive: currentIndex == 1,
                onTap: () => onTap(1),
              ),
              _NavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: isActive ? 16 : 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? theme.colorScheme.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            if (isActive) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

