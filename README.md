# Flutter Starter Template (MVVM + GoRouter)

A lightweight starter showcasing how we wire **Flutter + MVVM** with multi-target
entry points, dependency injection via `provider`, and navigation handled by
`go_router`. It ships with an auth gate, a posts flow backed by
JSONPlaceholder, localization hooks, and both local and remote data providers.

> 📘 **Official MVVM / Flutter Architecture Doc:**  
> https://docs.flutter.dev/app-architecture
>
> 🧭 **Reference Sample (`compass_app`):**  
> https://github.com/flutter/samples/tree/main/compass_app

---

## 🚀 Overview

This template keeps things intentionally small but production-friendly:

- Clean MVVM slices (`ui/` widgets → `viewmodel/` classes → `domain/data`)
- Two dependency graphs (`providersLocal`, `providersRemote`) you can swap per
  environment
- DI is split into feature modules (`di/modules/*`) so every new slice wires up
  its providers in isolation
- Environment-specific entry points (`main_development.dart`, `main_staging.dart`)
- `go_router` setup with auth-aware redirection
- Sample service/repository stack hitting JSONPlaceholder (or local fixtures)
- Localized `MaterialApp` with light/dark themes out of the box

---

## 📁 Project Structure

```
lib/
  main.dart                      # default entry (currently staging)
  main_development.dart          # local data / dev target
  main_staging.dart              # remote data / staging target
  app.dart                       # root widget + router bootstrap
  config/
    assets.dart
  di/
    dependencies.dart            # composes modules below
    modules/
      auth_module.dart           # auth repository providers
      post_module.dart           # service + repo + use cases
  data/
    repositories/                # auth + posts implementations
    services/                    # API/platform adapters
  domain/
    models/                      # freezed/json-serializable data
    use_cases/                   # business actions (e.g. FetchPostsUseCase)
  routing/
    router.dart, routes.dart     # go_router config + guards
  ui/
    auth/, posts/, core/         # views + viewmodels + shared widgets
  utils/
    example_util.dart
```

Views stay declarative, view models own state, and repositories/services deal
with data sources.

---

## 🧩 Example Pattern

`PostsViewModel` (used by the posts screen) stays Flutter-import free except for
`ChangeNotifier`, exposes immutable getters, and notifies the UI when async work
completes:

```6:33:lib/ui/posts/viewmodel/posts_view_model.dart
class PostsViewModel extends ChangeNotifier {
  PostsViewModel({required FetchPostsUseCase fetchPostsUseCase})
    : _fetchPostsUseCase = fetchPostsUseCase;

  Future<void> loadPosts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _posts = await _fetchPostsUseCase.execute();
    } catch (error, stackTrace) {
      _error = 'Something went wrong.';
      debugPrint('Failed to load posts: $error\n$stackTrace');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

Screens simply listen to the view model and rebuild with `context.watch`.

---

## 🌱 Environments & Targets

| Target | Command | Notes |
| --- | --- | --- |
| Development (local data) | `flutter run --target lib/main_development.dart` | Uses in-memory auth + `PostServiceLocal` fixtures for offline work. |
| Staging (remote data) | `flutter run --target lib/main_staging.dart` | Hits JSONPlaceholder via `http` and uses the remote auth stub. |
| Default | `flutter run` | Delegates to `lib/main_staging.dart` today; adjust `main.dart` as needed. |

Switching environments automatically swaps the provider graph defined in
`di/dependencies.dart`, which in turn composes feature modules inside
`di/modules/`. Add a new module per feature to keep wiring maintainable.

---

## 🧱 Dependency Modules

- `di/dependencies.dart` exports `providersLocal` and `providersRemote`.
- Each feature owns a module file inside `di/modules/` (e.g. `auth_module.dart`,
  `post_module.dart`) that returns a `List<SingleChildWidget>`.
- Local vs remote bindings are explicit, so adding a new datasource means
  updating only that feature’s module.

Example addition workflow:
1. Create `di/modules/feature_module.dart` exposing `featureLocalModule()` and
   `featureRemoteModule()`.
2. Append those lists to `providersLocal` / `providersRemote`.
3. Import the view models/repositories normally—no global DI file edits needed.

---

## ▶️ Running

```bash
flutter pub get
flutter run --target lib/main_development.dart  # or main_staging.dart
```

Want to verify routing/auth manually? Start the app, toggle auth state via the
login screen, and watch `go_router` redirect between `/login` and `/posts`.

---

## ✅ Testing & Tooling

- `flutter test` – unit/widget tests (see `test/example_util_test.dart`)
- `dart run build_runner build --delete-conflicting-outputs` – generate freezed
  models / JSON code once you add new ones
- `flutter format . && flutter analyze` – keep the repo lint-clean

---

## 🧭 Inspiration & Next Steps

The repo mirrors the spirit of the official Flutter samples: small, readable,
and focused on separation of concerns. Extend it by adding more routes, swapping
the remote service for your API, or layering persistence (e.g. Hive/Drift) under
`data/repositories/`.

Happy building! 🚀

