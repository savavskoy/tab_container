import 'dart:async';

import 'package:flutter/material.dart';

import '../constants.dart';

class AnimatedImageItem extends StatefulWidget {
  final String firstImageUrl;
  final String secondImageUrl;
  final int index;

  const AnimatedImageItem({
    super.key,
    required this.firstImageUrl,
    required this.secondImageUrl,
    required this.index,
  });

  @override
  AnimatedImageItemState createState() {
    return AnimatedImageItemState();
  }
}

class AnimatedImageItemState extends State<AnimatedImageItem>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late AnimationController _bottomController;
  late AnimationController _topController;
  late Animation<double> _bottomAnimation;
  late Animation<double> _topAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _startAnimation();
  }

  @override
  void dispose() {
    _bottomController.dispose();
    _topController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Stack(
      children: <Widget>[
        AnimatedBuilder(
          animation: _bottomAnimation,
          builder: (context, child) {
            return Positioned(
              top: 400 - (_bottomAnimation.value * 350),
              left: 50,
              child: SizedBox(
                child: SizedBox(
                  width: imageSize,
                  height: imageSize,
                  child: Image.network(
                    widget.secondImageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _topAnimation,
          builder: (context, child) {
            double topPosition = 50;
            if (_topController.isAnimating || _topController.isCompleted) {
              topPosition -= _topAnimation.value * 300;
            }
            return Positioned(
              top: topPosition,
              left: 50,
              child: SizedBox(
                width: imageSize,
                height: imageSize,
                child: Image.network(
                  widget.firstImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _initAnimation() {
    _bottomController = AnimationController(
      duration: Duration(milliseconds: 1000 + (widget.index * 160)),
      vsync: this,
    );

    _topController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );

    _bottomAnimation = CurvedAnimation(
      parent: _bottomController,
      curve: Curves.easeInOut,
    );

    _topAnimation = CurvedAnimation(
      parent: _topController,
      curve: Curves.easeInOut,
    );
  }

  void _startAnimation() {
    if (mounted) {
      _bottomController.forward();
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _topController.forward();
      }
    });
  }
}
