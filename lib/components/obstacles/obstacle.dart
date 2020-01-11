import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/util/observer.dart';
import 'package:t_rex/trex-game.dart';

abstract class Obstacle extends Observer {
  final TRexGame _game;
  Map<Daytime, List<Sprite>> sprites;
  double spriteIndex = 0;
  Rect hitbox;
  bool _isOffScreen = false;

  Daytime daytime;

  double _xPos;
  double _yPos;

  double width;
  double height;

  double _speed;

  bool get isOffScreen => _isOffScreen;

  double get left => _xPos;
  double get right => _xPos + width;
  double get top => _yPos;
  double get bottom => _yPos + height;

  Obstacle(this._game, this._xPos, this._yPos, this.width, this.height) {
    _speed = 5 * _game.tileSize;
    daytime = Daytime.Day;
  }

  void render(Canvas canvas);

  void update(double t) {
    // animation
    spriteIndex += 6 * t;
    while (spriteIndex >= sprites[daytime].length) {
      spriteIndex -= sprites[daytime].length;
    }

    // movement
    double stepDistance = -_speed * t;
    _xPos += stepDistance;
    hitbox = Rect.fromLTWH(_xPos, _yPos, width, height);

    if (hitbox.right < 0) {
      _isOffScreen = true;
    }
  }

  void notify(Daytime daytime) {
    this.daytime = daytime;
  }
}
