// import 'package:flutter/material.dart';

// class TimelineItem {
//   final String time;
//   final String title;
//   final String description;
//   final bool isCompleted;

//   TimelineItem({
//     required this.time,
//     required this.title,
//     required this.description,
//     this.isCompleted = false,
//   });
// }

// class FitnessTimeline extends StatelessWidget {
//   const FitnessTimeline({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final List<TimelineItem> items = [
//       TimelineItem(
//         time: "6:00 AM",
//         title: "Wake Up & Hydrate",
//         description: "250-500ml water and light stretching",
//         isCompleted: true,
//       ),
//       TimelineItem(
//         time: "6:15 AM",
//         title: "Pre-workout Meal",
//         description: "Light snack with carbs and protein",
//         isCompleted: true,
//       ),
//       TimelineItem(
//         time: "6:45 AM",
//         title: "Workout Session",
//         description: "60-90 min strength training or HIIT",
//         isCompleted: true,
//       ),
//       TimelineItem(
//         time: "8:00 AM",
//         title: "Post-workout Recovery",
//         description: "Protein-rich meal and hydration",
//         isCompleted: true,
//       ),
//       TimelineItem(
//         time: "9:00 AM",
//         title: "Personal Development",
//         description: "30-60 min reading and light stretching",
//         isCompleted: true,
//       ),
//       TimelineItem(
//         time: "10:00 AM",
//         title: "Light Snack",
//         description: "Balanced snack with protein and fiber",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "12:00 PM",
//         title: "Lunch",
//         description: "Balanced meal with protein, fats, and carbs",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "1:00 PM",
//         title: "Work/Professional Tasks",
//         description: "Focus time with short breaks hourly",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "3:30 PM",
//         title: "Afternoon Snack",
//         description: "Energy-maintaining protein snack",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "5:30 PM",
//         title: "Second Workout/Recovery",
//         description: "Optional gym session or deep stretching",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "7:00 PM",
//         title: "Dinner",
//         description: "Balanced meal with lean protein and vegetables",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "8:00 PM",
//         title: "Relaxation/Leisure",
//         description: "Reading, educational content, or hobbies",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "9:00 PM",
//         title: "Evening Recovery",
//         description: "Light stretching or yoga for 10-15 min",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "10:00 PM",
//         title: "Prepare for Sleep",
//         description: "Limit screens, prepare sleep environment",
//         isCompleted: false,
//       ),
//       TimelineItem(
//         time: "10:30 PM",
//         title: "Sleep",
//         description: "7-9 hours of quality sleep for recovery",
//         isCompleted: false,
//       ),
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fitness Daily Timeline'),
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.grey.shade100,
//               Colors.grey.shade300,
//             ],
//           ),
//         ),
//         child: ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             final item = items[index];
//             final bool isLastItem = index == items.length - 1;
            
//             return IntrinsicHeight(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     width: 80,
//                     child: Text(
//                       item.time,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: [
//                       Container(
//                         width: 24,
//                         height: 24,
//                         decoration: BoxDecoration(
//                           color: item.isCompleted ? Colors.deepPurple : Colors.grey.shade400,
//                           shape: BoxShape.circle,
//                         ),
//                         child: item.isCompleted
//                             ? const Icon(Icons.check, color: Colors.white, size: 16)
//                             : null,
//                       ),
//                       if (!isLastItem)
//                         Expanded(
//                           child: Container(
//                             width: 2,
//                             color: index < 5 ? Colors.deepPurple : Colors.grey.shade400,
//                           ),
//                         ),
//                     ],
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.only(bottom: 16),
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.deepPurple.shade300,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             item.title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             item.description,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineItem {
  String time;
  String title;
  String description;
  bool isCompleted;

  TimelineItem({
    required this.time,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });

  // Convert string time to DateTime for sorting
  DateTime getDateTime() {
    try {
      final format = DateFormat('h:mm a');
      return format.parse(time);
    } catch (e) {
      // Default time if parsing fails
      return DateTime(2025, 1, 1, 0, 0);
    }
  }
}

class CustomizableFitnessTimeline extends StatefulWidget {
  const CustomizableFitnessTimeline({Key? key}) : super(key: key);

  @override
  State<CustomizableFitnessTimeline> createState() => _CustomizableFitnessTimelineState();
}

class _CustomizableFitnessTimelineState extends State<CustomizableFitnessTimeline> {
  List<TimelineItem> items = [
    TimelineItem(
      time: "6:00 AM",
      title: "Wake Up & Hydrate",
      description: "250-500ml water and light stretching",
      isCompleted: true,
    ),
    TimelineItem(
      time: "6:15 AM",
      title: "Pre-workout Meal",
      description: "Light snack with carbs and protein",
      isCompleted: true,
    ),
    // Initial items from the original code
    // ... (You can include more or fewer initial items as preferred)
  ];

