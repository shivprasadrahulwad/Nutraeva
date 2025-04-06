import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;



class CountdownPage extends StatelessWidget {
  const CountdownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My workout plan'),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  '1. Running',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Time:'),
                Row(
                  children: [
                    const Icon(Icons.chevron_left),
                    const Text('20min'),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: CountdownTimer(
              durationInSeconds: 20 * 1, // 20 minutes
              progressGradient: const [
                Color(0xFF6750A4),  // Purple
                Color(0xFF9C27B0),  // Mid purple
                Color(0xFF3F51B5),  // Indigo
              ],
              onComplete: () {
                // Handle timer completion
              },
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'Next exercise',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final int durationInSeconds;
  final VoidCallback? onComplete;
  final double size;
  final List<Color> progressGradient;
  final Color backgroundColor;

  const CountdownTimer({
    Key? key,
    required this.durationInSeconds,
    this.onComplete,
    this.size = 250,
    this.progressGradient = const [
      Color(0xFF6750A4),  // Start with purple
      Color(0xFF9C27B0),  // Mid purple
      Color(0xFF3F51B5),  // End with indigo
    ],
    this.backgroundColor = const Color(0xFFE6E0E9), // Light gray background
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> with SingleTickerProviderStateMixin {
  late Timer _timer;
  late int _remainingSeconds;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.durationInSeconds;
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          _isRunning = false;
          if (widget.onComplete != null) {
            widget.onComplete!();
          }
        }
      });
    });
  }

  void pauseTimer() {
    if (_isRunning) {
      _timer.cancel();
      setState(() {
        _isRunning = false;
      });
    }
  }

  void resetTimer() {
    if (_isRunning) {
      _timer.cancel();
    }
    setState(() {
      _remainingSeconds = widget.durationInSeconds;
      _isRunning = false;
    });
  }

  String get timeDisplay {
    final hours = (_remainingSeconds ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((_remainingSeconds % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (_remainingSeconds / widget.durationInSeconds);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background track
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: TimerPainter(
                  progress: 1.0,
                  color: widget.backgroundColor,
                  strokeWidth: 10,
                ),
              ),
              // Progress indicator with gradient
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: GradientTimerPainter(
                  progress: progress,
                  gradientColors: widget.progressGradient,
                  strokeWidth: 10,
                ),
              ),
              // Tick marks
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: TickMarksPainter(
                  count: 60,
                  color: Colors.black26,
                ),
              ),
              // Center content with shoe icon and time
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.directions_run,
                    size: 40,
                    color: Colors.indigo,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    timeDisplay,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              // Glowing effect (optional)
              if (progress > 0.05)
                CustomPaint(
                  size: Size(widget.size, widget.size),
                  painter: GlowEffectPainter(
                    progress: progress,
                    color: widget.progressGradient.last.withOpacity(0.2),
                    strokeWidth: 15,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        // Control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pause button
            _ControlButton(
              onPressed: _isRunning ? pauseTimer : null,
              child: Icon(Icons.pause, color: _isRunning ? Colors.indigo : Colors.grey),
            ),
            const SizedBox(width: 16),
            // Start button
            _ControlButton(
              onPressed: !_isRunning ? startTimer : null,
              backgroundColor: const Color(0xFFE7F8F3),
              gradient: _isRunning ? null : LinearGradient(
                colors: [Color(0xFFE7F8F3), Color(0xFFCCF1E6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: Text(
                "START",
                style: TextStyle(
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16),
            // Stop/Reset button
            _ControlButton(
              onPressed: resetTimer,
              child: Icon(Icons.stop, color: Colors.indigo),
            ),
          ],
        ),
      ],
    );
  }
}


class TickMarksPainter extends CustomPainter {
  final int count;
  final Color color;

  TickMarksPainter({
    required this.count,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    
    final outerRadius = radius;
    final innerRadius = radius - 5;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < count; i++) {
      final angle = (i / count) * 2 * math.pi;
      final isLongTick = i % 5 == 0;
      
      final innerPoint = Offset(
        center.dx + (innerRadius + (isLongTick ? -3 : 0)) * math.cos(angle),
        center.dy + (innerRadius + (isLongTick ? -3 : 0)) * math.sin(angle),
      );
      
      final outerPoint = Offset(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle),
      );
      
      canvas.drawLine(innerPoint, outerPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant TickMarksPainter oldDelegate) {
    return oldDelegate.count != count || oldDelegate.color != color;
  }
}

// Custom painter for the timer circle with a gradient
class GradientTimerPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;
  final double strokeWidth;

  GradientTimerPainter({
    required this.progress,
    required this.gradientColors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    
    // Create a sweep gradient that rotates with the progress
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + (2 * math.pi),
        colors: gradientColors,
        tileMode: TileMode.clamp,
      ).createShader(rect);

    // Draw the arc from top center (- pi/2) clockwise
    canvas.drawArc(
      rect,
      -math.pi / 2, // Start from top (negative pi/2)
      progress * 2 * math.pi, // Full circle is 2*pi
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GradientTimerPainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.gradientColors != gradientColors ||
           oldDelegate.strokeWidth != strokeWidth;
  }
}

// Original timer painter (kept for the background track)
class TimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  TimerPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw the arc from top center (- pi/2) clockwise
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top (negative pi/2)
      progress * 2 * math.pi, // Full circle is 2*pi
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant TimerPainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.color != color ||
           oldDelegate.strokeWidth != strokeWidth;
  }
}

// Add glow effect painter for extra visual appeal
class GlowEffectPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  GlowEffectPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;
    
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 8)
      ..strokeCap = StrokeCap.round;

    // Draw the arc with blur effect
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start from top (negative pi/2)
      progress * 2 * math.pi, // Full circle is 2*pi
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GlowEffectPainter oldDelegate) {
    return oldDelegate.progress != progress || 
           oldDelegate.color != color ||
           oldDelegate.strokeWidth != strokeWidth;
  }
}

// A custom widget for control buttons - updated with gradient support
class _ControlButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Gradient? gradient;

  const _ControlButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor = Colors.white,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: gradient == null ? backgroundColor : null,
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

