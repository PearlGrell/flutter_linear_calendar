import 'package:flutter/material.dart';

class LinearCalendar extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime startDate;
  final DateTime? endDate;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Color? foregroundColor;
  final ScrollController? scrollController;

  const LinearCalendar({
    super.key,
    required this.onDateChanged,
    required this.startDate,
    this.endDate,
    this.selectedColor,
    this.scrollController,
    this.foregroundColor,
    this.unselectedColor,
  });

  @override
  State<LinearCalendar> createState() => _LinearCalendarState();
}

class _LinearCalendarState extends State<LinearCalendar> {
  late DateTime _endDate;
  late ScrollController _scrollController;
  final List<(DateTime, bool)> _dateList = [];

  @override
  void initState() {
    super.initState();
    _endDate = widget.endDate ?? DateTime.now().add(const Duration(days: 30));
    _scrollController = widget.scrollController ?? ScrollController();
    _initDateList();
    _scrollToToday();
  }

  void _initDateList() {
    _dateList.clear();
    for (
      DateTime date = widget.startDate;
      !date.isAfter(_endDate);
      date = date.add(const Duration(days: 1))
    ) {
      bool isToday = _isSameDay(date, DateTime.now());
      _dateList.add((date, isToday));
    }
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  void _scrollToToday() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int index = _dateList.indexWhere((entry) => entry.$2);
      if (index != -1) {
        double offset = index * 76;
        _scrollController.jumpTo(offset);
      }
    });
  }

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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 86,
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: _dateList.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final date = _dateList[index].$1;
            final isSelected = _dateList[index].$2;

            return AspectRatio(
              aspectRatio: 0.7,
              child: InkWell(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < _dateList.length; i++) {
                      _dateList[i] = (_dateList[i].$1, false);
                    }
                    _dateList[index] = (date, true);
                  });
                  widget.onDateChanged(date);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? selectedColor : unselectedColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: borderColor, width: 0.75),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _monthName(date),
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
                      Text(
                        _weekdayName(date),
                        style: textTheme.bodyMedium?.copyWith(
                          color: foregroundColorFaint,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _monthName(DateTime date) {
    return [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ][date.month - 1];
  }

  String _weekdayName(DateTime date) {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][date.weekday - 1];
  }
}
