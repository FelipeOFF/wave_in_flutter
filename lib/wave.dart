import 'dart:math';

import 'package:dashcast/blue_gradient.dart';
import 'package:dashcast/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Wave extends StatefulWidget {
  final Size size;

  const Wave({required this.size, Key? key}) : super(key: key);

  @override
  _WaveState createState() => _WaveState();
}

class _WaveState extends State<Wave> with SingleTickerProviderStateMixin {
  final Random _rand = Random();
  late List<Offset> _points = List.generate(
    widget.size.width.toInt() + 1,
    (index) => Offset(
      index.toDouble(),
      _rand.nextDouble() + (widget.size.height * 0.8),
    ),
  );
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
      upperBound: 2 * pi,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<MainController>(
      builder: (controller) {
        if (controller.isPlaying) {
          _controller.repeat();
        } else {
          _controller.stop();
        }
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ClipPath(
              clipper: WaveClipper(_controller.value, _points),
              child: BlueGradient(),
            );
          },
        );
      },
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double _value;
  final List<Offset> _wavePoints;

  WaveClipper(this._value, this._wavePoints);

  @override
  Path getClip(Size size) {
    var path = Path();
    _modulateRandom(size);
    path.addPolygon(_wavePoints, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  void _modulateRandom(Size size) {
    final maxDiff = 3.0;
    Random rand = Random();
    var newWave = _wavePoints
        .map(
          (point) => Offset(
            point.dx,
            min(
              size.height,
              max(0.0,
                  point.dy + (maxDiff - rand.nextDouble() * maxDiff * 2.0)),
            ),
          ),
        )
        .toList();
    _wavePoints.clear();
    _wavePoints.addAll(newWave);
  }

  void _makeSineWave(Size size) {
    final amplitude = size.height / 3;
    final yOffset = amplitude;

    for (int x = 0; x < size.width; x++) {
      double y = amplitude * sin((x / 4) + _value) + yOffset;

      Offset newPoint = Offset(x.toDouble(), y);
      _wavePoints[x] = newPoint;
    }
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
