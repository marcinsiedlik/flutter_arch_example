import 'package:flutter_arch_example/base/cubit/interaction_cubit.dart';
import 'package:flutter_arch_example/feature/counter/interaction/counter_command.dart';
import 'package:flutter_arch_example/feature/counter/interaction/counter_event.dart';
import 'package:flutter_arch_example/feature/counter/interaction/counter_state.dart';

class CounterCubit extends InteractionCubit<CounterEvent, CounterState, CounterCommand> {
  CounterCubit() : super(CounterState.initial());

  @override
  Future<void> onEvent(CounterEvent event) async {
    event.when(
      plusClicked: _onPlusClicked,
    );
  }

  //some super advanced logic
  void _onPlusClicked() {
    emit(state.copyWith(timesClicked: state.timesClicked + 1));
    if (state.timesClicked % 5 == 0) {
      emitCommand(CounterCommand.showDialog('Yay! You clicked me ${state.timesClicked} times!'));
    }
  }
}
