import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class AccountBloc extends Bloc<DefaultAccountEvent, String> {
  AccountBloc() : super("") {
    on<DefaultAccountEvent>((event, emit) {
      if (event is SetAccountEvent) {
        emit(event.name);
      }
    });
  }
}

// event
abstract class DefaultAccountEvent extends Equatable {}

class SetAccountEvent extends DefaultAccountEvent {
  final String name;

  SetAccountEvent({required this.name});

  @override
  List<Object> get props => [name];
}
