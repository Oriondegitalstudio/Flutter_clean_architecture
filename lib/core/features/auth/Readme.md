# Features Architecture

The `features` directory contains the application's business features.

Each feature is **self-contained** and follows the same Clean Architecture structure:

```text
feature/
├── data/
├── domain/
└── presentation/
```

This approach keeps features isolated and prevents the application from becoming a large collection of unrelated files.

---

## 📂 Feature Structure

Example:

```text
features/
│
├── auth/
│   ├── data/
│   ├── domain/
│   └── presentation/
│
├── home/
│   ├── data/
│   ├── domain/
│   └── presentation/
│
└── profile/
    ├── data/
    ├── domain/
    └── presentation/
```

---

# 🧱 Feature Layers

Each feature is divided into three layers.

```text
┌─────────────────────────┐
│      Presentation       │
│   UI + State Management │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│         Domain          │
│ Business Logic + Rules  │
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│          Data           │
│ API + Local Data        │
└─────────────────────────┘
```

---

# 1. Presentation Layer

The presentation layer contains everything related to the application's user interface and presentation state.

```text
presentation/
├── pages/
├── widgets/
└── bloc/
```

Depending on the feature, the state management directory may contain either BLoC or Cubit implementations.

### Responsibilities

* Display UI
* Handle user interactions
* Manage presentation state
* Trigger use cases
* Display loading states
* Display success states
* Display error states

### Example

```text
presentation/
├── pages/
│   ├── login_page.dart
│   └── register_page.dart
│
├── widgets/
│   ├── login_form.dart
│   └── auth_header.dart
│
└── bloc/
    └── auth_bloc.dart
```

### Important Rule

Presentation must **not** call the API directly.

Avoid:

```text
Page
  ↓
Dio
  ↓
API
```

Use:

```text
Page
  ↓
BLoC / Cubit
  ↓
Use Case
  ↓
Repository
```

---

# 2. Domain Layer

The domain layer contains the core business logic of the feature.

```text
domain/
├── entities/
├── repositories/
└── usecases/
```

The domain layer should have no dependency on:

* Flutter UI
* Dio
* HTTP clients
* API response formats
* Database implementations
* Remote data sources

---

## Entities

Entities represent the application's core business objects.

Example:

```text
domain/
└── entities/
    └── user.dart
```

Example concept:

```dart
class User {
  final String id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });
}
```

An entity represents what the application needs to know about an object, not how that object was retrieved.

---

## Repository Contracts

Repositories inside the domain layer define what the application needs from data sources.

Example:

```text
domain/
└── repositories/
    └── auth_repository.dart
```

Example:

```dart
abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });

  Future<User> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();
}
```

The domain defines the contract.

The data layer provides the implementation.

---

## Use Cases

Use cases represent actions or business operations.

Examples:

```text
usecases/
├── login.dart
├── register.dart
└── logout.dart
```

A use case should generally represent one meaningful operation.

Examples:

```text
Login
Register
Logout
GetProducts
GetProductDetails
AddToCart
RemoveFromCart
Checkout
UpdateProfile
```

---

# 3. Data Layer

The data layer handles external data sources.

```text
data/
├── datasources/
├── models/
└── repositories/
```

---

## Data Sources

Data sources communicate with external systems.

```text
datasources/
├── auth_remote_datasource.dart
└── auth_local_datasource.dart
```

### Remote Data Source

Responsible for:

* REST APIs
* HTTP requests
* Remote services

Example:

```text
AuthRemoteDataSource
        ↓
      Dio
        ↓
      API
```

### Local Data Source

Responsible for:

* Local storage
* Cached data
* Device persistence

The exact implementation depends on the application's requirements.

---

# 4. Models

Models represent external data formats.

```text
models/
├── user_model.dart
└── auth_response_model.dart
```

Models can handle:

* JSON serialization
* JSON deserialization
* API-specific fields
* Data conversion

Example:

```dart
factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    id: json['id'].toString(),
    name: json['name'],
    email: json['email'],
  );
}
```

Models should be converted into domain entities before business logic consumes them.

```text
API Response
     ↓
UserModel
     ↓
User Entity
```

---

# 5. Repository Implementation

The repository implementation connects the domain layer to the data layer.

