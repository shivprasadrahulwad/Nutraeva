import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeatmapCalendar extends StatelessWidget {
  /// Map of dates to intensity values (0.0 to 1.0)
  final Map<DateTime, double> dataset;
  
  /// Number of months to display
  final int monthsToDisplay;
  
  /// Color for the highest intensity
  final Color colorHigh;
  
  /// Color for the lowest intensity
  final Color colorLow;
  
  /// Start date for the calendar (defaults to current date minus monthsToDisplay)
  final DateTime? startDate;
  
  /// Callback when a date cell is tapped
  final Function(DateTime)? onDateSelected;

  const HeatmapCalendar({
    Key? key,
    required this.dataset,
    this.monthsToDisplay = 6,
    this.colorHigh = Colors.green,
    this.colorLow = const Color(0xFFEBEDF0),
    this.startDate,
    this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final start = startDate ?? 
        DateTime(today.year, today.month - monthsToDisplay + 1, 1);
    
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activity Calendar',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    _buildLegendItem(context, 'Less', colorLow),
                    const SizedBox(width: 4),
                    _buildLegendGradient(),
                    const SizedBox(width: 4),
                    _buildLegendItem(context, 'More', colorHigh),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: monthsToDisplay,
              itemBuilder: (context, index) {
                final monthDate = DateTime(
                  start.year, 
                  start.month + index, 
                  1,
                );
                return _buildMonthView(context, monthDate);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(width: 4),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  Widget _buildLegendGradient() {
    return Container(
      width: 64,
      height: 12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorLow, colorHigh],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildMonthView(BuildContext context, DateTime monthDate) {
    final daysInMonth = DateUtils.getDaysInMonth(monthDate.year, monthDate.month);
    final firstDayOfMonth = DateTime(monthDate.year, monthDate.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7; // 0 = Sunday, 6 = Saturday
    
    final dayNames = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 40, top: 16, bottom: 8),
          child: Text(
            DateFormat('MMMM yyyy').format(monthDate),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 40), // Space for month label
            ...List.generate(7, (index) {
              return Expanded(
                child: Center(
                  child: Text(
                    dayNames[index],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
        const SizedBox(height: 4),
        ...List.generate((daysInMonth + firstWeekdayOfMonth + 6) ~/ 7, (weekIndex) {
          return Row(
            children: [
              SizedBox(
                width: 40,
                child: Center(
                  child: Text(
                    _getWeekLabel(weekIndex, monthDate),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              ...List.generate(7, (dayIndex) {
                final day = weekIndex * 7 + dayIndex - firstWeekdayOfMonth + 1;
                if (day < 1 || day > daysInMonth) {
                  return Expanded(child: Container());
                }
                
                final date = DateTime(monthDate.year, monthDate.month, day);
                final intensity = dataset[DateUtils.dateOnly(date)] ?? 0.0;
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: GestureDetector(
                      onTap: () {
                        if (onDateSelected != null) {
                          onDateSelected!(date);
                        }
                      },
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: _getColorForIntensity(intensity),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              day.toString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: intensity > 0.5 ? Colors.white : Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        }),
      ],
    );
  }

  String _getWeekLabel(int weekIndex, DateTime monthDate) {
    final firstDayOfMonth = DateTime(monthDate.year, monthDate.month, 1);
    final firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;
    
    final startDay = weekIndex * 7 - firstWeekdayOfMonth + 1;
    if (startDay < 1) return '';
    
    return DateFormat('MMM').format(DateTime(monthDate.year, monthDate.month, startDay))[0];
  }

  Color _getColorForIntensity(double intensity) {
    if (intensity <= 0) return colorLow;
    
    return Color.lerp(colorLow, colorHigh, intensity) ?? colorLow;
  }
}