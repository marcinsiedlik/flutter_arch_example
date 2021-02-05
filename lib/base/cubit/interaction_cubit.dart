import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_arch_example/base/cubit/disposable_state.dart';
import 'package:flutter_arch_example/base/cubit/event_cubit.dart';

abstract class InteractionCubit<E, S extends DisposableState, CMD> extends EventCubit<E, S> {
  InteractionCubit(S state) : super(state);

  final _commandController = StreamController<CMD>();

  Stream<CMD> get command => _commandController.stream;

  @protected
  void emitCommand(CMD command) {
    _commandController.add(command);
  }

  @override
  Future<void> close() {
    state.dispose();
    _commandController.close();
    return super.close();
  }
}
