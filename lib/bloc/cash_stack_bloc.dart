import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CashStackBloc extends Bloc<DefaultCashStackEvent, int> {
  CashStackBloc() : super(13) {
    on<DefaultCashStackEvent>((event, emit) {
      if (event is IncreaseCashStackEvent) {
        emit(state + 1);
      }
    });
  }
}

// event
abstract class DefaultCashStackEvent extends Equatable {}

class IncreaseCashStackEvent extends DefaultCashStackEvent {
  IncreaseCashStackEvent();

  @override
  List<Object> get props => [];
}
