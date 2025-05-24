
# 📅 LinearCalendar

A customizable, horizontally scrollable calendar widget for Flutter, built for simplicity and flexibility.

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
  linear_calendar:
    path: ../linear_calendar # or replace with your git/url or pub.dev path
````

Then run:

```bash
flutter pub get
```

---

## 🛠️ Usage

```dart
import 'package:linear_calendar/linear_calendar.dart';

class MyCalendarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearCalendar(
      startDate: DateTime(2023, 1, 1),
      onDateChanged: (selectedDate) {
        print("Selected date: $selectedDate");
      },
      selectedColor: Colors.greenAccent, // Optional
    );
  }
}
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

