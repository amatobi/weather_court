import 'package:flutter_bloc/flutter_bloc.dart';


class LoadingLocationCubit extends Cubit<bool> {
  LoadingLocationCubit() : super(false);

  isLoading(bool isLoading){
    emit(isLoading);
  }
}
