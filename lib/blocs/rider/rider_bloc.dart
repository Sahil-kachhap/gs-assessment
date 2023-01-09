import 'package:bloc/bloc.dart';
import 'package:rider_app/data/models/manager.dart';
import 'package:rider_app/data/models/rider.dart';

part 'rider_event.dart';
part 'rider_state.dart';

class RiderBloc extends Bloc<RiderEvent, RiderState> {
  RiderBloc() : super(RiderLoading()) {
    on<LoadRidersEvent>((event, emit) {
      emit(RiderLoading());
      Manager manager = Manager();
      List<Rider> riders = manager.getRiders();
      emit(RiderLoadedState(riders: riders));
    });
  }
}
