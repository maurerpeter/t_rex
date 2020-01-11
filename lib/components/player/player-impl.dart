import 'dart:math';
import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';
import 'package:t_rex/components/player/player.dart';
import 'package:t_rex/trex-game.dart';

class PlayerImpl extends Player {
  final TRexGame _game;

  Paint _playerPaint;
  Rect hitbox;

  Map<Daytime, List<Sprite>> sprites;
  double spriteIndex = 0;

  double _xPos;
  double _yPos;

  double _width;
  double _height;

  double _ySpeed;
  double _ySpeedLimit;

  double _gravity;
  double _groundLevel;

  Daytime _daytime;

  bool get _isJumping => !(_ySpeed == 0 && bottom == _groundLevel);

  double get left => _xPos;
  double get right => _xPos + _width;
  double get top => _yPos;
  double get bottom => _yPos + _height;

  PlayerImpl(this._game, this._xPos, this._yPos) {
    _playerPaint = Paint();
    _playerPaint.color = Color(0xffff0000);

    _ySpeed = 0;
    _ySpeedLimit = _game.tileSize * 13;

    _width = _game.tileSize * 1.5;
    _height = 2 * _game.tileSize;

    hitbox = Rect.fromLTWH(_xPos, _yPos, _width, _height);

    _gravity = _game.tileSize / 3;
    _groundLevel = _game.screenSize.height - _game.tileSize;

    sprites = Map<Daytime, List<Sprite>>();
    sprites[Daytime.Day] = [
      Sprite('player/trex_0_day.png'),
      Sprite('player/trex_1_day.png')
    ];
    sprites[Daytime.Night] = [
      Sprite('player/trex_0_night.png'),
      Sprite('player/trex_1_night.png')
    ];
    _daytime = Daytime.Day;
  }

  void render(Canvas canvas) {
    hitbox = Rect.fromLTWH(_xPos, _yPos, _width, _height);
    sprites[_daytime][spriteIndex.toInt()].renderRect(canvas, hitbox);
  }

  void update(double t) {
    spriteIndex += 6 * t;
    while (spriteIndex >= sprites[_daytime].length) {
      spriteIndex -= sprites[_daytime].length;
    }
    spriteIndex = _isJumping ? 1 : spriteIndex;

    _updateVerticalMovement(t);
  }

  void _updateVerticalMovement(double t) {
    _yPos += _ySpeed * t;
    if (bottom > _groundLevel) {
      _yPos = _groundLevel - _height;
      _ySpeed = 0;
    }
    if (bottom < _groundLevel) {
      _ySpeed += _gravity;
      _ySpeed = _ySpeed.abs() > _ySpeedLimit ? _ySpeedLimit : _ySpeed;
    }
  }

  void jump() {
    _ySpeed = !_isJumping ? -_ySpeedLimit : _ySpeed;
  }

  bool collides(Obstacle obstacle) {
    if ((this.left <= obstacle.right && this.left >= obstacle.left) ||
        (this.right >= obstacle.left && this.right <= obstacle.right)) {
      // obstacle is colliding with player vertically
      if ((this.top <= obstacle.bottom && this.top >= obstacle.top) ||
          (this.bottom >= obstacle.top && this.bottom <= obstacle.bottom)) {
        // obstacle is colliding with player horizontally
        return true;
      }
    }

    return false;
  }

  void notify(Daytime daytime) {
    setDaytime(daytime);
  }

  void setDaytime(Daytime daytime) {
    _daytime = daytime;
  }
}
