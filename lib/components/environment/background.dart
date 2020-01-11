import 'dart:ui';

import 'package:flame/components/parallax_component.dart';
import 'package:t_rex/util/observer.dart';
import 'package:t_rex/trex-game.dart';

class Background extends Observer {
  final TRexGame _game;

  Map<Daytime, List<ParallaxImage>> _images;

  ParallaxComponent _bgParallax;

  Background(this._game) {
    _images = Map();
    _images[Daytime.Day] = [
      ParallaxImage('background/layer_01_1920x1080_day.png'),
      ParallaxImage('background/layer_02_1920x1080_day.png'),
      ParallaxImage('background/layer_03_1920x1080_day.png')
    ];
    _images[Daytime.Night] = [
      ParallaxImage('background/layer_01_1920x1080_night.png'),
      ParallaxImage('background/layer_02_1920x1080_night.png'),
      ParallaxImage('background/layer_03_1920x1080_night.png')
    ];

    _setDayTime(Daytime.Day);
  }

  void _setDayTime(Daytime daytime) {
    _bgParallax = ParallaxComponent(_images[daytime],
        baseSpeed: const Offset(100, 0), layerDelta: const Offset(20, 0));
    _bgParallax.resize(_game.screenSize);
  }

  void render(Canvas canvas) {
    if (_bgParallax != null) {}
    _bgParallax.render(canvas);
  }

  void update(double t) {
    if (_bgParallax != null) {}
    _bgParallax.update(t);
  }

  void notify(Daytime daytime) {
    _setDayTime(daytime);
  }
}
