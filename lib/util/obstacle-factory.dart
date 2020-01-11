import 'package:t_rex/components/obstacles/obstacle-type.dart';
import 'package:t_rex/components/obstacles/obstacle.dart';

abstract class ObstacleFactory {
  Obstacle getObstacle(ObstacleType obstacleType);
}
