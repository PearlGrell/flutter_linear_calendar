
# 📅 LinearCalendar

A customizable, horizontally scrollable calendar widget for Flutter, built for simplicity and flexibility.

---

## 📸 Screenshots

To limit the **display size** of screenshots in your `README.md`, you can use HTML `<img>` tags instead of Markdown `![alt](url)` syntax. This allows you to control the width for a cleaner and more consistent layout.

Here’s your updated section with **size-limited images**:

---

## 📸 Screenshots

### 🔹 Default Usage

```dart
LinearCalendar(
  startDate: DateTime.now(),
  onDateChanged: (date) {
    debugPrint('Selected date: $date');
  },
)
```

<p align="center">
  <img src="https://github.com/PearlGrell/flutter_linear_calendar/blob/main/screenshots/screenshot.png?raw=true" alt="Linear Calendar Screenshot" width="300"/>
</p>

---

### 🔸 Customized Style

```dart
LinearCalendar(
  startDate: DateTime(2025, 5, 15),
  selectedColor: Colors.deepPurple,
  unselectedColor: Colors.grey,
  foregroundColor: Colors.white,
  onDateChanged: (date) {
    debugPrint('Selected date: $date');
  },
)
```

<p align="center">
  <img src="https://github.com/PearlGrell/flutter_linear_calendar/blob/main/screenshots/screenshot2.png?raw=true" alt="Linear Calendar Screenshot 2" width="300"/>
</p>

---

### 🔸 Customized Style

```dart
LinearCalendar(
  startDate: DateTime(2025, 5, 15),
  selectedColor: Colors.deepPurple,
  unselectedColor: Colors.grey,
  foregroundColor: Colors.white,
  onDateChanged: (date) {
    debugPrint('Selected date: $date');
  },
)
```

<p align="center">
  <img src="https://github.com/PearlGrell/flutter_linear_calendar/blob/main/screenshots/screenshot2.png?raw=true" alt="Linear Calendar Screenshot 2" width="600"/>
</p>

---

## ✨ Features

- Horizontal scrolling calendar view
- Highlights today's date
- Customizable selection color
- Callback on date selection
- Lightweight and easy to integrate

---

## 🚀 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  linear_calendar: ^0.0.3
````

Then run:

```bash
flutter pub get
```

---

## 🧩 Parameters

| Property           | Type                     | Required | Description                                       |
| ------------------ | ------------------------ | -------- | ------------------------------------------------- |
| `startDate`        | `DateTime`               | ✅        | Start of the calendar range                       |
| `endDate`          | `DateTime?`              | ❌        | End of the calendar range (defaults to 30 days ahead) |
| `onDateChanged`    | `ValueChanged<DateTime>` | ✅        | Called when a date is selected                    |
| `selectedColor`    | `Color?`                 | ❌        | Background color for the selected date            |
| `unselectedColor`  | `Color?`                 | ❌        | Background color for unselected dates             |
| `foregroundColor`  | `Color?`                 | ❌        | Text color for the dates                          |
| `scrollController` | `ScrollController?`      | ❌        | Custom scroll controller for the calendar         |

---

## 🧪 Example

```dart
LinearCalendar(
  startDate: DateTime.now().subtract(Duration(days: 15)),
  endDate: DateTime.now().add(Duration(days: 30)),
  selectedColor: Colors.blueAccent,
  unselectedColor: Colors.grey[200],
  foregroundColor: Colors.black,
  onDateChanged: (date) => debugPrint("Date tapped: $date"),
)
```

---

## 🔖 License

[MIT](LICENSE)

---

## 👤 Author

Developed by [PearlGrell](https://github.com/pearlgrell)

