import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_arch_example/base/cubit/disposable_state.dart';
import 'package:flutter_arch_example/base/cubit/interaction_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BlocCommandCallback<C extends InteractionCubit<E, S, CMD>, E, S extends DisposableState, CMD> = void Function(
    BuildContext context, CMD command);

class BlocCommandListener<C extends InteractionCubit<E, S, CMD>, E, S extends DisposableState, CMD>
    extends StatefulWidget {
  final Widget child;
  final C cubit;
  final BlocCommandCallback<C, E, S, CMD> listener;

  const BlocCommandListener({
    Key key,
    this.cubit,
    @required this.listener,
    @required this.child,
  }) : super(key: key);

  @override
  _BlocCommandListenerState createState() => _BlocCommandListenerState<C, E, S, CMD>();
}

class _BlocCommandListenerState<C extends InteractionCubit<E, S, CMD>, E, S extends DisposableState, CMD>
    extends State<BlocCommandListener<C, E, S, CMD>> {
  StreamSubscription<CMD> _streamSubscription;
  Stream<CMD> _previousStream;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = widget.cubit ?? context.read<C>();
    if (cubit.command != _previousStream) {
      _streamSubscription?.cancel();
      _previousStream = cubit.command;
      _subscribe(cubit.command);
    }
  }

  void _subscribe(Stream<CMD> stream) {
    _streamSubscription = stream.listen((command) {
      widget.listener(context, command);
    });
  }

  void _unsubscribe() {
    if (_streamSubscription != null) {
      _streamSubscription.cancel();
      _streamSubscription = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }
}
