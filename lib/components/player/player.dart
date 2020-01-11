import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';
import 'package:t_rex/util/observer.dart';
import 'package:t_rex/trex-game.dart';

abstract class Player extends Observer {
  Map<Daytime, List<Sprite>> sprites;
  double spriteIndex = 0;
  Rect hitbox;

  void render(Canvas canvas) {}

  void update(double t) {}

  void jump() {}

  bool collides(Obstacle obstacle) => false;

  void notify(Daytime daytime) {}

  void setDaytime(Daytime daytime) {}
}
