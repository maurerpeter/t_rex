import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:t_rex/components/player/player-decorator.dart';
import 'package:t_rex/components/player/player.dart';

class PlayerRedEyeDecorator extends PlayerDecorator {
  Sprite _sprite;

  PlayerRedEyeDecorator(Player player) : super(player) {
    _sprite = Sprite('player/trex_decorator_red_eye_0.png');
  }

  void render(Canvas canvas) {
    super.render(canvas);
    _sprite.renderRect(canvas, hitbox);
  }
}
