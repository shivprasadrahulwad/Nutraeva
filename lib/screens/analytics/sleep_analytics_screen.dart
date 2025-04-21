import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class SleepAnalyticsScreen extends StatefulWidget {
  const SleepAnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<SleepAnalyticsScreen> createState() => _SleepAnalyticsScreenState();
}

class _SleepAnalyticsScreenState extends State<SleepAnalyticsScreen> {
  String selectedTimeFrame = 'Week';
  final List<String> timeFrames = ['Day', 'Week', 'Month', 'Year'];
  
  // Data for different time periods (in minutes)
  final Map<String, List<double>> sleepData = {
    'Day': [420, 30, 60, 45, 20, 360, 15], // Sleep segments in a day
    'Week': [420, 390, 450, 380, 410, 480, 350], // Daily sleep for a week
    'Month': [400, 420, 380, 450, 390, 410, 430, 370, 400, 440, 420, 390, 405, 415, 425, 
              385, 395, 435, 445, 375, 365, 455, 465, 405, 425, 385, 395, 415, 430, 410], // Daily sleep for a month
    'Year': [410, 400, 420, 390, 380, 400, 430, 405, 390, 385, 395, 415], // Monthly average sleep for a year
  };
  
  // Total sleep time in minutes (will convert to hours for display where appropriate)
  final Map<String, int> totalSleepMap = {
    'Day': 480,  // 480min = 8h
    'Week': 2880, // 2880min = 48h
    'Month': 12000, // 12000min = 200h
    'Year': 146000, // 146000min = 2433.33h
  };
  
  final List<bool> sleepGoalCompleted = [true, true, true, true, false, false, false];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with navigation and actions
                _buildHeader(),
                
                const SizedBox(height: 24),
                
                // Sleep summary
                _buildSleepSummary(),
                
                const SizedBox(height: 16),
                
                // Time frame selector
                _buildTimeFrameSelector(),
                
                const SizedBox(height: 16),
                
                // Bar chart
                _buildBarChart(),
                
                const SizedBox(height: 16),
                
                // Sleep Goal Tracker
                _buildSleepGoalWidget(),
                
                const SizedBox(height: 16),
                
                // Sleep Cycles graph
                _buildSleepCyclesWidget(),
                
