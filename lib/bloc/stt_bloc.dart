import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class SttBloc extends Bloc<DefaultSttEvent, DefaultSttState> {
  SttBloc() : super(const InitSttState()) {
    on<DefaultSttEvent>((event, emit) {
      if (event is InitSttEvent) {
        _initSttEventHandler(event, emit);
      } else if (event is StartListeningSttEvent) {
        _startListeningSttEventHandler(event, emit);
      } else if (event is OnListeningSttEvent) {
        _onListeningSttEventHandler(event, emit);
      }
    });
  }

  void _initSttEventHandler(InitSttEvent event, emit) {
    emit(const InitSttState());
  }

  void _startListeningSttEventHandler(StartListeningSttEvent event, emit) {
    emit(const StartListeningSttState());
  }

  void _onListeningSttEventHandler(OnListeningSttEvent event, emit) {
    emit(OnListeningSttState(text: event.newText));
  }
}

// event
abstract class DefaultSttEvent extends Equatable {}

class InitSttEvent extends DefaultSttEvent {
  InitSttEvent();

  @override
  List<Object> get props => [];
}

class StartListeningSttEvent extends DefaultSttEvent {
  StartListeningSttEvent();

  @override
  List<Object> get props => [];
}

class OnListeningSttEvent extends DefaultSttEvent {
  final String newText;

  OnListeningSttEvent({required this.newText});

  @override
  List<Object> get props => [newText];
}

// state
abstract class DefaultSttState extends Equatable {
  final bool isListening;
  final String text;

  const DefaultSttState({required this.isListening, required this.text});
}

class InitSttState extends DefaultSttState {
  const InitSttState() : super(isListening: false, text: "음성을 입력하세요.");

  @override
  List<Object> get props => [isListening, text];
}

class StartListeningSttState extends DefaultSttState {
  const StartListeningSttState() : super(isListening: true, text: "듣고있어요...");

  @override
  List<Object> get props => [isListening, text];
}

class OnListeningSttState extends DefaultSttState {
  const OnListeningSttState({super.isListening = true, required super.text});

  @override
  List<Object> get props => [isListening, text];
}
