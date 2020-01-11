import 'package:t_rex/util/observer.dart';
import 'package:t_rex/trex-game.dart';

class ObstacleSpawner extends Observer {
  final TRexGame _game;

  final int _maxSpawnInterval = 5000;
  final int _minSpawnInterval = 2500;
  final int _intervalChange = 3;

  int _currentInterval;
  int _nextSpawn;

  Daytime _daytime;

  ObstacleSpawner(this._game) {
    _daytime = Daytime.Day;
    _start();
  }

  void _start() {
    _game.spawnObstacle(_daytime);
    _currentInterval = _maxSpawnInterval;
    _nextSpawn = DateTime.now().millisecondsSinceEpoch + _currentInterval;
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    if (nowTimestamp >= _nextSpawn) {
      _game.spawnObstacle(_daytime);
      if (_currentInterval > _minSpawnInterval) {
        _currentInterval -= _intervalChange;
        _currentInterval -= (_currentInterval * .02).toInt();
      }
      _nextSpawn = nowTimestamp + _currentInterval;
    }
  }

  void notify(Daytime daytime) {
    _daytime = daytime;
  }
}
