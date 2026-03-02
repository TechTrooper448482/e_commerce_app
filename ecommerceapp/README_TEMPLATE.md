## E-commerce Flutter App Template

This is a clean-architecture E-commerce app template built with Flutter and Provider, designed for easy integration with your own backend (REST, GraphQL, Firebase, etc.).

### Folder Structure

- `lib/core` – Shared, app-wide code
  - `constants/app_config.dart` – **Update this** with your `baseUrl`, API keys and mock/real toggle.
  - `theme/app_theme.dart` – Global colors, typography, theming.
  - `network/api_client.dart` – Dio wrapper. Add interceptors, headers, logging here.
  - `widgets/` – Shared UI elements like `AppButton`, `AppTextField`.

- `lib/features/auth`
  - `domain` – `UserEntity`, `AuthRepository`, `LoginUseCase`, `SignupUseCase`, `LogoutUseCase`.
  - `data` – `MockAuthRemoteDataSource`, `AuthRepositoryImpl`, `UserModel`.
  - `presentation` – `AuthProvider`, `LoginPage` (login/signup toggle, mock success).

- `lib/features/products`
  - `domain` – `CategoryEntity`, `ProductEntity`, `ProductRepository`, and use cases for home, search, category, and product detail.
  - `data` – `MockProductRemoteDataSource`, `ProductRepositoryImpl`, `CategoryModel`, `ProductModel`.
  - `presentation` – `ProductProvider`, `HomePage`, `ProductDetailPage`, `ProductCard`, `CategoryChip`.

- `lib/features/cart`
  - `domain` – `CartItemEntity`, `CartRepository`, and use cases: get cart, add, update quantity, remove, clear.
  - `data` – `CartItemModel`, `CartRepositoryImpl` (in-memory cart).
  - `presentation` – `CartProvider`, `CartPage`, `CartItemTile`.

- `lib/features/profile`
  - `domain` – `ProfileEntity`, `OrderEntity`, `ProfileRepository`, and use cases: get profile, get orders, reorder, cancel order.
  - `data` – `MockProfileRemoteDataSource`, `ProfileRepositoryImpl`, `OrderModel`, `ProfileModel`.
  - `presentation` – `ProfileProvider`, `ProfilePage` (header + order history + mock settings).

### Where to Integrate Your APIs

1. **Set base URL & keys**
   - Open `core/constants/app_config.dart` and set:
     - `baseUrl` – your API base URL.
     - `apiKey` – any global key/token your backend needs.
     - `useMockData` – set to `false` once you replace mock data sources with real APIs.

2. **Use the networking layer**
   - In your real data sources, create a class that uses `ApiClient` from `core/network/api_client.dart`:
     - Inject `ApiClient` (or create one per feature).
     - Call `client.get/post/...` with paths relative to `AppConfig.baseUrl`.

3. **Swap repositories (per feature)**

- **Auth**
  - Replace `MockAuthRemoteDataSource` with your HTTP/Firebase implementation.
  - Option A: Keep `AuthRepositoryImpl`, but have it call your HTTP data source instead of the mock.
  - Option B: Create `RealAuthRepositoryImpl` implementing `AuthRepository` and use it in `main.dart` instead of `AuthRepositoryImpl`.

- **Products**
  - Replace `MockProductRemoteDataSource` with an HTTP data source that hits your product endpoints.
  - Update or replace `ProductRepositoryImpl` to map JSON responses into `ProductEntity`.
  - No UI changes are required as long as you respect `ProductRepository` and existing use cases.

- **Cart**
  - `CartRepositoryImpl` is in-memory only.
  - Implement `CartRepository` to persist to local storage (e.g. Hive, SharedPreferences) or to your backend (e.g. `/cart` endpoints).
  - Swap the implementation in `main.dart` where `CartRepositoryImpl()` is currently instantiated.

- **Profile & Orders**
  - Replace `MockProfileRemoteDataSource` with calls to your profile and order history APIs.
  - Update or replace `ProfileRepositoryImpl` to map API data into `ProfileEntity` and `OrderEntity`.

### State Management

- The app uses **Provider** with `ChangeNotifier` for each feature:
  - `AuthProvider` – authentication status and current user.
  - `ProductProvider` – home/search/category/product data.
  - `CartProvider` – cart items, quantities, totals.
  - `ProfileProvider` – profile details and order history.
- Providers are registered in `main.dart` using `MultiProvider` so they are available across the app.

### Auth Flow & Navigation

- `main.dart` uses `_RootNavigator` to decide whether to show:
  - `LoginPage` when the user is not authenticated.
  - `_MainShell` (bottom navigation with Home/Cart/Profile) when authenticated.

### Notes for Buyers

- All business logic lives in **domain** + **data** layers. UI (`presentation`) is kept as thin as possible.
- To upgrade to real APIs, you typically only need to:
  1. Implement real data sources and repositories using `ApiClient`.
  2. Swap the mock implementations for your real ones in `main.dart`.
- `flutter_lints` is enabled and the project passes `flutter analyze` with **no issues**.

