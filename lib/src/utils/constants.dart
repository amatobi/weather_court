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
