import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/widgets/onboarding_gate.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/data/datasources/mock_auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/logout_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/presentation/providers/cart_provider.dart';
import 'features/discovery/data/repositories/discovery_repository_impl.dart';
import 'features/discovery/domain/repositories/discovery_repository.dart';
import 'features/discovery/presentation/providers/discovery_data_provider.dart';
import 'features/discovery/presentation/providers/favorites_provider.dart';
import 'features/discovery/presentation/providers/home_provider.dart';
import 'features/discovery/presentation/providers/search_filter_provider.dart';
import 'features/products/data/datasources/mock_product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/get_product_detail_usecase.dart';
import 'features/products/presentation/providers/product_detail_provider.dart';
import 'features/products/presentation/providers/product_provider.dart';
import 'features/profile/data/datasources/mock_profile_remote_data_source.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/onboarding/presentation/providers/onboarding_provider.dart';
import 'features/profile/presentation/providers/profile_provider.dart';

void main() {
  runApp(const EcommerceApp());
}

/// Root widget: wires repositories, use cases, and providers, then shows
/// [OnboardingGate] which handles onboarding → auth → main shell.
class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthRepository authRepository = AuthRepositoryImpl(
      remoteDataSource: MockAuthRemoteDataSource(),
    );
    final loginUseCase = LoginUseCase(authRepository);
    final signupUseCase = SignupUseCase(authRepository);
    final logoutUseCase = LogoutUseCase(authRepository);

    final ProductRepository productRepository = ProductRepositoryImpl(
      remoteDataSource: MockProductRemoteDataSource(),
    );
    final getProductDetailUseCase = GetProductDetailUseCase(productRepository);
    final CartRepository cartRepository = CartRepositoryImpl();

    final ProfileRepository profileRepository = ProfileRepositoryImpl(
      remoteDataSource: MockProfileRemoteDataSource(),
    );

    final DiscoveryRepository discoveryRepository = DiscoveryRepositoryImpl(
      productRepository: productRepository,
    );

    return MultiProvider(
      providers: [
        Provider<DiscoveryRepository>.value(value: discoveryRepository),
        ChangeNotifierProvider(
          create: (_) => DiscoveryDataProvider(repository: discoveryRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
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
          create: (_) => ProductDetailProvider(
            getProductDetailUseCase: getProductDetailUseCase,
          ),
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
        home: const OnboardingGate(),
      ),
    );
  }
}
