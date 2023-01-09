part of 'rider_bloc.dart';

abstract class RiderState {}

class RiderLoading extends RiderState {}

class RiderLoadedState extends RiderState{
  List<Rider>? riders;

  RiderLoadedState({this.riders});
}
