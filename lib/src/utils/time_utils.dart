
enum TimeOfTheDay { morning, afternoon, evening }

TimeOfTheDay timeOfTheDay() {
  var hour = DateTime.now().hour;

  if (hour < 12) return TimeOfTheDay.morning;
  if (hour < 18) return TimeOfTheDay.afternoon;

  return TimeOfTheDay.evening;
}
