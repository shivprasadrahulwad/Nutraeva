import 'package:fitness/widgets/heatmap_calender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeatmapDemo extends StatefulWidget {
  const HeatmapDemo({Key? key}) : super(key: key);

  @override
  State<HeatmapDemo> createState() => _HeatmapDemoState();
}

class _HeatmapDemoState extends State<HeatmapDemo> {
  // Sample data - map dates to values between 0.0 and 1.0
  final Map<DateTime, double> dataset = {};
  
  @override
  void initState() {
    super.initState();
    _generateSampleData();
  }
  
  void _generateSampleData() {
    final now = DateTime.now();
    
    // Create sample data for the last 180 days
    for (int i = 0; i < 180; i++) {
      final date = now.subtract(Duration(days: i));
      final normalized = DateUtils.dateOnly(date);
      
      // Create random intensity values (in real app, this would be your actual data)
      if (i % 4 != 0) { // Skip some days to show empty cells
        dataset[normalized] = (i % 7) / 10 + (date.day % 3) / 10 + 0.1;
        
        // Clamp values between 0 and 1
        dataset[normalized] = dataset[normalized]!.clamp(0.0, 1.0);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Heatmap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 600,
          child: HeatmapCalendar(
            dataset: dataset,
            monthsToDisplay: 6,
            colorHigh: Colors.green,
            colorLow: const Color(0xFFEBEDF0),
            onDateSelected: (date) {
              // Handle date selection
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Selected: ${DateFormat('yyyy-MM-dd').format(date)} - Value: ${dataset[DateUtils.dateOnly(date)] ?? 0.0}'
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}