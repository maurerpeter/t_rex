import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';
import 'package:t_rex/components/player/player.dart';
import 'package:t_rex/trex-game.dart';

abstract class PlayerDecorator extends Player {
  Player _player;

  Rect get hitbox => _player.hitbox;
  Map<Daytime, List<Sprite>> get sprites => _player.sprites;
  double get spriteIndex => _player.spriteIndex;

  PlayerDecorator(this._player);

  void render(Canvas canvas) {
    _player.render(canvas);
  }

  void update(double t) => _player.update(t);

  void jump() => _player.jump();

  bool collides(Obstacle obstacle) => _player.collides(obstacle);

  void notify(Daytime daytime) => _player.notify(daytime);

  void setDaytime(Daytime daytime) => _player.setDaytime(daytime);
}
