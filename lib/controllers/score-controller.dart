import 'package:t_rex/components/player/player-green-decorator.dart';
import 'package:t_rex/components/player/player-red-decorator.dart';
import 'package:t_rex/components/player/player-red-eye-decorator.dart';
import 'package:t_rex/trex-game.dart';

class ScoreController {
  final TRexGame _game;
  List<int> _checkpoints;

  static const int CHECKPOINT_0 = 10;
  static const int CHECKPOINT_1 = 20;
  static const int CHECKPOINT_2 = 30;

  double _timeInSec;
  int _score;

  ScoreController(this._game) {
    _score = 0;
    _timeInSec = 0;
    _checkpoints = List<int>();
    _checkpoints.add(CHECKPOINT_2);
    _checkpoints.add(CHECKPOINT_1);
    _checkpoints.add(CHECKPOINT_0);
  }

  int get score => _score;

  update(double t) {
    _timeInSec += t;
    if (_timeInSec >= 1) {
      _timeInSec -= 1;
      _score += 1;
    }

    if (_checkpoints.isNotEmpty && _score >= _checkpoints.last) {
      _decoratePlayer();
    }
  }

  void _decoratePlayer() {
    int reachedCheckpoint = _checkpoints.removeLast();
    switch (reachedCheckpoint) {
      case CHECKPOINT_0:
        _game.player = PlayerRedEyeDecorator(_game.player);
        break;
      case CHECKPOINT_1:
        _game.player = PlayerGreenDecorator(_game.player);
        break;
      case CHECKPOINT_2:
        _game.player = PlayerRedDecorator(_game.player);
        break;
      default:
        break;
    }
  }
}
