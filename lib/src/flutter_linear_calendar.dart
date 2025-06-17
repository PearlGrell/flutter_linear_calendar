import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LinearCalendar extends StatefulWidget {
  /// A horizontal calendar widget that displays a range of dates.
  /// /// Allows selection of a date, with options for custom styling and behavior.
  /// /// [onDateChanged] is called when a date is selected.
  /// /// [initialSelectedDate] sets the initially selected date.
  /// /// [startDate] and [endDate] define the range of dates displayed.
  /// /// [daysBeforeToday] and [daysAfterToday] specify how many days before and after today to display.
  /// /// [selectedColor] sets the background color for the selected date.
  /// /// [unselectedColor] sets the background color for unselected dates.
  /// /// [foregroundColor] sets the text color for the date labels.
  /// /// [scrollController] allows for custom scrolling behavior.
  /// /// [dateBuilder] allows for custom date cell widgets.
  /// /// [onLongPress] is called when a date cell is long-pressed.
  /// /// [locale] sets the locale for date formatting.
  /// /// [rangeSelection] enables range selection mode, allowing multiple dates to be selected.
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

  final DateTime? startDate;
  final DateTime? endDate;
  final int daysBeforeToday;
  final int daysAfterToday;
  final DateTime? initialSelectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? foregroundColor;
  final ScrollController? scrollController;
  final Widget Function(BuildContext, DateTime, bool)? dateBuilder;
  final void Function(DateTime)? onLongPress;
  final Locale? locale;
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
    _startDate = widget.startDate ?? today.subtract(Duration(days: widget.daysBeforeToday));
    _endDate = widget.endDate ?? today.add(Duration(days: widget.daysAfterToday));
    _selectedDate = widget.initialSelectedDate ?? today;
    _generateDateList();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToDate(_selectedDate));
  }

  void _generateDateList() {
    _dateList.clear();
    for (DateTime date = _startDate;
        !date.isAfter(_endDate);
        date = date.add(const Duration(days: 1))) {
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

    final selectedColor = widget.selectedColor ?? const Color.fromARGB(255, 212, 245, 82);
    final unselectedColor = widget.unselectedColor ?? Colors.transparent;
    final foregroundColor = widget.foregroundColor ?? colorScheme.onPrimaryContainer;
    final foregroundColorFaint = foregroundColor.withAlpha(195);
    final borderColor = foregroundColor.withAlpha(125);

    final locale = widget.locale?.toString() ?? Localizations.localeOf(context).toString();

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
              final isSelected = _selectedDate != null && _isSameDay(date, _selectedDate!);
              final isToday = _isSameDay(date, DateTime.now());

              final dateCell = widget.dateBuilder?.call(context, date, isSelected) ??
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
