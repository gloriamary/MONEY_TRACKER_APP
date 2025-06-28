# 💰 Money Tracker App

A simple and clean Flutter app to manage and display income and expense transactions. Users can add, edit, and delete transactions in real-time using `ValueNotifier` and stateless widgets for performance.

---

## 🚀 Features

- Add income or expense transactions
- Edit transaction narration and type
- Confirm before deleting a transaction
- Real-time UI updates with `ValueNotifier`
- Clean, minimal design using Stateless Widgets

---

## 📱 UI Overview

- **FloatingActionButton** to add transactions
- **ListTile** view to display all transactions
- **AlertDialog** with form validation for adding/editing
- Delete confirmation dialog before removal

---

## 🧱 Built With

- Flutter
- Dart
- Material UI Components
- `ValueNotifier` for simple state management

---

## 📂 Folder Structure

```
lib/
├── model/
│   └── transaction_model.dart     # Transaction data model
├── home_screen.dart              # Main UI screen
└── main.dart                     # App entry point
```

---

## 🔧 Getting Started

1. **Clone this repo**
   ```bash
   git clone https://github.com/your-username/flutter_money_tracker.git
   cd flutter_money_tracker
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## 📌 To Do

- [ ] Add local storage (Hive or SharedPreferences)
- [ ] Add filters (Income/Expense)
- [ ] Add balance summary widget
- [ ] Export transaction list

---

## 📄 License

This project is licensed under the MIT License.

---

> Created with ❤️ using Flutter and Dart
