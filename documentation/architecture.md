# Architecture Documentation

## 1. Macroarchitecture
The application utilizes a **Feature-first / Layered Architecture** with an emphasis on simplicity and offline-first capabilities.
Because the app is relatively small and isolated to local execution, it does not use a rigid Clean Architecture, but instead follows an MVC-inspired pattern standard to vanilla Flutter.

### Layers:
1. **Presentation Layer (`screens/`, `utils/`)**:
   - Contains UI definitions, Themes, and localization logic.
   - UI states are held directly within StatefulWidgets.
2. **Domain Layer (`models/`)**:
   - Contains pure Dart data classes (`Customer`, `AppTransaction`, `User`).
3. **Data/Service Layer (`database/`, `services/`)**:
   - `DatabaseHelper` (SQLite bindings).
   - Abstractions for Notifications, Backups, and Auth.

## 2. Microarchitecture Details

### 2.1 Repository & Singleton Patterns
- **DatabaseHelper**: Implemented as a Singleton (`DatabaseHelper.instance`). It acts as the sole Repository for fetching and mutating SQLite data. This prevents concurrent lock issues on the local database file.
  
### 2.2 Services Integration
- Separate service classes handle platform-specific implementations:
  - `NotificationService`: Wraps `flutter_local_notifications`.
  - `LocaleService`: Wraps `SharedPreferences` for localization state.
  - `AuthService`: Simple authentication abstraction.

### 2.3 Dependency Injection
- Currently, the application relies on global singletons (`DatabaseHelper.instance`, `NotificationService()`) rather than a formal Dependency Injection container (like `get_it`). This is acceptable given the limited scope, but a DI container is recommended for future scalability.

### 2.4 Error Handling
- Handled locally within asynchronous UI calls using standard `try-catch` blocks.
- Failed DB transactions roll back automatically via SQLite mechanisms.
