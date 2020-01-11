import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';
import 'package:t_rex/trex-game.dart';

class BirdObstacle extends Obstacle {
  BirdObstacle(TRexGame game, double x, double y)
      : super(game, x, y, game.tileSize, game.tileSize) {
    sprites = Map<Daytime, List<Sprite>>();
    sprites[Daytime.Day] = [
      Sprite('obstacles/bird_0_day.png'),
      Sprite('obstacles/bird_1_day.png')
    ];
    sprites[Daytime.Night] = [
      Sprite('obstacles/bird_0_night.png'),
      Sprite('obstacles/bird_1_night.png')
    ];
    hitbox = Rect.fromLTWH(x, y, width, height);
  }

  void render(Canvas canvas) {
    sprites[daytime][spriteIndex.toInt()]
        .renderRect(canvas, hitbox.inflate(10));
  }
}
