import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_arch_example/base/widget/interaction_widget.dart';
import 'package:flutter_arch_example/feature/counter/counter_cubit.dart';
import 'package:flutter_arch_example/feature/counter/interaction/counter_command.dart';
import 'package:flutter_arch_example/feature/counter/interaction/counter_event.dart';
import 'package:flutter_arch_example/feature/counter/interaction/counter_state.dart';

class CounterPage extends InteractionWidget<CounterCubit, CounterEvent, CounterState, CounterCommand> {
  // get_it or other di solution, params passing
  @override
  CounterCubit create(BuildContext context) => CounterCubit();

  @override
  Widget buildWidget(BuildContext context, CounterCubit bloc, CounterState state) {
    return Scaffold(
      body: Center(
        child: Text('Times clicked: ${state.timesClicked}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => bloc.add(const CounterEvent.plusClicked()),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void onCommand(BuildContext context, CounterCommand command) {
    command.when(
      showDialog: (message) {
        showDialog<void>(
          context: context,
          builder: (context) => _buildInfoDialog(context, message),
        );
      },
    );
  }

  Widget _buildInfoDialog(BuildContext context, String message) {
    return AlertDialog(
      title: const Text('Congrats!'),
      content: Text(message),
    );
  }
}