```text
data/
└── repositories/
    └── auth_repository_impl.dart
```

Example flow:

```text
Use Case
    ↓
AuthRepository
    ↓
AuthRepositoryImpl
    ↓
AuthRemoteDataSource
```

The domain knows only:

```dart
AuthRepository
```

The domain does not need to know that the implementation uses:

```text
Dio
REST API
SharedPreferences
SQLite
Firebase
```

This keeps the domain independent.

---

# 🔄 Complete Feature Flow

A complete feature operation follows this pattern:

```text
┌──────────────┐
│     Page     │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ BLoC / Cubit │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│   Use Case   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│  Repository  │
└──────┬───────┘
       │
       ▼
┌──────────────────────┐
│ Repository Impl      │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│    Data Source       │
└──────────┬───────────┘
           │
           ▼
┌──────────────────────┐
│       API / DB       │
└──────────────────────┘
```

---

# 📋 Dependency Direction

The dependency direction should remain controlled:

```text
Presentation
     │
     ▼
 Domain
     ▲
     │
   Data
```

More specifically:

```text
Presentation → Domain
Data → Domain
```

The domain should not depend on presentation or concrete data implementations.

---

# 📦 Example: Authentication Feature

```text
auth/
│
├── data/
│   ├── datasources/
│   │   ├── auth_remote_datasource.dart
│   │   └── auth_local_datasource.dart
│   │
│   ├── models/
│   │   ├── user_model.dart
│   │   └── auth_response_model.dart
│   │
│   └── repositories/
│       └── auth_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── user.dart
│   │
│   ├── repositories/
│   │   └── auth_repository.dart
│   │
│   └── usecases/
│       ├── login.dart
│       ├── register.dart
│       └── logout.dart
│
└── presentation/
    ├── pages/
    │   ├── login_page.dart
    │   └── register_page.dart
    │
    ├── widgets/
    │   ├── login_form.dart
    │   └── auth_header.dart
    │
    └── bloc/
        └── auth_bloc.dart
```

---

# 🧭 Rules for Adding a New Feature

When creating a new feature:

### Step 1 — Create the feature

```text
features/
└── products/
```

### Step 2 — Create the three layers

```text
products/
├── data/
├── domain/
└── presentation/
```

### Step 3 — Define the domain

Create:

```text
entities/
repositories/
usecases/
```

### Step 4 — Implement the data layer

Create:

```text
datasources/
models/
repositories/
```

### Step 5 — Build the presentation

Create:

```text
pages/
widgets/
bloc/
```

### Step 6 — Register dependencies

Add the feature's dependencies to the application's dependency injection setup.

### Step 7 — Connect routing

Register feature routes in the application's router.

---

# 🧠 Shared vs Feature-Specific Code

Not everything belongs inside `core`.

### Put code in `core/` when:

* Multiple features use it.
* It has no specific business ownership.
* It represents application-wide infrastructure.

Examples:

```text
API Client
App Theme
Router
Global Error Handling
Reusable Button
Reusable Text Field
Validators
Constants
```

### Keep code inside a feature when:

* It only belongs to that feature.
* It contains feature-specific business rules.
* Moving it to `core` would create unnecessary coupling.

For example:

```text
auth/
└── presentation/
    └── widgets/
        └── password_strength_indicator.dart
```

should remain inside `auth` if only authentication uses it.

---

# 🚫 Anti-Patterns

Avoid:

```text
Page → API
```

Avoid:

```text
Widget → Repository Implementation
```

Avoid:

```text
Domain → Dio
```

Avoid putting everything into:

```text
core/
```

Avoid creating a global:

```text
widgets/
services/
models/
screens/
```

directory that becomes a dumping ground for unrelated functionality.

---

# 🎯 Goal

The objective of this architecture is not to create more folders.

The objective is to achieve:

* Separation of concerns
* Testability
* Maintainability
* Feature isolation
* Replaceable infrastructure
* Clear business logic
* Easier team collaboration
* Long-term scalability

A feature should be understandable without having to inspect the entire application.

```text
One Feature
    ↓
Presentation
    ↓
Domain
    ↓
Data
```

Keep the boundaries clear, keep dependencies intentional, and let the application grow without turning the `lib/` folder into organized chaos.