  void _addNewItem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EditItemBottomSheet(
          onSave: (TimelineItem newItem) {
            setState(() {
              items.add(newItem);
              _sortItemsByTime();
            });
          },
        );
      },
    );
  }

  void _editItem(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return EditItemBottomSheet(
          initialItem: items[index],
          onSave: (TimelineItem updatedItem) {
            setState(() {
              items[index] = updatedItem;
              _sortItemsByTime();
            });
          },
        );
      },
    );
  }

  void _toggleItemCompletion(int index) {
    setState(() {
      items[index].isCompleted = !items[index].isCompleted;
    });
  }

  void _deleteItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _sortItemsByTime() {
    items.sort((a, b) => a.getDateTime().compareTo(b.getDateTime()));
  }

  @override
  void initState() {
    super.initState();
    _sortItemsByTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Daily Timeline'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              setState(() {
                _sortItemsByTime();
              });
            },
            tooltip: 'Sort by time',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewItem,
        child: const Icon(Icons.add),
        tooltip: 'Add new activity',
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade300,
            ],
          ),
        ),
        child: items.isEmpty
            ? const Center(
                child: Text('No activities yet. Add one to get started!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final bool isLastItem = index == items.length - 1;

                  return Dismissible(
                    key: Key(item.time + item.title + DateTime.now().toString()),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      _deleteItem(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${item.title} deleted')),
                      );
                    },
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Time section - tappable to edit time
                          GestureDetector(
                            onTap: () => _selectTime(index),
                            child: SizedBox(
                              width: 80,
                              child: Text(
                                item.time,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          // Timeline indicators
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => _toggleItemCompletion(index),
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: item.isCompleted ? Colors.deepPurple : Colors.grey.shade400,
                                    shape: BoxShape.circle,
                                  ),
                                  child: item.isCompleted
                                      ? const Icon(Icons.check, color: Colors.white, size: 16)
                                      : null,
                                ),
                              ),
                              if (!isLastItem)
                                Expanded(
                                  child: Container(
                                    width: 2,
                                    color: item.isCompleted ? Colors.deepPurple : Colors.grey.shade400,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // Activity card - tappable to edit details
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _editItem(index),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.deepPurple.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            item.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.white.withOpacity(0.7),
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.description,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _selectTime(int index) async {
    TimeOfDay initialTime;
    try {
      // Try to parse the existing time
      final parts = items[index].time.split(' ');
      final timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      
      // Handle AM/PM
      if (parts[1] == 'PM' && hour < 12) {
        hour += 12;
      } else if (parts[1] == 'AM' && hour == 12) {
        hour = 0;
      }
      
      initialTime = TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      initialTime = TimeOfDay.now();
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        // Format to AM/PM
        final hour = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        items[index].time = '$hour:${picked.minute.toString().padLeft(2, '0')} $period';
        _sortItemsByTime();
      });
    }
  }
}

class EditItemBottomSheet extends StatefulWidget {
  final TimelineItem? initialItem;
  final Function(TimelineItem) onSave;

  const EditItemBottomSheet({
    Key? key,
    this.initialItem,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditItemBottomSheet> createState() => _EditItemBottomSheetState();
}

class _EditItemBottomSheetState extends State<EditItemBottomSheet> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _selectedTime;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialItem?.title ?? '');
    _descriptionController = TextEditingController(text: widget.initialItem?.description ?? '');
    _selectedTime = widget.initialItem?.time ?? _formatTimeOfDay(TimeOfDay.now());
    _isCompleted = widget.initialItem?.isCompleted ?? false;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }

  Future<void> _selectTime() async {
    TimeOfDay initialTime;
    try {
      // Try to parse the existing time
      final parts = _selectedTime.split(' ');
      final timeParts = parts[0].split(':');
      int hour = int.parse(timeParts[0]);
      int minute = int.parse(timeParts[1]);
      
      // Handle AM/PM
      if (parts[1] == 'PM' && hour < 12) {
        hour += 12;
      } else if (parts[1] == 'AM' && hour == 12) {
        hour = 0;
      }
      
      initialTime = TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      initialTime = TimeOfDay.now();
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (picked != null) {
      setState(() {
        _selectedTime = _formatTimeOfDay(picked);
      });
    }
  }

  void _saveItem() {
    if (_titleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title cannot be empty')),
      );
      return;
    }

    final newItem = TimelineItem(
      time: _selectedTime,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      isCompleted: _isCompleted,
    );

    widget.onSave(newItem);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.initialItem == null ? 'Add New Activity' : 'Edit Activity',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Text(_selectedTime),
            leading: const Icon(Icons.access_time),
            onTap: _selectTime,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Activity Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: _isCompleted,
                onChanged: (value) {
                  setState(() {
                    _isCompleted = value ?? false;
                  });
                },
              ),
              const Text('Mark as completed'),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _saveItem,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(widget.initialItem == null ? 'Add Activity' : 'Save Changes'),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}