# Dubebook 📓

Dubebook is a fully offline mobile application designed specifically for small retail shop owners to manage informal credit systems and track customer debt with ease, accuracy, and security.

Built with **Flutter** and **SQLite**, it replaces unreliable paper notebooks with a simple, fast, and reliable digital system.

---

## 🚀 Core Features

- **🔒 Offline & Secure**: Operates 100% offline with no external APIs. Data is secured behind a user-defined password.
- **👥 Customer Management**: Quickly add customers, attach optional notes, and set payment deadlines.
- **💳 Transaction Tracking**: Record individual transactions (item, quantity, price) which automatically calculate the total debt.
- **📊 Dynamic Debt Calculation**: Total unpaid debt is calculated dynamically in real-time to prevent desyncs and errors.
- **✅ Simple Payments**: Supports one-tap full payments. Paying off a balance moves all the customer's unpaid transactions to the History view.
- **🔔 Deadline Reminders**: Leverages local notifications to alert shop owners when a customer's payment deadline arrives.
- **💾 Easy Backups**: Manual export functionality to save your database safely to your phone, Google Drive, or Email.

---

## 🎨 UI/UX Design

The application features a strictly **Light Theme** tailored for high contrast and readability. It prioritizes:
- **Minimal taps**: Core actions are easily accessible.
- **Clear Hierarchy**: The most important information (Total Debt, Customer Names) is large and prominent.
- **Fast Entry**: Number pads pop up automatically where expected.

---

## 🏗️ Architecture & Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **Local Database**: [sqflite](https://pub.dev/packages/sqflite)
- **State Management**: Standard `StatefulWidget` & `FutureBuilder` (Kept deliberately simple and maintainable without heavy external libraries)

### Folder Structure

```text
lib/
├── models/             # Data models (Customer, AppTransaction, User)
├── database/           # SQLite schema and CRUD logic (DatabaseHelper)
├── services/           # Notification, Backup, and Auth logic
├── screens/            # UI screens (Splash, Login, Dashboard, Details, etc.)
├── widgets/            # Reusable UI components
├── utils/              # AppTheme, Colors
└── main.dart           # Application entry point
```

---

## 🛠️ How to Run Locally

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed on your machine.
- An IDE with Flutter plugins (VS Code or Android Studio).
- A connected physical device or running emulator.

### Setup Steps

1. **Clone or open the project** in your terminal:
   ```bash
   cd path/to/dubebook
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the application**:
   ```bash
   flutter run
   ```

---

## 🔐 Authentication & First Launch

On the very first launch, the app will prompt you to:
1. Create a master password.
2. Answer two security questions (City of Birth & Year shop opened).

*If you forget your password, you can reset it using the "Forgot Password" flow on the login screen by answering your security questions.*

---

## 📦 Exporting Data

Go to **Settings > Export Backup** to share the raw `.db` SQLite file via your device's native share sheet. You can email it to yourself or upload it to a cloud drive for safekeeping.
