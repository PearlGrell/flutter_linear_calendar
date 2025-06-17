# 📅 LinearCalendar

A flexible, horizontally scrollable calendar widget for Flutter, designed for simplicity, extensibility, and visual clarity.

---

## 📸 Screenshots

### 🔹 Default Usage

```dart
LinearCalendar(
  onDateChanged: (date) {
    debugPrint('Selected date: $date');
  },
)
````

<p align="center">
  <img src="https://github.com/PearlGrell/flutter_linear_calendar/blob/main/screenshots/screenshot.png?raw=true" width="300"/>
</p>

---

### 🔸 Customized Style

```dart
LinearCalendar(
  initialSelectedDate: DateTime(2025, 5, 15),
  selectedColor: Colors.deepPurple,
  unselectedColor: Colors.grey,
  foregroundColor: Colors.white,
  onDateChanged: (date) {
    debugPrint('Selected date: $date');
  },
)
```

<p align="center">
  <img src="https://github.com/PearlGrell/flutter_linear_calendar/blob/main/screenshots/screenshot2.png?raw=true" width="300"/>
</p>

---

## ✨ Features

* 🔄 Horizontally scrollable calendar
* 📍 Auto-scrolls to today or selected date
* 🎨 Fully customizable colors and builders
* 🗓 Locale support and internationalization
* 🕹 Long-press interaction support
* 📱 Haptic feedback on selection
* 🎯 Highlights today’s date with a dot
* 🔁 Works with `ScrollController` and RTL layout
* 🧩 Supports dynamic date ranges (before/after today)
* 🧠 Ready for state restoration logic

---

## 🚀 Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_linear_calendar: ^2.0.0
```

Then run:

```bash
flutter pub get
```

---

## ⚙️ Parameters

| Property              | Type                      | Required | Description                                                         |
| --------------------- | ------------------------- | -------- | ------------------------------------------------------------------- |
| `onDateChanged`       | `ValueChanged<DateTime>`  | ✅        | Called when a date is selected                                      |
| `startDate`           | `DateTime?`               | ❌        | Start of the calendar range (defaults to today - `daysBeforeToday`) |
| `endDate`             | `DateTime?`               | ❌        | End of the calendar range (defaults to today + `daysAfterToday`)    |
| `daysBeforeToday`     | `int`                     | ❌        | Dynamic generation: number of days before today (default: 0)        |
| `daysAfterToday`      | `int`                     | ❌        | Dynamic generation: number of days after today (default: 30)        |
| `initialSelectedDate` | `DateTime?`               | ❌        | Initially selected date (default: today)                            |
| `selectedColor`       | `Color?`                  | ❌        | Background color for selected date                                  |
| `unselectedColor`     | `Color?`                  | ❌        | Background color for unselected dates                               |
| `foregroundColor`     | `Color?`                  | ❌        | Text and indicator color                                            |
| `scrollController`    | `ScrollController?`       | ❌        | Custom scroll controller                                            |
| `locale`              | `Locale?`                 | ❌        | Use for custom month/day formatting                                 |
| `onLongPress`         | `ValueChanged<DateTime>?` | ❌        | Callback when a date is long-pressed                                |
| `dateBuilder`         | `Widget Function(...)`    | ❌        | Provide a custom widget for each date cell                          |
| `rangeSelection`      | `bool`                    | ❌        | Placeholder for future multi-date selection support                 |

---

## 🧪 Example

```dart
LinearCalendar(
  initialSelectedDate: DateTime.now(),
  daysBeforeToday: 10,
  daysAfterToday: 20,
  selectedColor: Colors.teal,
  unselectedColor: Colors.teal.withOpacity(0.2),
  foregroundColor: Colors.black,
  locale: const Locale('en'),
  onDateChanged: (date) => debugPrint("Selected: $date"),
  onLongPress: (date) => debugPrint("Long-pressed: $date"),
  dateBuilder: (context, date, isSelected) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.amber : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        DateFormat('EEE\nd', 'en').format(date),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  },
)
```

---

## 🧠 Tips

* You can dynamically control the range via `daysBeforeToday` and `daysAfterToday` without needing to manually pass `startDate`/`endDate`.
* To highlight **today**, a subtle dot is shown under the day name.
* Use `ScrollController` to programmatically scroll or attach scroll behaviors.
* Use `locale` to support non-English months/days (e.g., Arabic, French).

---

## 🔖 License

This package is distributed under the MIT license. See [LICENSE](LICENSE) for more information.

---

## 👤 Author

Developed with ❤️ by [PearlGrell](https://github.com/pearlgrell)