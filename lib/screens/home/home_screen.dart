import 'package:fitness/screens/models/fitness_data.dart';
import 'package:fitness/screens/notification/notification_screen.dart';
import 'package:fitness/widgets/calender_strip.dart';
import 'package:fitness/widgets/goals_card.dart';
import 'package:fitness/widgets/meal_selection.dart';
import 'package:fitness/widgets/nutrition_tracker.dart';
import 'package:fitness/widgets/progress_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FitnessData fitnessData;

  void onDateSelected(DateTime date) {
    setState(() {
      fitnessData.selectedDate = date;
      // You can add other logic here like loading data for the selected date
    });
  }

  @override
  void initState() {
    super.initState();
    fitnessData = FitnessData(
      progress: 92,
      calories: 1480,
      carbs: 281,
      protein: 20,
      fat: 169,
      goals: 4,
    );
  }

  void incrementProgress() {
    setState(() {
      if (fitnessData.progress < 100) {
        fitnessData.progress += 1;
        fitnessData.calories += 10;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Calendar Strip
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.black,
                              Colors.blue,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ).createShader(bounds),
                          child: Icon(
                            Icons.local_fire_department,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.black,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            tileMode: TileMode.mirror,
                          ).createShader(bounds),
                          child: Text(
                            'NovaFit',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotificationScreen()),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.notifications,
                              color: Color(0xFF5B6BF9),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                CalendarStrip(
                  currentDate: fitnessData.selectedDate,
                  onDateSelected: onDateSelected,
                ),
                const SizedBox(height: 16),
                // Progress Card
                ProgressCard(
                  progress: fitnessData.progress,
                  calories: fitnessData.calories,
                  date: DateFormat('d MMMM yyyy')
                      .format(fitnessData.selectedDate),
                ),
                const SizedBox(height: 16),
                // Goals Card
                GoalsCard(goals: fitnessData.goals),
                const SizedBox(height: 24),
                // Nutrition Info
                NutritionTracker(
                  carbs: fitnessData.carbs,
                  protein: fitnessData.protein,
                  fat: fitnessData.fat,
                ),
                const SizedBox(height: 24),
                // Planned Meals Section
                MealSection(
                  onAddMeal: incrementProgress,
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        Colors.blue, // Blue
                        Colors.black, // Black
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      tileMode:
                          TileMode.mirror, // Adds a mirrored repeating effect
                    ).createShader(bounds),
                    child: Text(
                      '--- NovaFit ---',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Colors
                            .white, // Text color is overridden by the gradient
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 4),
                Center(
                  child: Text(
                    'Your fitness, your way ❤️ with a smart twist!',
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      color: Color(
                          0xFF6C7BAA), // A lighter tone of the same palette
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Colors.black,
        Colors.blue,
      ],
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
    ),
    borderRadius: BorderRadius.circular(30),
  ),
  child: FloatingActionButton.extended(
    onPressed: () {
      // Action for AI Assistant
    },
    backgroundColor: Colors.transparent,
    icon: const Icon(Icons.chat_outlined, color: Colors.white),
    label: const Text(
      'AI Assistant',
      style: TextStyle(color: Colors.white),
    ),
  ),
)

    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gapSize;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 2,
    this.gapSize = 5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = (size.width / 2) - strokeWidth / 2;
    const int dashCount = 20;
    final double gapRadians = (2 * 3.141592653589793) / dashCount;

    for (int i = 0; i < dashCount; i += 2) {
      final double startAngle = i * gapRadians;
      final double sweepAngle = gapRadians;
      canvas.drawArc(
        Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
