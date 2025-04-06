import 'package:fitness/screens/home/food_details_screen.dart';
import 'package:fitness/widgets/heatmap_calender.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<DateTime, double> generateDummyData() {
    final Map<DateTime, double> data = {};
    final now = DateTime.now();

    // Generate data for the past 6 months
    for (int i = 0; i < 180; i++) {
      final date =
          DateTime(now.year, now.month, now.day).subtract(Duration(days: i));

      // Generate random intensity between 0 and 1
      // More recent dates have higher chance of higher intensity
      final recencyFactor = 1 - (i / 180);
      final baseIntensity =
          recencyFactor * 0.7; // Base intensity decreases with older dates
      final randomFactor =
          0.3 * (DateTime.now().millisecondsSinceEpoch % 100) / 100;

      // Some days have no data (intensity = 0)
      if (i % 7 == 0) {
        data[DateUtils.dateOnly(date)] = 0.0;
      } else {
        data[DateUtils.dateOnly(date)] =
            (baseIntensity + randomFactor).clamp(0.0, 1.0);
      }
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEF3F3),
      body: SafeArea(
        child: SingleChildScrollView(
          // Add this SingleChildScrollView
          child: Column(
            children: [
              _buildHeader(context),
              _buildDynamicCalendarStrip(),
              const SizedBox(height: 30),
              _buildOvulationInfo(),
              const SizedBox(height: 40),
              _buildLogPeriodButton(),
              const SizedBox(height: 20),
              _buildCalorieSliderCard(context),
              const SizedBox(height: 40),
              _buildInsightsSection(context),
              const SizedBox(height: 20), // Replace Spacer with fixed height
              _buildSearchBar(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          _buildBottomNavBar(), // Move nav bar outside scrollable area
    );
  }

  Widget _buildHeader(BuildContext context) {
    final DateTime now = DateTime.now();
    final String formattedDate = DateFormat('MMMM d').format(now);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile icon
          Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: Color(0xFFFF749A),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Icon(
                Icons.pets,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),

          // Date heading
          Column(
            children: [
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeatmapCalendar(
                      dataset: generateDummyData(),
                      monthsToDisplay: 6,
                      colorHigh: Colors.green,
                      colorLow: const Color(0xFFEBEDF0),
                      onDateSelected: (date) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Selected date: ${DateFormat('yyyy-MM-dd').format(date)}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Icon(Icons.calendar_month, size: 30)),
        ],
      ),
    );
  }

  Widget _buildDynamicCalendarStrip() {
    final DateTime today = DateTime.now();
    final List<DateTime> weekDays = _getDaysInWeek(today);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: weekDays.map((date) {
          final bool isToday = _isSameDay(date, today);
          final bool isPeriodDay = _isPeriodDay(
              date); // You would define this based on your app's data
          final String dayLabel =
              isToday ? 'TODAY' : DateFormat('E').format(date)[0];
          final String dateLabel = date.day.toString();
          final bool isFutureDate = date.isAfter(today);

          return _buildDayColumn(
            dayLabel,
            dateLabel,
            isToday: isToday,
            isSelected: isPeriodDay,
            selectedColor: Color(0xFFFF749A),
            textColor: isFutureDate ? Colors.teal : null,
          );
        }).toList(),
      ),
    );
  }

  // Helper method to check if a date is a period day (this would be connected to your app's data)
  bool _isPeriodDay(DateTime date) {
    // For demo purposes - marking a date 2 days before today as a period day
    final DateTime today = DateTime.now();
    final DateTime twoDaysAgo = today.subtract(Duration(days: 2));
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

  Widget _buildDayColumn(String day, String date,
      {bool isSelected = false,
      bool isToday = false,
      Color? textColor,
      Color? selectedColor}) {
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
                    color: selectedColor ?? Colors.pink,
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
                        ? (selectedColor ?? Colors.pink)
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

  Widget _buildOvulationInfo() {
    return Column(
      children: [
        Text(
          'Target in',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '7 days',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'High chance of getting Target Complete',
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildLogPeriodButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFFF749A),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        'Log period',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildInsightsSection(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth - 40) / 3; // 20 padding on left + right
    PageController _pageController = PageController();

    List<Widget> _buildInsightPages() {
      List<Map<String, dynamic>> insightData = [
        {
          "text": "Carbs Left",
          "color": Colors.green,
          "target": 380,
          "current": 172
        },
        {
          "text": "Fat Left",
          "color": Colors.orange,
          "target": 130,
          "current": 25
        },
        {
          "text": "Protein Left",
          "color": Colors.blue,
          "target": 200,
          "current": 172
        },
        {
          "text": "Calories",
          "color": Colors.red,
          "target": 2000,
          "current": 1450
        },
        {
          "text": "Water",
          "color": Colors.teal,
          "target": 3000,
          "current": 2100
        },
        {"text": "Fiber", "color": Colors.purple, "target": 40, "current": 25},
      ];

      List<Widget> pages = [];
      for (int i = 0; i < insightData.length; i += 3) {
        pages.add(
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(3, (j) {
                int index = i + j;
                if (index >= insightData.length) return const SizedBox.shrink();
                var item = insightData[index];
                return _buildInsightCard(
                  width: cardWidth.toDouble(),
                  color: item['color'],
                  text: item['text'],
                  icon: Icons.local_dining,
                  target: (item['target'] as num).toDouble(),
                  current: (item['current'] as num).toDouble(),
                );
              }),
            ),
          ),
        );
      }
      return pages;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20, bottom: 15),
          child: Text(
            'My daily insights · Today',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        GestureDetector(
          onTap: () {
            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MealTrackerScreen()),
      );
          },
          child: Text('food details screen')),
        SizedBox(
          height: 190,
          child: PageView(
            controller: _pageController,
            children: _buildInsightPages(),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: SmoothPageIndicator(
            controller: _pageController,
            count: (_buildInsightPages().length),
            effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.black87,
              dotColor: Colors.grey.shade300,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 20, top: 15),
          child: Text(
            'In your early stage',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInsightCard({
    required double width,
    required Color color,
    required String text,
    required IconData icon,
    required double target,
    required double current,
  }) {
    double percent = (current / target).clamp(0.0, 1.0);
    int remaining = (target - current).ceil();

    return Container(
      width: width,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$remaining',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          CircularPercentIndicator(
            radius: 40,
            lineWidth: 8,
            percent: percent,
            progressColor: color,
            backgroundColor: color.withOpacity(0.2),
            circularStrokeCap: CircularStrokeCap.round,
            center: Icon(
              icon,
              color: color,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search articles, videos and more',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieSliderCard(BuildContext context) {
    final PageController _pageController = PageController();

    return StatefulBuilder(
      builder: (context, setState) {
        int _currentPage = 0;

        Widget buildCard({
          required String calorieText,
          required double percent,
          required Color progressColor,
          required String label,
          required String infoText,
        }) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top section with value and circular indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text column
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            calorieText,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            label,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      // Circular progress bar
                      CircularPercentIndicator(
                        radius: 60,
                        lineWidth: 10,
                        percent: percent,
                        progressColor: progressColor,
                        backgroundColor: progressColor.withOpacity(0.2),
                        circularStrokeCap: CircularStrokeCap.round,
                        center: const Icon(
                          Icons.local_fire_department,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Info section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          infoText,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  buildCard(
                    calorieText: '1150',
                    percent: 0.7,
                    progressColor: Colors.green,
                    label: 'Calories Gained',
                    infoText: "You've completed today's target.",
                  ),
                  buildCard(
                    calorieText: '700',
                    percent: 0.3,
                    progressColor: Colors.red,
                    label: 'Calories Left',
                    infoText: "You're left to complete your set target.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.red,
                dotColor: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
              icon: Icons.calendar_today,
              label: 'Today',
              isActive: true,
              activeColor: Colors.teal),
          _buildNavItem(
              icon: Icons.bar_chart,
              label: 'Insights',
              hasBadge: true,
              badgeColor: Color(0xFFFF749A)),
          _buildNavItem(
              icon: Icons.forum,
              label: 'Secret Chats',
              hasBadge: true,
              badgeColor: Color(0xFFFF749A)),
          _buildNavItem(icon: Icons.chat_bubble_outline, label: 'Messages'),
          _buildNavItem(icon: Icons.people, label: 'Partner'),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    bool isActive = false,
    bool hasBadge = false,
    Color activeColor = Colors.black,
    Color? badgeColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Icon(
              icon,
              color: isActive ? activeColor : Colors.grey,
              size: 28,
            ),
            if (hasBadge)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: badgeColor ?? Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: isActive ? activeColor : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
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
