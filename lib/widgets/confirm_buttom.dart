
import 'dart:math';

import 'package:flutter/material.dart';

class ConfirmButton extends StatefulWidget {
  final bool? _isCorrect;
  final dynamic _onClick;
  final bool _enabled;

  ConfirmButton({isCorrect, onClick, enabled = true})
      : _isCorrect = isCorrect,
        _onClick = onClick,
        _enabled = enabled;

  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void didUpdateWidget(covariant ConfirmButton oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double value = Curves.ease.transform(_controller.value);

        switch (widget._isCorrect) {
          case false:
            return _wrongAnswerAnimation(value);
          case true:
            return _correctAnswerAnimation(value);
          default:
            return _defaultState();
        }
      },
    );
  }

  


  _wrongAnswerAnimation(value) {
    return Transform.translate(
      offset: Offset(cos(3 * pi * value) * 30 * (1 - value), 0),
      child: Card(
        color: widget._enabled ? Color.lerp(Colors.redAccent, Colors.blueAccent, value) : Colors.grey[300],
        child: InkWell(
          onTap: widget._enabled ? _onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Icon(
              Icons.check,
              size: 32,
              color: widget._enabled ? Color.lerp(Colors.black, Colors.white, value) : Colors.grey ,
            ),
          ),
        ),
      ),
    );
  }

  _correctAnswerAnimation(value) {
    return Card(
      color: widget._enabled ? Color.lerp(Colors.blueAccent, Colors.green, value) : Colors.grey[300],
      child: InkWell(
          onTap: widget._enabled ? _onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Icon(
            Icons.check,
            size: 32,
            color: widget._enabled ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }

_defaultState() {
    return Card(
      color: widget._enabled ? Colors.blueAccent : Colors.grey[300],
      child: InkWell(
          onTap: widget._enabled ? _onTap : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Icon(
            Icons.check,
            size: 32,
            color: widget._enabled ? Colors.white : Colors.grey,
          ),
        ),
      ),
    );
  }
  

  _onTap() {
    if (widget._onClick != null) widget._onClick();
    _controller.forward(from: 0);
  }
}
