part of 'internet_connectivity_cubit.dart';

abstract class InternetConnectionState extends Equatable {
  const InternetConnectionState();

  @override
  List<Object> get props => [];

}

class Initial extends InternetConnectionState {

   @override
  List<Object> get props => [];
}

class Connected extends InternetConnectionState {

   @override
  List<Object> get props => [];
}

class Disconnected extends InternetConnectionState {
   @override
  List<Object> get props => [];
}
