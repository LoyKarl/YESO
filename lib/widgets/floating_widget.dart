import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Wraps a child with a subtle continuous floating/bobbing animation.
/// Uses a single repeating [AnimationController] with a sine-wave transform.
class FloatingWidget extends StatefulWidget {
  final Widget child;
  final double amplitude;
  final Duration period;
  final Axis axis;
  final double delay;

  const FloatingWidget({
    super.key,
    required this.child,
    this.amplitude = 8.0,
    this.period = const Duration(seconds: 3),
    this.axis = Axis.vertical,
    this.delay = 0,
  });

  @override
  State<FloatingWidget> createState() => _FloatingWidgetState();
}

class _FloatingWidgetState extends State<FloatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _elapsed = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.period,
    );
    Future.delayed(
      Duration(milliseconds: (widget.delay * 1000).round()),
      () {
        if (mounted) _controller.repeat();
      },
    );
    _controller.addListener(() {
      _elapsed = _controller.value;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Sine wave: sin(2π * t) * amplitude
        final radians = 2 * math.pi * _elapsed;
        final displacement = math.sin(radians) * widget.amplitude;

        return Transform.translate(
          offset: widget.axis == Axis.vertical
              ? Offset(0, displacement)
              : Offset(displacement, 0),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
