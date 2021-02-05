import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_event.freezed.dart';

@freezed
abstract class CounterEvent with _$CounterEvent {
  const factory CounterEvent.plusClicked() = _PlusClicked;
}
