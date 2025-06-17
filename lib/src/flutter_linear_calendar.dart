import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LinearCalendar extends StatefulWidget {
  /// A horizontal calendar widget that displays a range of dates.
  /// /// Allows selection of a date, with options for custom styling and behavior.
  const LinearCalendar({
    super.key,
    required this.onDateChanged,
    this.initialSelectedDate,
    this.startDate,
    this.endDate,
    this.daysBeforeToday = 0,
    this.daysAfterToday = 30,
    this.selectedColor,
    this.scrollController,
    this.foregroundColor,
    this.unselectedColor,
    this.onLongPress,
    this.dateBuilder,
    this.locale,
    this.rangeSelection = false,
  });

  /// The start date of the calendar range.
  /// If null, defaults to today minus [daysBeforeToday].
  final DateTime? startDate;

  /// The end date of the calendar range.
  /// If null, defaults to today plus [daysAfterToday].
  final DateTime? endDate;

  /// The number of days before today to include in the calendar.
  /// Defaults to 0.
  /// This is used to calculate the start date if [startDate] is not provided.
  final int daysBeforeToday;

  /// The number of days after today to include in the calendar.
  /// Defaults to 30.
  /// This is used to calculate the end date if [endDate] is not provided.
  final int daysAfterToday;

  /// The initial selected date in the calendar.
  /// If null, defaults to today.
  /// This date will be scrolled into view when the calendar is first displayed.
  final DateTime? initialSelectedDate;

  /// Callback function that is called when a date is selected.
  /// It receives the selected date as a parameter.
  /// This function is required and must be provided by the user.
  /// It is called whenever a date is tapped in the calendar.
  final ValueChanged<DateTime> onDateChanged;

  /// Optional color for the selected date.
  /// If null, defaults to a light green color.
  /// This color is used to highlight the selected date in the calendar.
  /// It is applied to the background of the selected date cell.
  final Color? selectedColor;

  /// Optional color for unselected dates.
  /// If null, defaults to transparent.
  /// This color is used for dates that are not selected.
  /// It is applied to the background of unselected date cells.
  final Color? unselectedColor;

  /// Optional color for the text and icons in the calendar.
  /// If null, defaults to the onPrimaryContainer color from the current theme.
  /// This color is used for the text and icons in the date cells.
  /// It is applied to the foreground elements of the date cells.
  final Color? foregroundColor;

  /// Optional scroll controller for the calendar.
  /// If null, a new ScrollController will be created.
  /// This allows the user to control the scrolling behavior of the calendar.
  /// It can be used to programmatically scroll to a specific date or position.
  final ScrollController? scrollController;

  /// Optional builder function for customizing the appearance of each date cell.
  /// If null, a default date cell layout will be used.
  /// This function receives the context, date, and whether the date is selected,
  /// and should return a widget that represents the date cell.
  final Widget Function(BuildContext, DateTime, bool)? dateBuilder;

  /// Optional callback function that is called when a date is long-pressed.
  /// It receives the long-pressed date as a parameter.
  /// This function is optional and can be used to implement custom behavior
  /// when a date is long-pressed in the calendar.
  /// It is useful for showing additional information or options related to the date.
  /// If not provided, long-press functionality will not be available.
  /// This can be used to implement custom actions or show additional information related to the date.
  final void Function(DateTime)? onLongPress;

  /// Optional locale for formatting dates.
  /// If null, the current locale of the app will be used.
  /// This allows the calendar to display dates in the correct format based on the user's locale.
  /// It is used to format the month and day names in the date cells.
  /// This is useful for internationalization and localization of the calendar.
  final Locale? locale;

  /// Whether to enable range selection.
  /// If true, allows selecting a range of dates.
  /// This feature is currently not implemented,
  /// but can be used in the future to allow users to select multiple dates at once.
  /// Defaults to false.
  final bool rangeSelection;

  @override
  State<LinearCalendar> createState() => _LinearCalendarState();
}

class _LinearCalendarState extends State<LinearCalendar> {
  /// State for the LinearCalendar widget.
  /// Manages the list of dates, selected date, and scrolling behavior.
  late final ScrollController _scrollController;

  /// List of dates to display in the calendar.
  /// Contains all dates from startDate to endDate.
  /// The selected date in the calendar.
  final List<DateTime> _dateList = [];

  /// The currently selected date.
  /// If null, no date is selected.
  DateTime? _selectedDate;

  late final DateTime _startDate;
  late final DateTime _endDate;

  /// Initializes the state of the LinearCalendar.
  /// Sets up the scroll controller and generates the list of dates.
  /// Scrolls to the initially selected date after the first frame is rendered.
  /// This method is called once when the widget is inserted into the widget tree.
  /// It initializes the scroll controller, calculates the start and end dates based on the provided parameters,
  /// and generates the list of dates to display in the calendar.
  /// It also scrolls to the initially selected date if provided.
  ///
  /// @param widget The LinearCalendar widget that this state belongs to.
  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
    final today = DateTime.now();
    _startDate =
        widget.startDate ??
        today.subtract(Duration(days: widget.daysBeforeToday));
    _endDate =
        widget.endDate ?? today.add(Duration(days: widget.daysAfterToday));
    _selectedDate = widget.initialSelectedDate ?? today;
    _generateDateList();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollToDate(_selectedDate),
    );
  }

  void _generateDateList() {
    _dateList.clear();
    for (
      DateTime date = _startDate;
      !date.isAfter(_endDate);
      date = date.add(const Duration(days: 1))
    ) {
      _dateList.add(date);
    }
  }

  void _scrollToDate(DateTime? targetDate) {
    if (targetDate == null) return;
    final index = _dateList.indexWhere((d) => _isSameDay(d, targetDate));
    if (index != -1) {
      final offset = index * 76;
      _scrollController.animateTo(
        offset.toDouble(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final selectedColor =
        widget.selectedColor ?? const Color.fromARGB(255, 212, 245, 82);
    final unselectedColor = widget.unselectedColor ?? Colors.transparent;
    final foregroundColor =
        widget.foregroundColor ?? colorScheme.onPrimaryContainer;
    final foregroundColorFaint = foregroundColor.withAlpha(195);
    final borderColor = foregroundColor.withAlpha(125);

    final locale =
        widget.locale?.toString() ?? Localizations.localeOf(context).toString();

    return Directionality(
      textDirection: Directionality.of(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          height: 86,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: _dateList.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final date = _dateList[index];
              final isSelected =
                  _selectedDate != null && _isSameDay(date, _selectedDate!);
              final isToday = _isSameDay(date, DateTime.now());

              final dateCell =
                  widget.dateBuilder?.call(context, date, isSelected) ??
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    decoration: BoxDecoration(
                      color: isSelected ? selectedColor : unselectedColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: borderColor, width: 0.75),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat.MMM(locale).format(date),
                          style: textTheme.bodyMedium?.copyWith(
                            color: foregroundColorFaint,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontSize: 19,
                            height: 1.2,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.bold,
                            color: foregroundColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Text(
                              DateFormat.E(locale).format(date),
                              style: textTheme.bodySmall?.copyWith(
                                color: foregroundColorFaint,
                              ),
                            ),
                            if (isToday)
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: foregroundColorFaint,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  );

              return AspectRatio(
                aspectRatio: 0.7,
                child: InkWell(
                  onTap: () {
                    HapticFeedback.selectionClick();
                    setState(() => _selectedDate = date);
                    widget.onDateChanged(date);
                  },
                  onLongPress: () => widget.onLongPress?.call(date),
                  borderRadius: BorderRadius.circular(8),
                  child: dateCell,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
