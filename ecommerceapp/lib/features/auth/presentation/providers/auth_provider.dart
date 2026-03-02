import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _loginUseCase = loginUseCase,
        _signupUseCase = signupUseCase,
        _logoutUseCase = logoutUseCase;

  final LoginUseCase _loginUseCase;
  final SignupUseCase _signupUseCase;
  final LogoutUseCase _logoutUseCase;

  UserEntity? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  UserEntity? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _currentUser = await _loginUseCase(email: email, password: password);
    } catch (e) {
      _errorMessage = 'Login failed. Please try again.';
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    try {
      _currentUser = await _signupUseCase(
        name: name,
        email: email,
        password: password,
      );
    } catch (e) {
      _errorMessage = 'Signup failed. Please try again.';
      if (kDebugMode) {
        // ignore: avoid_print
        print(e);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    _setLoading(true);

    try {
      await _logoutUseCase();
      _currentUser = null;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  /// Helper to access [AuthProvider] from the widget tree.
  static AuthProvider of(BuildContext context, {bool listen = true}) {
    return listen
        ? context.watch<AuthProvider>()
        : context.read<AuthProvider>();
  }

  /// Factory method so buyers can easily register this provider
  /// in their DI setup if they are not using [MultiProvider]
  /// as shown in `main.dart`.
  static SingleChildWidget buildProvider({
    required LoginUseCase loginUseCase,
    required SignupUseCase signupUseCase,
    required LogoutUseCase logoutUseCase,
  }) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(
        loginUseCase: loginUseCase,
        signupUseCase: signupUseCase,
        logoutUseCase: logoutUseCase,
      ),
    );
  }
}

