import 'package:speech_to_text/speech_to_text.dart';

class SearchServices {
  final SpeechToText _speechToText = SpeechToText();
  String _lastWords = '';

  bool get isInitialized => _speechToText.isAvailable;
  bool get isListening => _speechToText.isListening;
  bool get isNotListening => !_speechToText.isListening;
  String get spokenText => _lastWords;

  Future<bool> initSpeech() async {
    try {
      final available = await _speechToText.initialize(
        onError: (error) => throw Exception(error.errorMsg),
        debugLogging: true,
      );
      return available;
    } catch (e) {
      rethrow; // Let the cubit handle this error
    }
  }

  Future<void> startListening(Function(String) onResultCallback) async {
    try {
      if (!isInitialized) {
        throw Exception("Speech recognition not initialized");
      }

      await _speechToText.listen(
        onResult: (result) {
          _lastWords = result.recognizedWords;
          onResultCallback(_lastWords);
        },
        localeId: "ar-EG",
        listenOptions: SpeechListenOptions(
          listenMode: ListenMode.dictation,
          cancelOnError: true,
        ),
      );
    } catch (e) {
      rethrow; 
    }
  }

  Future<void> stopListening() async {
    try {
      await _speechToText.stop();
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    _speechToText.cancel();
  }
}
