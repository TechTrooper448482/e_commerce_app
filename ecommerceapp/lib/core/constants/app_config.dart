/// Central place to configure base URLs, API keys and
/// other environment specific values.
///
/// Buyers should update the values in [AppConfig] when
/// connecting this template to a real backend.
class AppConfig {
  const AppConfig._();

  /// Example: https://api.your-backend.com
  static const String baseUrl = 'https://your-api-base-url.com';

  /// Example: sk_live_xxx
  static const String apiKey = 'YOUR_API_KEY_HERE';

  /// Toggle between mock and real APIs.
  ///
  /// When you integrate your own backend, set this to `false`
  /// and update the data sources to call your APIs using
  /// [baseUrl] and [apiKey].
  static const bool useMockData = true;
}

