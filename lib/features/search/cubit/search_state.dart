part of 'search_cubit.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchInitializing extends SearchState {}

class SearchInitialized extends SearchState {}

class SearchInitializationFailed extends SearchState {
  final String error;
  SearchInitializationFailed({required this.error});
}

class StartToListeningState extends SearchState {}

class SpeechToTextLoaded extends SearchState {
  final String text;
  SpeechToTextLoaded({required this.text});
}

class StopToListeningState extends SearchState {}

class SpeechToTextError extends SearchState {
  final String error;
  SpeechToTextError({required this.error});
}