import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyFlameGame extends FlameGame {
  @override
  Color backgroundColor() => Colors.pink;

  var hunter = SpriteComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    hunter
      ..sprite = await loadSprite('hunter.png')
      ..size = Vector2.all(200);
    add(hunter);
  }

  @override
  void update(double dt) {
    hunter.position += Vector2.all(20) * dt;
    super.update(dt);
  }
}
