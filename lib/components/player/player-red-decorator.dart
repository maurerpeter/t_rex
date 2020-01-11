import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/player/player-decorator.dart';
import 'package:t_rex/components/player/player.dart';

class PlayerRedDecorator extends PlayerDecorator {
  List<Sprite> _sprite;

  PlayerRedDecorator(Player player) : super(player) {
    _sprite = [
      Sprite('player/trex_decorator_red_0.png'),
      Sprite('player/trex_decorator_red_1.png')
    ];
  }

  void render(Canvas canvas) {
    super.render(canvas);
    _sprite[spriteIndex.toInt()].renderRect(canvas, hitbox);
  }
}
