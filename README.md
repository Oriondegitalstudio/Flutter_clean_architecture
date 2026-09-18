# Flutter Application

A scalable Flutter application built with **Clean Architecture**, **feature-based modularization**, and a clear separation between presentation, business logic, and data access.

The project is designed to remain maintainable as the application grows, while keeping features isolated, testable, and easy to extend.

---

## 📌 Overview

This application follows a **Feature-First Clean Architecture** approach.

Each major application feature is organized independently and contains its own:

* Presentation layer
* Domain layer
* Data layer

Shared application infrastructure is centralized inside the `core` directory.

### Architecture Overview

```text
Flutter Application
│
├── Core
│   ├── Constants
│   ├── Error Handling
│   ├── Network
│   ├── Dependency Injection
│   ├── Routing
│   ├── Theme
│   ├── Utilities
│   └── Shared Widgets
│
├── Features
│   ├── Authentication
│   ├── Home
│   └── Profile
│
└── Application Entry Point
    └── main.dart
```

---

## 🛠️ Tech Stack

### Framework

* Flutter
* Dart

### Architecture

* Clean Architecture
* Feature-Based Architecture
* Repository Pattern
* Dependency Injection

### State Management

* BLoC / Cubit

### Networking

* Dio

### Dependency Injection

* GetIt

### Navigation

* GoRouter

### Local Storage

* SharedPreferences

### Testing

* Flutter Test
* Unit Testing
* Widget Testing
* Integration Testing

> Packages are introduced only when they provide a clear architectural or functional benefit.

---

## 📂 Project Structure

```text
project/
│
├── android/
├── ios/
│
├── assets/
│   ├── images/
│   ├── icons/
│   ├── fonts/
│   └── translations/
│
├── lib/
│   │
│   ├── core/
│   │   ├── constants/
│   │   ├── di/
│   │   ├── error/
│   │   ├── network/
│   │   ├── routes/
│   │   ├── theme/
│   │   ├── utils/
│   │   └── widgets/
│   │
│   ├── features/
│   │   ├── auth/
│   │   ├── home/
│   │   └── profile/
│   │
│   └── main.dart
│
├── test/
│
├── .gitignore
├── analysis_options.yaml
├── pubspec.yaml
└── README.md
```

---

## 🧱 Architecture

The application follows three main Clean Architecture layers.

```text
Presentation
      │
      ▼
   Domain
      │
      ▼
    Data
      │
      ▼
 External Services
```

### Presentation

Responsible for:

* Screens
* UI components
* User interactions
* Cubit
* Presentation states

The presentation layer should not communicate directly with APIs or databases.

---

### Domain

Responsible for:

* Business rules
* Entities
* Repository contracts
* Use cases

The domain layer should remain independent from Flutter UI and external infrastructure.

---

### Data

Responsible for:

* API communication
* Local data sources
* Models
* Repository implementations
* Data transformation

The data layer communicates with external systems and converts external data into domain entities.

---

## 🔄 Application Flow

A typical API operation follows this flow:

```text
User Interaction
      │
      ▼
    Page
      │
      ▼
 BLoC / Cubit
      │
      ▼
   Use Case
      │
      ▼
 Repository
      │
      ▼
Repository Implementation
      │
      ▼
 Remote Data Source
      │
      ▼
    API
```

For example:

```text
LoginPage
    ↓
AuthCubit
    ↓
LoginUseCase
    ↓
AuthRepository
    ↓
AuthRepositoryImpl
    ↓
AuthRemoteDataSource
    ↓
API
```

---

## 🚀 Getting Started

### Prerequisites

Install:

* Flutter SDK
* Dart SDK
* Android SDK
* VS Code
* Flutter and Dart VS Code extensions

Verify Flutter:

```bash
flutter doctor
```

Check available devices:

```bash
flutter devices
```

---

## 📥 Installation

Clone the repository:

```bash
git clone <repository-url>
```

Navigate into the project:

```bash
cd <project-name>
```

Install dependencies:

```bash
flutter pub get
```

---

## ▶️ Running the Application

Start an Android emulator or connect a physical Android device.

Then run:

```bash
flutter run
```

Or open the project in VS Code and press:

```text
F5
```

---

## 🧪 Testing

Run all tests:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

Format the project:

```bash
dart format .
```

---

## 🔐 Environment Configuration

Environment-specific configuration should not be hardcoded into feature implementations.

Examples include:

* API base URLs
* Authentication configuration
* Environment-specific settings
* Application secrets

Sensitive values must never be committed to Git.

---

## 🌍 Assets

Application assets are stored outside `lib`:

```text
assets/
├── images/
├── icons/
├── fonts/
└── translations/
```

Assets are registered in `pubspec.yaml`.

Example:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/icons/
```

---

## 🌿 Git Workflow

The project follows a feature-oriented Git workflow.

Example:

```text
main
  │
  └── develop
        │
        ├── feature/authentication
        ├── feature/home
        └── feature/profile
```

Feature branches should be created from `develop`.

Example:

```bash
git checkout develop
git pull
git checkout -b feature/authentication
```

---

## 📏 Development Principles

The project follows these principles:

* Keep features isolated.
* Keep business logic outside the UI.
* Keep API implementation inside the data layer.
* Prefer interfaces over direct implementations.
* Avoid unnecessary dependencies.
* Avoid duplicated logic.
* Keep reusable components inside `core` only when they are truly shared.
* Keep feature-specific components inside their feature.
* Keep domain logic independent from external frameworks.
* Write testable code.
* Prefer explicit types over `dynamic` and `Object` where possible.

---

## 📚 Documentation

Architecture documentation:

```text
lib/features/README.md
```

Feature-specific documentation should be maintained alongside the feature when necessary.

---

## 📄 License

This project is private unless otherwise specified.
