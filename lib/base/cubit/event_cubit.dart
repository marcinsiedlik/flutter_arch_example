import 'package:flutter_bloc/flutter_bloc.dart';

abstract class EventCubit<Event, State> extends Cubit<State> {
  EventCubit(State state) : super(state);

  Future<void> onEvent(Event event);

  set state(State value) {
    emit(value);
  }

  // ignore: avoid_void_async
  void add(Event event) async {
    await onEvent(event);
  }
}
