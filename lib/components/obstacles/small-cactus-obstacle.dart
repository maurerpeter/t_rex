import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';
import 'package:t_rex/trex-game.dart';

class SmallCactusObstacle extends Obstacle {
  SmallCactusObstacle(TRexGame game, double x, double y)
      : super(game, x, y, game.tileSize, game.tileSize) {
    sprites = Map<Daytime, List<Sprite>>();
    sprites[Daytime.Day] = [Sprite('obstacles/small_cactus_0_day.png')];
    sprites[Daytime.Night] = [Sprite('obstacles/small_cactus_0_night.png')];
    hitbox = Rect.fromLTWH(x, y, width, height);
  }

  void render(Canvas canvas) {
    sprites[daytime][spriteIndex.toInt()]
        .renderRect(canvas, hitbox.inflate(10));
  }
}
