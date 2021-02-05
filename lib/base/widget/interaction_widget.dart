import 'package:flutter/material.dart';
import 'package:flutter_arch_example/base/cubit/disposable_state.dart';
import 'package:flutter_arch_example/base/cubit/interaction_cubit.dart';
import 'package:flutter_arch_example/base/widget/bloc_command_listener.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class InteractionWidget<C extends InteractionCubit<E, S, CMD>, E, S extends DisposableState, CMD>
    extends StatelessWidget {
  const InteractionWidget({Key key}) : super(key: key);

  C create(BuildContext context);

  void onCommand(BuildContext context, CMD command);

  Widget buildWidget(BuildContext context, C bloc, S state);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: create,
      child: BlocCommandListener<C, E, S, CMD>(
        listener: onCommand,
        child: BlocBuilder<C, S>(
          builder: (context, state) => buildWidget(context, context.watch<C>(), state),
        ),
      ),
    );
  }
}
