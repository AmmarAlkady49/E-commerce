import 'dart:developer';

import 'package:e_commerce_graduation/features/search/services/search_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial()) {
    // initSpeechToText();
  }

  final SearchServices _searchServices = SearchServices();

  bool get isListening => _searchServices.isListening;
  bool get isNotListening => _searchServices.isNotListening;
  String get spokenText => _searchServices.spokenText;
  String? _lastError;
  String? get error => _lastError;
  final locale = WidgetsBinding.instance.platformDispatcher.locale;
  Future<void> initSpeechToText() async {
    try {
      emit(SearchInitializing());
      log('Initializing speech to text...');

      final isInitialized = await _searchServices.initSpeech();

      if (isInitialized) {
        emit(SearchInitialized());
        log('Speech to text initialized successfully');
      } else {
        _lastError = locale.languageCode == 'en'
            ? "Speech recognition not available on this device"
            : "التشغيل الصوتي غير متوفر على هذا الجهاز";
        emit(SearchInitializationFailed(error: _lastError!));
        log('Speech to text initialization failed: $_lastError');
      }
    } catch (e) {
      _lastError = e.toString();
      emit(SearchInitializationFailed(error: _lastError!));
      log('Speech to text initialization error: $_lastError');
    }
  }

  Future<void> startListening() async {
    try {
      _lastError = null;
      emit(StartToListeningState());
      log('Starting to listen...');

      await _searchServices.startListening((recognizedText) {
        emit(SpeechToTextLoaded(text: recognizedText));
        log('Recognized text: $recognizedText');
      });
    } catch (e) {
      _lastError = e.toString();
      emit(SpeechToTextError(error: _lastError!));
      log('Speech to text error: $_lastError');
    }
  }

  Future<void> stopListening() async {
    try {
      await _searchServices.stopListening();
      emit(StopToListeningState());
      log('Stopped listening');
    } catch (e) {
      _lastError = e.toString();
      emit(SpeechToTextError(error: _lastError!));
      log('Error stopping speech recognition: $_lastError');
    }
  }

  @override
  Future<void> close() {
    _searchServices.dispose();
    return super.close();
  }
}