                // Add some bottom padding to prevent overflow
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ),
        const Text(
          'Sleep Analytics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSleepSummary() {
    // Get current date range for display
    DateTime now = DateTime.now();
    String dateRange;
    
    switch (selectedTimeFrame) {
      case 'Day':
        dateRange = DateFormat('dd MMM yyyy').format(now);
        break;
      case 'Week':
        DateTime weekStart = now.subtract(Duration(days: now.weekday - 1));
        DateTime weekEnd = weekStart.add(const Duration(days: 6));
        dateRange = '${DateFormat('dd').format(weekStart)}-${DateFormat('dd MMM yyyy').format(weekEnd)}';
        break;
      case 'Month':
        dateRange = DateFormat('MMMM yyyy').format(now);
        break;
      case 'Year':
        dateRange = DateFormat('yyyy').format(now);
        break;
      default:
        dateRange = '';
    }
    
    // Convert to hours and minutes for display
    String sleepDisplay;
    String unitDisplay;
    int sleepValue = totalSleepMap[selectedTimeFrame] ?? 0;
    
    if (sleepValue >= 60) {
      int hours = sleepValue ~/ 60;
      int minutes = sleepValue % 60;
      sleepDisplay = hours.toString();
      unitDisplay = minutes > 0 ? 'h ${minutes}m' : 'h';
    } else {
      sleepDisplay = sleepValue.toString();
      unitDisplay = 'm';
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: sleepDisplay,
                style: const TextStyle(
                  fontSize: 32, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: unitDisplay,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Text(
          dateRange,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeFrameSelector() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: timeFrames.map((frame) {
            bool isSelected = frame == selectedTimeFrame;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTimeFrame = frame;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6A49E8) : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    frame,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    // Get current data based on selected time frame
    List<double> currentData = sleepData[selectedTimeFrame] ?? [];
    List<String> labels = _getTimeLabels();
    
    // Calculate the max Y value for the chart
    double maxY = currentData.isNotEmpty ? currentData.reduce((a, b) => a > b ? a : b) * 1.2 : 600;
    maxY = (maxY / 60).ceil() * 60; // Round up to nearest hour in minutes
    
    // Calculate bar width based on time frame
    double barWidth = 24;
    
    // Calculate total width needed for the chart content
    double contentWidth = currentData.length * (barWidth + 12); // bar width + spacing
    
    // Determine if scrolling is needed (for Month and Year)
    bool needsScrolling = selectedTimeFrame == 'Month' || selectedTimeFrame == 'Year';
    
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          // Static Y-axis that won't scroll
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: _buildYAxis(maxY),
          ),
          // Scrollable chart content
          Expanded(
            child: needsScrolling
                ? SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: contentWidth,
                      child: _buildBarChartContent(currentData, labels, maxY, barWidth),
                    ),
                  )
                : _buildBarChartContent(currentData, labels, maxY, barWidth),
          ),
        ],
      ),
    );
  }

  // Separate method for Y-axis with values in hours or minutes as appropriate
  Widget _buildYAxis(double maxY) {
    return SizedBox(
      width: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            maxY >= 60 ? '${(maxY / 60).round()}h' : maxY.round().toString() + 'm',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            maxY >= 120 ? '${(maxY / 2 / 60).round()}h' : (maxY / 2).round().toString() + 'm',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const Text(
            '0',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Separate method for the chart content
  Widget _buildBarChartContent(List<double> data, List<String> labels, double maxY, double barWidth) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
      child: BarChart(
        BarChartData(
          maxY: maxY,
          minY: 0,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)), // Hide left titles as we're using custom Y-axis
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int index = value.toInt();
                  if (index >= 0 && index < labels.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        labels[index],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
          ),
          barGroups: List.generate(
            data.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: data[index],
                  color: index == (data.length ~/ 3) 
                      ? const Color(0xFF6A49E8) 
                      : const Color(0xFFE2DDFF),
                  width: barWidth,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              tooltipMargin: 8,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                // Convert to hours and minutes for tooltip display
                String valueDisplay;
                if (data[groupIndex] >= 60) {
                  int hours = data[groupIndex] ~/ 60;
                  int minutes = data[groupIndex].toInt() % 60;
                  if (minutes > 0) {
                    valueDisplay = '${hours}h ${minutes}m';
                  } else {
                    valueDisplay = '${hours}h';
                  }
                } else {
                  valueDisplay = '${data[groupIndex].round()}m';
                }
                
                return BarTooltipItem(
                  valueDisplay,
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<String> _getTimeLabels() {
    switch (selectedTimeFrame) {
      case 'Day':
        return ['10PM', '12AM', '2AM', '4AM', '6AM', '8AM', '10AM'];
      case 'Week':
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      case 'Month':
        return List.generate(30, (index) => (index + 1).toString()); // Shows all 30 days
      case 'Year':
        return ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      default:
        return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    }
  }

  Widget _buildSleepGoalWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.nightlight_outlined, size: 18),
              SizedBox(width: 8),
              Text(
                'Sleep Goal Achievement',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (int i = 0; i < 7; i++)
                Column(
                  children: [
                    Text(
                      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: sleepGoalCompleted[i] 
                            ? const Color(0xFF6A49E8) 
                            : Colors.white,
                        border: Border.all(
                          color: sleepGoalCompleted[i] 
                              ? const Color(0xFF6A49E8) 
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: sleepGoalCompleted[i]
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18,
                            )
                          : null,
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSleepCyclesWidget() {
    // Sample data for sleep cycles and quality
    final List<SleepCyclePoint> cycleData = [
      SleepCyclePoint(DateTime(2025, 4, 20, 22, 0), 3), // Deep sleep
      SleepCyclePoint(DateTime(2025, 4, 20, 23, 30), 2), // Light sleep
      SleepCyclePoint(DateTime(2025, 4, 21, 0, 45), 4), // REM
      SleepCyclePoint(DateTime(2025, 4, 21, 2, 0), 3), // Deep sleep
      SleepCyclePoint(DateTime(2025, 4, 21, 3, 15), 2), // Light sleep
      SleepCyclePoint(DateTime(2025, 4, 21, 4, 30), 4), // REM
      SleepCyclePoint(DateTime(2025, 4, 21, 5, 45), 3), // Deep sleep
      SleepCyclePoint(DateTime(2025, 4, 21, 6, 30), 1), // Awake
      SleepCyclePoint(DateTime(2025, 4, 21, 7, 0), 1), // Awake
    ];

    // Calculate chart spots from cycle data
    List<FlSpot> getSpots() {
      return List.generate(
        cycleData.length,
        (index) => FlSpot(index.toDouble(), cycleData[index].cycleType.toDouble()),
      );
    }

    // Format time for x-axis labels
    String getTimeLabel(double value) {
      int index = value.toInt();
      if (index >= 0 && index < cycleData.length) {
        DateTime time = cycleData[index].time;
        return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
      }
      return '';
    }

    // Get sleep cycle type name
    String getCycleTypeName(int type) {
      switch (type) {
        case 1: return 'Awake';
        case 2: return 'Light';
        case 3: return 'Deep';
        case 4: return 'REM';
        default: return 'Unknown';
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.bedtime_outlined, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Sleep Cycles',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          'Quality',
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          'Last Night',
                          style: TextStyle(fontSize: 12),
                        ),
                        Icon(Icons.keyboard_arrow_down, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Sleep Score: ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                '85',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A49E8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSleepStat('Deep', '2h 30m', '32%'),
              _buildSleepStat('Light', '3h 15m', '45%'),
              _buildSleepStat('REM', '1h 45m', '23%'),
            ],
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Sleep Cycle',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 220,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: max(MediaQuery.of(context).size.width - 32, cycleData.length * 60.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 8.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 1,
                        verticalInterval: 1,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(
                            color: Colors.grey.shade200,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  getTimeLabel(value),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10,
                                  ),
                                ),
                              );
                            },
                            interval: 1,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 50,
                            getTitlesWidget: (value, meta) {
                              if (value >= 1 && value <= 4) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    getCycleTypeName(value.toInt()),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 10,
                                    ),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                            interval: 1,
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: true,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade300),
                          left: BorderSide(color: Colors.grey.shade300),
                        ),
                      ),
                      minX: 0,
                      maxX: (cycleData.length - 1).toDouble(),
                      minY: 0,
                      maxY: 5,
                      lineBarsData: [
                        LineChartBarData(
                          spots: getSpots(),
                          isCurved: true,
                          color: const Color(0xFF6A49E8),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 5,
                                color: const Color(0xFF6A49E8),
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color(0xFF6A49E8).withOpacity(0.2),
                          ),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((touchedSpot) {
                              final spotIndex = touchedSpot.x.toInt();
                              final cyclePoint = cycleData[spotIndex];
                              final time = '${cyclePoint.time.hour}:${cyclePoint.time.minute.toString().padLeft(2, '0')}';
                              
                              return LineTooltipItem(
                                '${getCycleTypeName(cyclePoint.cycleType)}\n$time',
                                const TextStyle(color: Colors.white),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text(
              'Time of Night',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSleepStat(String title, String time, String percentage) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          time,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          percentage,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class SleepCyclePoint {
  final DateTime time;
  final int cycleType; // 1 = Awake, 2 = Light sleep, 3 = Deep sleep, 4 = REM

  SleepCyclePoint(this.time, this.cycleType);
}