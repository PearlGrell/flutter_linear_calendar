## [2.0.2] - 2025-06-17

### Fixed
- Updated the documentation.

## [2.0.0] - 2025-06-17

### Added
- `initialSelectedDate`: Lets you pre-select any date in the visible range.
- `daysBeforeToday` / `daysAfterToday`: Simplified API for dynamic date range generation.
- `locale`: Supports internationalized month and weekday formats.
- `onLongPress`: Callback when a date is long-pressed.
- `dateBuilder`: Custom builder for full visual control of date tiles.
- Automatic scroll to `initialSelectedDate` or today's date.
- Haptic feedback on date selection for improved UX.
- Today’s date marker: a subtle dot shown under the current day.
- Right-to-left layout support via `Directionality`.

### Changed
- Refactored internals for easier state handling and readability.
- Improved tap handling logic and restored selection animations.
- Improved theming defaults for better integration with dark/light themes.

## [1.0.1] - 2025-05-30

### Fixed
- Fixed minor formatting issues in the documentation.

## [1.0.0] - 2025-05-24

### Release
- Finalized the `LinearCalendar` widget package.
- Ensured all features are stable and well-documented.
- Updated `CHANGELOG.md` to reflect the final version.
