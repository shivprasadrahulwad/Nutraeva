// class FitnessData {
//   double progress;
//   int calories;
//   int carbs;
//   int protein;
//   int fat;
//   int goals;

//   FitnessData({
//     required this.progress,
//     required this.calories,
//     required this.carbs,
//     required this.protein,
//     required this.fat,
//     required this.goals,
//   });
// }


class FitnessData {
  double progress;
  int calories;
  int carbs;
  int protein;
  int fat;
  int goals;
  DateTime selectedDate;
  Map<DateTime, bool> workoutDays;

  FitnessData({
    required this.progress,
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
    required this.goals,
    DateTime? selectedDate,
    Map<DateTime, bool>? workoutDays,
  }) : 
    this.selectedDate = selectedDate ?? DateTime.now(),
    this.workoutDays = workoutDays ?? {};

  void toggleWorkoutDay(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    if (workoutDays.containsKey(day)) {
      workoutDays[day] = !(workoutDays[day] ?? false);
    } else {
      workoutDays[day] = true;
    }
  }

  bool isWorkoutDay(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return workoutDays[day] ?? false;
  }
}
