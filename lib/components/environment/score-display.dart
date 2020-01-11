import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:t_rex/trex-game.dart';

class ScoreDisplay {
  TRexGame _game;

  TextPainter _painter;
  TextStyle _textStyle;
  Offset _position;

  ScoreDisplay(this._game) {
    _painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    _textStyle = TextStyle(
      color: Color(0xffffffff),
      fontSize: 90,
      shadows: <Shadow>[
        Shadow(
          blurRadius: 7,
          color: Color(0xff000000),
          offset: Offset(3, 3),
        ),
      ],
    );

    _position = Offset.zero;
  }

  void render(Canvas canvas) {
    _painter.paint(canvas, _position);
  }

  void update(double t) {
    if ((_painter.text?.text ?? '') != _game.scoreController.score.toString()) {
      _painter.text = TextSpan(
        text: _game.scoreController.score.toString(),
        style: _textStyle,
      );

      _painter.layout();

      _position = Offset(
        (_game.screenSize.width * .1) - (_painter.width / 2),
        (_game.screenSize.height * .1) - (_painter.height / 2),
      );
    }
  }
}
