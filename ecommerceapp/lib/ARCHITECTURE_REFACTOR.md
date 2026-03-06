# Architectural Audit & Refactoring Summary

This document describes the Clean Architecture and Provider alignment applied to the **Discovery** module (Onboarding, Home, Search, Categories) and the **core** shared pieces.

---

## 1. Target Folder Structure (Strict Layers)

```
lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart      # Central strings and numeric constants
│   ├── theme/
│   │   ├── app_theme.dart          # ThemeData (existing)
│   │   └── app_colors.dart         # Shared color palette (discovery, auth, cart)
│   ├── widgets/                    # Shared UI (existing)
│   └── network/                    # API client (existing)
│
├── features/
│   ├── discovery/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   ├── banner_entity.dart
│   │   │   │   └── discovery_category_entity.dart
│   │   │   └── repositories/
│   │   │       └── discovery_repository.dart    # Abstract interface
│   │   ├── data/
│   │   │   └── repositories/
│   │   │       └── discovery_repository_impl.dart  # Implements interface; no UI dependency
│   │   └── presentation/
│   │       ├── providers/
│   │       │   ├── discovery_data_provider.dart  # Data loading (banners, categories, products)
│   │       │   ├── home_provider.dart            # Banner timer only
│   │       │   ├── search_filter_provider.dart   # Search + filter state
│   │       │   └── favorites_provider.dart
│   │       ├── pages/
│   │       │   ├── home_view.dart
│   │       │   ├── search_filter_page.dart
│   │       │   ├── category_list_page.dart
│   │       │   └── sub_category_page.dart
│   │       └── widgets/                          # (Optional) shared discovery widgets
│   │
│   ├── onboarding/
│   │   ├── data/models/
│   │   │   └── onboarding_model.dart
│   │   └── presentation/
│   │       ├── providers/onboarding_provider.dart
│   │       └── pages/onboarding_page.dart
│   │
│   ├── products/    # Existing: domain/entities, domain/repositories, data, presentation
│   ├── auth/
│   ├── cart/
│   └── profile/
```

- **Domain**: Pure Dart entities and **abstract** repository interfaces. No Flutter, no data sources.
- **Data**: Repository implementations and (where needed) data models with `fromJson`/`toJson`. All mock/API access lives here.
- **Presentation**: Providers hold state and business orchestration; widgets only call providers and read state. Colors/text from `Theme.of(context)` or `AppColors`/`AppConstants`.

---

## 2. Changes Made (What Was Refactored)

### Domain Layer (Discovery)

- **`lib/features/discovery/domain/entities/banner_entity.dart`**  
  Pure Dart: `imageUrl`, `title`, `subtitle`.
- **`lib/features/discovery/domain/entities/discovery_category_entity.dart`**  
  Holds `CategoryEntity` (from products domain) + `imageUrl`.
- **`lib/features/discovery/domain/repositories/discovery_repository.dart`**  
  Abstract interface: `getBanners()`, `getDiscoveryCategories()`, `getTrendingProducts()`, `getProductsByCategory(id)`, `searchProducts(query)`, `getProductById(id)`.  
  UI and providers depend only on this interface.

### Data Layer (Discovery)

- **`lib/features/discovery/data/repositories/discovery_repository_impl.dart`**  
  Implements `DiscoveryRepository`; uses `ProductRepository` for products/categories and adds banners/category image URLs. All “mock” logic is here. Swapping to a real API only touches this (and possibly new data sources).
- **Removed** `lib/features/discovery/data/services/mock_product_service.dart` so the app no longer depends on a concrete service; it depends on the repository interface.

### Presentation Layer (Discovery)

- **Providers**
  - **`DiscoveryDataProvider`**  
    Holds: `banners`, `discoveryCategories`, `trendingProducts`, `categoryProducts`, loading flags.  
    Methods: `loadDiscoveryHome()`, `loadProductsByCategory(id)`.  
    All discovery data loading and state live here; no logic in widgets.
  - **`HomeProvider`**  
    Only banner index and auto-scroll timer. No data source; banner count is updated from `DiscoveryDataProvider.banners.length` in the UI.
  - **`SearchFilterProvider`**  
    Holds: search query, recent searches, filter state (price, colors, sizes, rating), **search results**, **isSearching**.  
    Methods: `search(repository, query)`, `loadTrendingResults(repository)`.  
    Filtered list is computed in the provider (`filteredSearchResults`).
  - **`FavoritesProvider`**  
    Unchanged; in-memory set of favorite product IDs.

- **Pages (logic removed from widgets)**
  - **`HomeView`**  
    No local `_load()` or `_discoveryCategories`/`_trendingProducts`. Calls `DiscoveryDataProvider.loadDiscoveryHome()` once; reads `discovery.banners`, `discovery.discoveryCategories`, `discovery.trendingProducts`, `discovery.isLoadingHome`. Syncs `HomeProvider.updateBannerCount(banners.length)` when data is loaded.
  - **`SearchFilterPage`**  
    No local `_products`/`_loading` or `_loadProducts()`. Calls `SearchFilterProvider.loadTrendingResults(repository)` on init and `SearchFilterProvider.search(repository, query)` on submit; displays `filterProvider.filteredSearchResults` and `filterProvider.isSearching`.
  - **`CategoryListPage`**  
    No local `_categories`/`_loading` or `_load()`. Uses `DiscoveryDataProvider.discoveryCategories` and `isLoadingHome`; triggers `loadDiscoveryHome()` if categories are empty.
  - **`SubCategoryPage`**  
    No local `_products`/`_loading` or `_load()`. Calls `DiscoveryDataProvider.loadProductsByCategory(categoryId)` and displays `discovery.categoryProducts` and `discovery.isLoadingCategory`.

