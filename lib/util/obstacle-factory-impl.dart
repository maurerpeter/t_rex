import 'package:t_rex/components/obstacles/big-cactus-obstacle.dart';
import 'package:t_rex/components/obstacles/bird-obstacle.dart';
import 'package:t_rex/components/obstacles/obstacle-type.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';
import 'package:t_rex/components/obstacles/small-cactus-obstacle.dart';
import 'package:t_rex/util/obstacle-factory.dart';
import 'package:t_rex/trex-game.dart';

class ObstacleFactoryImpl extends ObstacleFactory {
  final TRexGame _game;

  ObstacleFactoryImpl(this._game);

  Obstacle getObstacle(ObstacleType obstacleType) {
    double x = _game.screenSize.width;
    double y = 0;
    switch (obstacleType) {
      case ObstacleType.SmallCactus:
        y = _game.screenSize.height - _game.tileSize * 2;
        return SmallCactusObstacle(_game, x, y);

      case ObstacleType.BigCactus:
        y = _game.screenSize.height - _game.tileSize * 3;
        return BigCactusObstacle(_game, x, y);

      case ObstacleType.Bird:
        y = _game.screenSize.height - _game.tileSize * 3;
        return BirdObstacle(_game, x, y);

      default:
        y = _game.screenSize.height - _game.tileSize * 2;
        return SmallCactusObstacle(_game, x, y);
    }
  }
}
