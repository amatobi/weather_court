import 'package:flutter_bloc/flutter_bloc.dart';


class SelectedItemCubit extends Cubit<int> {
  SelectedItemCubit() : super(0);

  selectItem(int selectedWeatherIndex){
    emit(selectedWeatherIndex);
  }
}
