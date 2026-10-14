// =============================================================
// Session 3 | Part 3 (helper file): the Speaker class
//
// This class lives in its OWN file on purpose.
// In Dart, privacy (a name starting with `_`) works per LIBRARY,
// and every .dart file is one library. So the private members below
// are really hidden from 03_encapsulation.dart, which imports this file.
//
// You do not run this file directly. Run 03_encapsulation.dart.
// =============================================================

class Speaker {
  // Private fields: only code inside THIS file can touch them.
  int _volume;
  bool _isMuted = false;
  final List<int> _history = [];

  /// Optional positional parameter with a default value.
  Speaker([int volume = 30]) : _volume = volume {
    _validate(volume);
  }

  // ---------------- Getter: read-only access ----------------
  int get volume => _isMuted ? 0 : _volume;

  bool get isMuted => _isMuted;

  // ---------------- Setter: controlled write access ----------------
  /// Assigning `speaker.volume = 50` runs this code,
  /// so we can reject invalid values.
  set volume(int value) {
    _validate(value);
    _history.add(_volume); // remember the previous volume
    _volume = value;
    _isMuted = false;
  }

  // ---------------- Computed getter ----------------
  String get level {
    if (_isMuted || _volume == 0) return 'silent';
    if (_volume < 30) return 'low';
    if (_volume < 70) return 'medium';
    return 'loud';
  }

  /// Returns a read-only copy: outside code cannot add or remove items.
  List<int> get history => List.unmodifiable(_history);

  // ---------------- Public methods ----------------
  void mute() => _isMuted = true;
  void unmute() => _isMuted = false;

  void louder([int step = 10]) {
    // Reuse the setter so the validation rule stays in ONE place.
    volume = (_volume + step > 100) ? 100 : _volume + step;
  }

  // ---------------- Private method ----------------
  void _validate(int value) {
    if (value < 0 || value > 100) {
      throw ArgumentError('Volume must be between 0 and 100 (got $value)');
    }
  }

  @override
  String toString() => 'Speaker(volume: $volume, level: $level)';
}
