import 'package:flutter/material.dart';
import 'package:weathercourt/src/utils/time_utils.dart';

String timeOfDayBackgroundAsset(TimeOfTheDay timeOfTheDay) {
  switch (timeOfTheDay) {
    case TimeOfTheDay.morning:
      return 'assets/images/morning_background.jpg';
    case TimeOfTheDay.afternoon:
      return 'assets/images/afternoon_background.jpg';
    case TimeOfTheDay.evening:
      return 'assets/images/evening_background.jpg';

    default:
      return 'assets/images/morning_background.jpg';
  }
}
IconData greetingIcon(TimeOfTheDay timeOfTheDay){
  switch (timeOfTheDay) {
    case TimeOfTheDay.morning:
      return Icons.light_mode;
    case TimeOfTheDay.afternoon:
       return Icons.light_mode;
    case TimeOfTheDay.evening:
      return Icons.nights_stay;

    default:
      return Icons.light_mode;
  }

}

String greeting(TimeOfTheDay timeOfTheDay) {
  switch (timeOfTheDay) {
    case TimeOfTheDay.morning:
      return 'Good Morning';
    case TimeOfTheDay.afternoon:
      return 'Good Afternoon';
    case TimeOfTheDay.evening:
      return 'Good Evening';

    default:
      return 'Good Morning';
  }
}
