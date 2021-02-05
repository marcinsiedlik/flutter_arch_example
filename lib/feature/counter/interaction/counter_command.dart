import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_command.freezed.dart';

@freezed
abstract class CounterCommand with _$CounterCommand {
  const factory CounterCommand.showDialog(String message) = _ShowDialog;
}
