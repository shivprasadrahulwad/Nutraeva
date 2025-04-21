import 'package:fitness/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarStrip extends StatelessWidget {
  final DateTime currentDate;
  final Function(DateTime) onDateSelected;

  const CalendarStrip({
    Key? key,
    required this.currentDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DateTime> weekDays = _getDaysInWeek(currentDate);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: weekDays.map((date) {
          final bool isToday = _isSameDay(date, currentDate);
          final bool isWorkoutDay = _isWorkoutDay(date);
          final String dayLabel = isToday ? 'TODAY' : DateFormat('E').format(date)[0];
          final String dateLabel = date.day.toString();
          final bool isFutureDate = date.isAfter(currentDate);

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: _buildDayColumn(
              dayLabel,
              dateLabel,
              isToday: isToday,
              isSelected: isWorkoutDay,
              selectedColor: const Color(0xFF5B6BF9),
              textColor: isFutureDate ? Colors.teal : null,
            ),
          );
        }).toList(),
      ),
    );
  }

  // Helper method to check if a date is a workout day (connect to your fitness data)
  bool _isWorkoutDay(DateTime date) {
    // For demo purposes - marking a date 2 days before today as a workout day
    final DateTime today = DateTime.now();
    final DateTime twoDaysAgo = today.subtract(const Duration(days: 2));
    return _isSameDay(date, twoDaysAgo);
  }

  // Helper method to check if two dates are the same day
  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  // Helper method to get 7 days centered around the current day
  List<DateTime> _getDaysInWeek(DateTime centerDate) {
    return List.generate(7, (index) {
      // Generate days with today in the middle (index 3)
      return centerDate.add(Duration(days: index - 3));
    });
  }

  Widget _buildDayColumn(
    String day,
    String date, {
    bool isSelected = false,
    bool isToday = false,
    Color? textColor,
    Color? selectedColor,
  }) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 14,
            color: textColor ?? Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 45,
          height: 45,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Grey background if today
              if (isToday)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                ),

              // Dashed border if selected
              if (isSelected)
                CustomPaint(
                  size: const Size(45, 45),
                  painter: DashedCirclePainter(
                    color: selectedColor ?? const Color(0xFF5B6BF9),
                    strokeWidth: 2,
                    gapSize: 6,
                  ),
                ),

              // Center date text
              Center(
                child: Text(
                  date,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? (selectedColor ?? const Color(0xFF5B6BF9))
                        : (textColor ?? Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}