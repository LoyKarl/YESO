import 'package:flutter/material.dart';
import '../active_page.dart';

/// Animates a list of children in sequence — each one fades and slides in
/// one after another — when the list scrolls into the viewport.
class StaggerFadeList extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;
  final Axis axis;
  final double offset;
  final double threshold;
  final Curve curve;

  const StaggerFadeList({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 80),
    this.itemDuration = const Duration(milliseconds: 500),
    this.axis = Axis.vertical,
    this.offset = 40,
    this.threshold = 0.1,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<StaggerFadeList> createState() => _StaggerFadeListState();
}

class _StaggerFadeListState extends State<StaggerFadeList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _triggered = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _totalDuration(),
      vsync: this,
    );
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

  Duration _totalDuration() {
    final n = widget.children.length;
    return Duration(
      milliseconds:
          widget.itemDuration.inMilliseconds +
          (n - 1) * widget.itemDelay.inMilliseconds,
    );
  }

  void _checkVisibility() {
    if (_triggered) return;
    if (!ActivePage.isActiveOf(context)) return;
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) {
      _trigger();
      return;
    }
    _scrollPosition?.removeListener(_onScroll);
    _scrollPosition = scrollable.position;
    _evaluate();
    _scrollPosition!.addListener(_onScroll);
  }

  void _onScroll() {
    if (_triggered) {
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

    if (visible) _trigger();
  }

  void _trigger() {
    if (_triggered) return;
    _triggered = true;
    _scrollPosition?.removeListener(_onScroll);
    _controller.forward();
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.children.length;
    if (count == 0) return const SizedBox.shrink();

    final totalMs = _totalDuration().inMilliseconds;
    if (totalMs == 0) {
      return Column(mainAxisSize: MainAxisSize.min, children: widget.children);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(count, (i) {
            final start =
                (i * widget.itemDelay.inMilliseconds) / totalMs;
            final end = (i * widget.itemDelay.inMilliseconds +
                    widget.itemDuration.inMilliseconds) /
                totalMs;

            final interval = Interval(start, end, curve: widget.curve);
            final opacityVal = _tween(
              _controller, interval, 0.0, 1.0,
            );
            final slide = _tween(
              _controller, interval, widget.offset / 100, 0.0,
            );

            return Opacity(
              opacity: opacityVal,
              child: Transform.translate(
                offset: widget.axis == Axis.vertical
                    ? Offset(0, slide * widget.offset)
                    : Offset(slide * widget.offset, 0),
                child: widget.children[i],
              ),
            );
          }),
        );
      },
    );
  }
}

double _tween(
  AnimationController controller,
  Interval interval,
  double begin,
  double end,
) {
  final curved = CurvedAnimation(parent: controller, curve: interval);
  return Tween<double>(begin: begin, end: end).evaluate(curved);
}

/// Row variant of [StaggerFadeList] that lays out children in a [Row].
class StaggerFadeRow extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;
  final Axis axis;
  final double offset;
  final double threshold;
  final Curve curve;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const StaggerFadeRow({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 80),
    this.itemDuration = const Duration(milliseconds: 500),
    this.axis = Axis.horizontal,
    this.offset = 40,
    this.threshold = 0.1,
    this.curve = Curves.easeOutCubic,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  State<StaggerFadeRow> createState() => _StaggerFadeRowState();
}

class _StaggerFadeRowState extends State<StaggerFadeRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _triggered = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: _totalDuration(),
      vsync: this,
    );
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

  Duration _totalDuration() {
    final n = widget.children.length;
    return Duration(
      milliseconds:
          widget.itemDuration.inMilliseconds +
          (n - 1) * widget.itemDelay.inMilliseconds,
    );
  }

  void _checkVisibility() {
    if (_triggered) return;
    if (!ActivePage.isActiveOf(context)) return;
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) {
      _trigger();
      return;
    }
    _scrollPosition?.removeListener(_onScroll);
    _scrollPosition = scrollable.position;
    _evaluate();
    _scrollPosition!.addListener(_onScroll);
  }

  void _onScroll() {
    if (_triggered) {
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

    if (visible) _trigger();
  }

  void _trigger() {
    if (_triggered) return;
    _triggered = true;
    _scrollPosition?.removeListener(_onScroll);
    _controller.forward();
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.children.length;
    if (count == 0) return const SizedBox.shrink();
    final totalMs = _totalDuration().inMilliseconds;
    if (totalMs == 0) {
      return Row(
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: widget.children,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          crossAxisAlignment: widget.crossAxisAlignment,
          children: List.generate(count, (i) {
            final start =
                (i * widget.itemDelay.inMilliseconds) / totalMs;
            final end = (i * widget.itemDelay.inMilliseconds +
                    widget.itemDuration.inMilliseconds) /
                totalMs;

            final interval = Interval(start, end, curve: widget.curve);
            final opacityVal = _tween(
              _controller, interval, 0.0, 1.0,
            );
            final slide = _tween(
              _controller, interval, widget.offset / 100, 0.0,
            );

            return Opacity(
              opacity: opacityVal,
              child: Transform.translate(
                offset: widget.axis == Axis.horizontal
                    ? Offset(slide * widget.offset, 0)
                    : Offset(0, slide * widget.offset),
                child: widget.children[i],
              ),
            );
          }),
        );
      },
    );
  }
}
