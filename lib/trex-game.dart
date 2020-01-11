import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:t_rex/components/environment/background.dart';
import 'package:t_rex/components/environment/score-display.dart';
import 'package:t_rex/components/obstacles/obstacle-type.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';
import 'package:t_rex/components/player/player-impl.dart';
import 'package:t_rex/components/player/player.dart';
import 'package:t_rex/controllers/daytime-observable.dart';
import 'package:t_rex/controllers/obstacle-spawner.dart';
import 'package:t_rex/controllers/score-controller.dart';
import 'package:t_rex/util/obstacle-factory-impl.dart';
import 'package:t_rex/util/obstacle-factory.dart';

enum Daytime { Day, Night }

class TRexGame extends BaseGame {
  Size _screenSize;
  double _tileSize;

  Random _random;

  Background _background;

  ObstacleFactory _obstacleFactory;
  ObstacleSpawner _obstacleSpawner;
  List<Obstacle> _obstacles;

  DaytimeObservable _daytimeObservable;

  ScoreController _scoreController;
  ScoreDisplay _scoreDisplay;

  Player player;

  TRexGame() {
    _initialize();
  }

  void _initialize() async {
    resize(await Flame.util.initialDimensions());

    _background = Background(this);

    player = PlayerImpl(this, _screenSize.width / 3, _screenSize.height / 2);

    _obstacles = List<Obstacle>();

    _random = Random();

    _daytimeObservable = DaytimeObservable([_background, player]);

    _obstacleFactory = ObstacleFactoryImpl(this);
    _obstacleSpawner = ObstacleSpawner(this);
    _daytimeObservable.addObserver(_obstacleSpawner);

    _scoreController = ScoreController(this);
    _scoreDisplay = ScoreDisplay(this);
  }

  void spawnObstacle(Daytime daytime) {
    Obstacle newObstacle = _obstacleFactory.getObstacle(_guessObstacleType());
    newObstacle.daytime = daytime;
    _obstacles.add(newObstacle);
    _daytimeObservable.addObserver(newObstacle);
  }

  ObstacleType _guessObstacleType() {
    switch (_random.nextInt(3)) {
      case 0:
        {
          return ObstacleType.SmallCactus;
        }
      case 1:
        {
          return ObstacleType.BigCactus;
        }
      case 2:
        {
          return ObstacleType.Bird;
        }
      default:
        {
          return ObstacleType.SmallCactus;
        }
    }
  }

  void resize(Size size) {
    super.resize(size);
    _screenSize = size;
    _tileSize = screenSize.width / 15;
  }

  void render(Canvas canvas) {
    _background.render(canvas);
    player.render(canvas);
    _obstacles.forEach((Obstacle obstacle) => obstacle.render(canvas));
    _scoreDisplay.render(canvas);
  }

  void update(double t) {
    _daytimeObservable.update(t);

    _background.update(t);
    player.update(t);
    _obstacles.forEach((Obstacle obstacle) => obstacle.update(t));
    _obstacles.forEach((Obstacle obstacle) {
      if (player.collides(obstacle)) {
        _initialize();
      }
    });
    _obstacles.removeWhere((Obstacle obstacle) {
      if (obstacle.isOffScreen) {
        _daytimeObservable.removeObserver(obstacle);
      }
      return obstacle.isOffScreen;
    });
    _obstacleSpawner.update(t);

    _scoreController.update(t);
    _scoreDisplay.update(t);
  }

  void onTapDown(TapDownDetails details) {
    player.jump();
  }

  Size get screenSize => _screenSize;

  double get tileSize => _tileSize;

  ScoreController get scoreController => _scoreController;
}
