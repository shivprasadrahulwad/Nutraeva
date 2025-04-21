import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoalUpdateScreen extends StatefulWidget {
  const GoalUpdateScreen({Key? key}) : super(key: key);

  @override
  State<GoalUpdateScreen> createState() => _GoalUpdateScreenState();
}

class _GoalUpdateScreenState extends State<GoalUpdateScreen> {
  int calorieIntake = 1985;
  DateTime goalDate = DateTime(2025, 3, 2);
  DateTime weightDate = DateTime(2025, 3, 2);
  double startWeight = 85;
  double goalWeight = 65;
  String activityLevel = 'Sedentary';

  final List<String> activityLevels = [
    'Sedentary',
    'Lightly Active',
    'Moderately Active',
    'Very Active',
    'Extremely Active'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const Text(
          'Update Goal',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () {
                // Show options menu
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.delete_outline),
                        title: const Text('Delete Goal'),
                        onTap: () {
                          Navigator.pop(context);
                          // Show confirmation dialog
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Delete Goal'),
                              content: const Text(
                                  'Are you sure you want to delete this goal?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                  child: const Text('Delete'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Goal deleted')),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.restart_alt),
                        title: const Text('Reset Goal'),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            calorieIntake = 1985;
                            goalDate = DateTime(2025, 3, 2);
                            weightDate = DateTime(2025, 3, 2);
                            startWeight = 85;
                            goalWeight = 65;
                            activityLevel = 'Sedentary';
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Goal has been reset')),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: [
            _buildSectionHeader('Daily Calory Intake'),
            _buildEditableField(
              value: '$calorieIntake',
              subtitle: 'kcal / day',
              onTap: () {
                _showNumericInputDialog(
                  context: context,
                  title: 'Daily Calorie Intake',
                  initialValue: calorieIntake.toString(),
                  onSave: (value) {
                    setState(() {
                      calorieIntake = int.parse(value);
                    });
                  },
                  suffix: 'kcal / day',
                );
              },
            ),
            _buildSectionHeader('Goal Date'),
            _buildEditableField(
              value: DateFormat('dd MMMM yyyy').format(goalDate).toLowerCase(),
              subtitle: 'Select a date after 01 January 2025',
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: goalDate,
                  firstDate: DateTime(2025, 1, 1),
                  lastDate: DateTime(2030),
                );
                if (picked != null && picked != goalDate) {
                  setState(() {
                    goalDate = picked;
                  });
                }
              },
            ),
            _buildSectionHeader('Weight Date & Activity Level'),
            _buildEditableField(
              value:
                  DateFormat('dd MMMM yyyy').format(weightDate).toLowerCase(),
              subtitle: 'Select a date after 01 January 2025',
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: weightDate,
                  firstDate: DateTime(2025, 1, 1),
                  lastDate: DateTime(2030),
                );
                if (picked != null && picked != weightDate) {
                  setState(() {
                    weightDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 10),
            _buildTileWithHeader(
              header: 'Start Weight',
              value: '$startWeight kg',
              onTap: () {
                _showNumericInputDialog(
                  context: context,
                  title: 'Start Weight',
                  initialValue: startWeight.toString(),
                  onSave: (value) {
                    setState(() {
                      startWeight = double.parse(value);
                    });
                  },
                  suffix: 'kg',
                );
              },
            ),
            const SizedBox(height: 10),
            _buildTileWithHeader(
              header: 'Weight Goal',
              value: '$goalWeight kg',
              onTap: () {
                _showNumericInputDialog(
                  context: context,
                  title: 'Weight Goal',
                  initialValue: goalWeight.toString(),
                  onSave: (value) {
                    setState(() {
                      goalWeight = double.parse(value);
                    });
                  },
                  suffix: 'kg',
                );
              },
            ),
            const SizedBox(height: 10),
            _buildTileWithHeader(
              header: 'Activity Level',
              value: activityLevel,
              onTap: () {
                _showActivityLevelPicker(context);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String value,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        title: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              )
            : null,
        trailing: const Icon(Icons.edit, color: Colors.black54),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildTileWithHeader({
    required String header,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.edit, color: Colors.black54),
        onTap: onTap,
      ),
    );
  }

  void _showNumericInputDialog({
    required BuildContext context,
    required String title,
    required String initialValue,
    required Function(String) onSave,
    required String suffix,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            suffixText: suffix,
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                onSave(controller.text);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void _showActivityLevelPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
        shrinkWrap: true,
        itemCount: activityLevels.length,
        itemBuilder: (context, index) {
          final level = activityLevels[index];
          return ListTile(
            title: Text(level),
            trailing: level == activityLevel
                ? const Icon(Icons.check, color: Colors.blue)
                : null,
            onTap: () {
              setState(() {
                activityLevel = level;
              });
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
