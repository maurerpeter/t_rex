import 'package:t_rex/util/observer.dart';
import 'package:t_rex/trex-game.dart';

class DaytimeObservable {
  final int _changeInterval = 12000;

  List<Observer> _observers;
  Daytime _currentDaytime;

  int _nextChange;

  DaytimeObservable(this._observers) {
    _currentDaytime = Daytime.Day;
    _start();
  }

  void _start() {
    _nextChange = DateTime.now().millisecondsSinceEpoch + _changeInterval;
  }

  void update(double t) {
    int nowTimestamp = DateTime.now().millisecondsSinceEpoch;

    if (nowTimestamp >= _nextChange) {
      _currentDaytime =
          _currentDaytime == Daytime.Day ? Daytime.Night : Daytime.Day;
      _observers
          .forEach((Observer observer) => observer.notify(_currentDaytime));
      _nextChange = nowTimestamp + _changeInterval;
    }
  }

  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    if (_observers.contains(observer)) {
      _observers.remove(observer);
    }
  }
}