- **Theme and constants**
  - **`lib/core/constants/app_constants.dart`**  
    Central strings: e.g. `searchPlaceholder`, `sectionTrending`, `sectionCategories`, `seeAll`, `noProductsMatch`, `noProductsInCategory`, `searchTitle`, `recentSearches`, `clear`, `filters`, `priceRange`, `color`, `size`, `minimumRating`, `apply`, `categoriesTitle`, cart/auth strings.
  - **`lib/core/theme/app_colors.dart`**  
    Shared colors: `discoveryPrimary`, `discoveryPrimaryLight`, `discoveryDotInactive`, auth/cart/product/filter colors. Used instead of hardcoded hex in discovery (and can be used in auth/cart similarly).
  - Discovery pages use `Theme.of(context)` for layout/theme and `AppConstants` for copy; search filter sheet uses `AppColors.filterBeige` for the beige color.

### Provider Registration (main.dart)

- **Removed** `MockProductService` and `Provider<MockProductService>`.
- **Added** `DiscoveryRepository` and `DiscoveryRepositoryImpl(productRepository: productRepository)`.
- **Added** `Provider<DiscoveryRepository>.value(value: discoveryRepository)`.
- **Added** `ChangeNotifierProvider(DiscoveryDataProvider(repository: discoveryRepository))`.
- **Updated** `HomeProvider()` to no-args (no dependency on a service; timer only).

---

## 3. Principles Enforced

| Principle | How it’s enforced |
|-----------|-------------------|
| **Domain = core** | Discovery domain has only entities and an abstract `DiscoveryRepository`. No Flutter, no data sources. |
| **UI doesn’t depend on data sources** | Pages and providers use `DiscoveryRepository` (interface); `DiscoveryRepositoryImpl` lives in data and can be swapped for an API. |
| **No business logic in widgets** | Loading, search, filter, and list state are in `DiscoveryDataProvider` and `SearchFilterProvider`; widgets only call methods and read state. |
| **Provider at the right level** | Discovery providers are registered at app root because `HomeView` (main tab) and search/category pages need them. They could be scoped under a discovery shell if you add one later. |
| **Efficient notifyListeners** | Providers call `notifyListeners()` only after state changes (e.g. after async load or filter change), not on every frame. |
| **Theme-aware UI** | Discovery uses `Theme.of(context).colorScheme` and `textTheme`; shared strings in `AppConstants`, shared colors in `AppColors`. |

---

## 4. Optional Next Steps (Not Done in This Refactor)

- **Onboarding**: Move any hardcoded strings into `AppConstants` and colors into `AppColors`/theme if desired.
- **Auth / Cart**: Replace remaining hardcoded hex colors and strings with `AppColors` and `AppConstants` (same pattern as discovery).
- **Shared discovery widgets**: Extract repeated product card (e.g. `_ProductCard`, `_SubCategoryProductCard`, `_SearchProductCard`) into `lib/features/discovery/presentation/widgets/discovery_product_card.dart` and use theme/constants there.
- **Scoped providers**: If you add a “Discovery” shell (e.g. a tab that owns Home + Search + Categories), you can provide `DiscoveryDataProvider`, `HomeProvider`, `SearchFilterProvider`, and `FavoritesProvider` at that shell instead of in root.

---

## 5. File Summary (New / Updated / Removed)

**New**

- `lib/core/constants/app_constants.dart`
- `lib/core/theme/app_colors.dart`
- `lib/features/discovery/domain/entities/banner_entity.dart`
- `lib/features/discovery/domain/entities/discovery_category_entity.dart`
- `lib/features/discovery/domain/repositories/discovery_repository.dart`
- `lib/features/discovery/data/repositories/discovery_repository_impl.dart`
- `lib/features/discovery/presentation/providers/discovery_data_provider.dart`
- `lib/ARCHITECTURE_REFACTOR.md` (this file)

**Updated**

- `lib/features/discovery/presentation/providers/home_provider.dart` — banner timer only; no service dependency.
- `lib/features/discovery/presentation/providers/search_filter_provider.dart` — search results, `search()`, `loadTrendingResults()`, `filteredSearchResults`.
- `lib/features/discovery/presentation/pages/home_view.dart` — uses `DiscoveryDataProvider` and `HomeProvider` only; constants/theme.
- `lib/features/discovery/presentation/pages/search_filter_page.dart` — uses `SearchFilterProvider` and `DiscoveryRepository`; constants/theme.
- `lib/features/discovery/presentation/pages/category_list_page.dart` — uses `DiscoveryDataProvider` only; constants.
- `lib/features/discovery/presentation/pages/sub_category_page.dart` — uses `DiscoveryDataProvider` only; constants.
- `lib/main.dart` — discovery providers and `DiscoveryRepository` wiring.

**Removed**

- `lib/features/discovery/data/services/mock_product_service.dart` — replaced by domain repository interface + data repository implementation.
