import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class WaterAnalyticsScreen extends StatefulWidget {
  const WaterAnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<WaterAnalyticsScreen> createState() => _WaterAnalyticsScreenState();
}

class _WaterAnalyticsScreenState extends State<WaterAnalyticsScreen> {
  String selectedTimeFrame = 'Week';
  final List<String> timeFrames = ['Day', 'Week', 'Month', 'Year'];
  
  // Data for different time periods (in ml)
  final Map<String, List<double>> waterData = {
    'Day': [200, 350, 400, 300, 250, 180, 120],
    'Week': [1700, 2500, 3000, 2300, 1800, 2200, 1000],
    'Month': [2000, 2200, 1800, 2500, 1900, 2100, 2300, 1700, 2000, 2400, 2200, 1900],
    'Year': [25000, 27000, 29000, 26000, 24000, 28000, 30000, 27500, 26000, 24500, 26500, 28000],
  };
  
  // Total water intake in ml (will convert to L for display where appropriate)
  final Map<String, int> totalWaterMap = {
    'Day': 2000,  // 2000ml = 2L
    'Week': 14500, // 14.5L
    'Month': 65000, // 65L
    'Year': 876000, // 876L
  };
  
  final List<bool> challengeCompleted = [true, true, true, true, false, false, false];
  
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
                
                // Water summary
                _buildWaterSummary(),
                
                const SizedBox(height: 16),
                
                // Time frame selector
                _buildTimeFrameSelector(),
                
                const SizedBox(height: 16),
                
                // Bar chart
                _buildBarChart(),
                
                const SizedBox(height: 16),
                
                // Day Water Challenge
                _buildDayChallengeWidget(),
                
                const SizedBox(height: 16),
                
                // Time of Day graph
                _buildTimeOfDayWidget(),
                
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
          'Water Analytics',
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

  Widget _buildWaterSummary() {
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
    
    // Convert to liters for display if value is 1000ml or more
    String waterDisplay;
    String unitDisplay;
    int waterValue = totalWaterMap[selectedTimeFrame] ?? 0;
    
    if (waterValue >= 1000) {
      waterDisplay = (waterValue / 1000).toStringAsFixed(1);
      unitDisplay = 'L';
    } else {
      waterDisplay = waterValue.toString();
      unitDisplay = 'ml';
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: waterDisplay,
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
                    color: isSelected ? const Color(0xFF4169E8) : Colors.transparent,
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
    List<double> currentData = waterData[selectedTimeFrame] ?? [];
    List<String> labels = _getTimeLabels();
    
    // Calculate the max Y value for the chart
    double maxY = currentData.isNotEmpty ? currentData.reduce((a, b) => a > b ? a : b) * 1.2 : 3000;
    maxY = (maxY / 1000).ceil() * 1000; // Round up to nearest thousand
    
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

  // Separate method for Y-axis with values in L or ml as appropriate
  Widget _buildYAxis(double maxY) {
    return SizedBox(
      width: 32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            maxY >= 1000 ? '${(maxY / 1000).round()}L' : maxY.round().toString() + 'ml',
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Text(
            maxY >= 2000 ? '${(maxY / 2000).round()}L' : (maxY / 2).round().toString() + 'ml',
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
                      ? const Color(0xFF4169E8) 
                      : const Color(0xFFE0E6FF),
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
                // Convert to L if over 1000ml for tooltip display
                String valueDisplay;
                if (data[groupIndex] >= 1000) {
                  valueDisplay = '${(data[groupIndex] / 1000).toStringAsFixed(1)}L';
                } else {
                  valueDisplay = '${data[groupIndex].round()}ml';
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
        return ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM', '12AM'];
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

  Widget _buildDayChallengeWidget() {
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
              Icon(Icons.water_drop_outlined, size: 18),
              SizedBox(width: 8),
              Text(
                'Daily Water Challenge',
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
                        color: challengeCompleted[i] 
                            ? const Color(0xFF4169E8) 
                            : Colors.white,
                        border: Border.all(
                          color: challengeCompleted[i] 
                              ? const Color(0xFF4169E8) 
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: challengeCompleted[i]
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

  Widget _buildTimeOfDayWidget() {
    // Sample data for time points and water intake
    final List<WaterTimePoint> timeData = [
      WaterTimePoint(DateTime(2025, 4, 20, 6, 0), 150),
      WaterTimePoint(DateTime(2025, 4, 20, 8, 30), 320),
      WaterTimePoint(DateTime(2025, 4, 20, 12, 15), 450),
      WaterTimePoint(DateTime(2025, 4, 20, 15, 0), 180),
      WaterTimePoint(DateTime(2025, 4, 20, 18, 30), 380),
      WaterTimePoint(DateTime(2025, 4, 20, 20, 45), 280),
      WaterTimePoint(DateTime(2025, 4, 20, 22, 0), 120),
      WaterTimePoint(DateTime(2025, 4, 20, 23, 30), 90),
      WaterTimePoint(DateTime(2025, 4, 21, 1, 0), 40),
      WaterTimePoint(DateTime(2025, 4, 21, 2, 30), 30),
    ];

    // Calculate chart spots from time data
    List<FlSpot> getSpots() {
      return List.generate(
        timeData.length,
        (index) => FlSpot(index.toDouble(), timeData[index].water.toDouble()),
      );
    }

    // Format time for x-axis labels
    String getTimeLabel(double value) {
      int index = value.toInt();
      if (index >= 0 && index < timeData.length) {
        DateTime time = timeData[index].time;
        return '${time.hour}:${time.minute.toString().padLeft(2, '0')}';
      }
      return '';
    }

    // Convert water intake to appropriate unit for display
    String getWaterDisplay(int waterML) {
      if (waterML >= 1000) {
        return '${(waterML / 1000).toStringAsFixed(1)}L';
      } else {
        return '${waterML}ml';
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
                  Icon(Icons.access_time, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Time Of Day',
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
                          'Water',
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
                          'Weekly',
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
          Text(
            getWaterDisplay(totalWaterMap[selectedTimeFrame] ?? 0),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4169E8),
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Water Intake (ml)',
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
                width: max(MediaQuery.of(context).size.width - 32, timeData.length * 60.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 16.0, bottom: 8.0),
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: true,
                        horizontalInterval: 100,
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
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ),
                              );
                            },
                            interval: 100,
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
                      maxX: (timeData.length - 1).toDouble(),
                      minY: 0,
                      maxY: 500,
                      lineBarsData: [
                        LineChartBarData(
                          spots: getSpots(),
                          isCurved: true,
                          color: const Color(0xFF4169E8),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 5,
                                color: const Color(0xFF4169E8),
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: const Color(0xFF4169E8).withOpacity(0.2),
                          ),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((touchedSpot) {
                              final spotIndex = touchedSpot.x.toInt();
                              final timePoint = timeData[spotIndex];
                              final time = '${timePoint.time.hour}:${timePoint.time.minute.toString().padLeft(2, '0')}';
                              
                              // Display water amount in ml since it's usually small amounts
                              return LineTooltipItem(
                                '${timePoint.water}ml\n$time',
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
              'Time of Day',
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
}

class WaterTimePoint {
  final DateTime time;
  final int water; // in ml

  WaterTimePoint(this.time, this.water);
}