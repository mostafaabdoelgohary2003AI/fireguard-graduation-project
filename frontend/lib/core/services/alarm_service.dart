import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:vibration/vibration.dart';

/// Singleton service that manages the emergency siren alarm.
///
/// Call [AlarmService().trigger()] to start and [AlarmService().stop()] to stop.
/// The sound loops indefinitely and vibration repeats until explicitly stopped.
class AlarmService {
  AlarmService._internal();
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;

  final AudioPlayer _player = AudioPlayer();
  bool _isActive = false;

  bool get isActive => _isActive;

  // ── Public API ────────────────────────────────────────────────────────────

  /// Starts the looping alarm sound and vibration pattern.
  /// Safe to call multiple times — only the first call takes effect.
  Future<void> trigger() async {
    if (_isActive) return;
    _isActive = true;

    await _startAudio();
    await _startVibration();
  }

  /// Stops the alarm sound and vibration immediately.
  Future<void> stop() async {
    if (!_isActive) return;
    _isActive = false;

    try {
      await _player.stop();
    } catch (e) {
      debugPrint('AlarmService: audio stop error: $e');
    }

    try {
      Vibration.cancel();
    } catch (e) {
      debugPrint('AlarmService: vibration cancel error: $e');
    }
  }

  // ── Private helpers ───────────────────────────────────────────────────────

  Future<void> _startAudio() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.play(AssetSource('sounds/alarm.mp3'));
    } catch (e) {
      // Asset may be missing in early development — fall back to vibration only.
      debugPrint('AlarmService: could not play alarm sound: $e');
    }
  }

  Future<void> _startVibration() async {
    try {
      final hasVibrator = await Vibration.hasVibrator() ?? false;
      if (!hasVibrator) return;

      // Pattern: [wait, vibrate, pause, vibrate, pause, vibrate]  (milliseconds)
      // repeat: 0 = loop the pattern from index 0 indefinitely.
      Vibration.vibrate(
        pattern: [0, 600, 300, 600, 300, 600],
        repeat: 0,
      );
    } catch (e) {
      debugPrint('AlarmService: vibration error: $e');
    }
  }
}
