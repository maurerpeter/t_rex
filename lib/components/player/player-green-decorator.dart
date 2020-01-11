import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/player/player-decorator.dart';
import 'package:t_rex/components/player/player.dart';

class PlayerGreenDecorator extends PlayerDecorator {
  List<Sprite> _sprites;

  PlayerGreenDecorator(Player player) : super(player) {
    _sprites = [
      Sprite('player/trex_decorator_green_0.png'),
      Sprite('player/trex_decorator_green_1.png')
    ];
  }

  void render(Canvas canvas) {
    super.render(canvas);
    _sprites[spriteIndex.toInt()].renderRect(canvas, hitbox);
  }
}
