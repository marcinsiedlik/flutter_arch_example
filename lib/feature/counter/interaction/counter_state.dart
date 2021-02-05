import 'package:flutter/material.dart';
import 'package:flutter_arch_example/base/cubit/disposable_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_state.freezed.dart';

@freezed
abstract class CounterState extends DisposableState implements _$CounterState {
  const factory CounterState({
    ScrollController scrollController,
    int timesClicked,
  }) = _CounterState;

  const CounterState._();

  factory CounterState.initial() => CounterState(
        scrollController: ScrollController(),
        timesClicked: 0,
      );

  @override
  void dispose() {
    scrollController.dispose();
  }
}
