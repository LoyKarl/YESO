import 'package:flutter/material.dart';
import '../active_page.dart';

/// Animates its child with a fade + slide transition that triggers when the
/// widget scrolls into the viewport. Falls back to auto-firing after [delay]
/// when no [Scrollable] ancestor is found.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Axis axis;
  final double offset;
  final double threshold;
  final bool oneShot;
  final Curve curve;

  const ScrollReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.axis = Axis.vertical,
    this.offset = 50,
    this.threshold = 0.1,
    this.oneShot = true,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _slide = Tween<Offset>(
      begin: widget.axis == Axis.vertical
          ? Offset(0, widget.offset / 100)
          : Offset(widget.offset / 100, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkVisibility();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_triggered) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_triggered) _checkVisibility();
      });
    }
  }

  void _checkVisibility() {
    if (_triggered) return;
    if (!ActivePage.isActiveOf(context)) return;
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) {
      _scheduleTrigger();
      return;
    }
    _scrollPosition?.removeListener(_onScroll);
    _scrollPosition = scrollable.position;
    _evaluate();
    _scrollPosition!.addListener(_onScroll);
  }

  void _onScroll() {
    if (_triggered && widget.oneShot) {
      _scrollPosition?.removeListener(_onScroll);
      return;
    }
    _evaluate();
  }

  void _evaluate() {
    if (_triggered) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final absOffset = renderBox.localToGlobal(Offset.zero).dy;
    final h = renderBox.size.height;
    final viewH = MediaQuery.of(context).size.height;

    final visible = absOffset < viewH + h - viewH * widget.threshold &&
        absOffset + h > viewH * widget.threshold;

    if (visible) _scheduleTrigger();
  }

  void _scheduleTrigger() {
    if (_triggered) return;
    _triggered = true;
    _scrollPosition?.removeListener(_onScroll);
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: _opacity.value,
        child: Transform.translate(
          offset: Offset(
            _slide.value.dx * widget.offset,
            _slide.value.dy * widget.offset,
          ),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
