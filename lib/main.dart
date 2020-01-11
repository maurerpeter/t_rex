import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_rex/trex-game.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flame.images.loadAll(<String>[
    'background/layer_01_1920x1080_day.png',
    'background/layer_01_1920x1080_night.png',
    'background/layer_02_1920x1080_day.png',
    'background/layer_02_1920x1080_night.png',
    'background/layer_03_1920x1080_day.png',
    'background/layer_03_1920x1080_night.png',
    'player/trex_0_day.png',
    'player/trex_0_night.png',
    'player/trex_1_day.png',
    'player/trex_1_night.png',
    'player/trex_decorator_red_eye_0.png',
    'player/trex_decorator_green_0.png',
    'player/trex_decorator_green_1.png',
    'player/trex_decorator_red_0.png',
    'player/trex_decorator_red_1.png',
    'obstacles/small_cactus_0_day.png',
    'obstacles/small_cactus_0_night.png',
    'obstacles/big_cactus_0_day.png',
    'obstacles/big_cactus_0_night.png',
    'obstacles/bird_0_day.png',
    'obstacles/bird_1_day.png',
    'obstacles/bird_0_night.png',
    'obstacles/bird_1_night.png'
  ]);

  Util flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);

  TRexGame game = TRexGame();

  runApp(GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTapDown: game.onTapDown,
    child: game.widget,
  ));
}
