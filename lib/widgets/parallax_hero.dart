import 'package:flutter/material.dart';

/// Creates a parallax scrolling effect where the [background] moves at a
/// different rate than the [foreground] content during scroll.
///
/// [intensity] controls how much slower the background moves (0.0 = no
/// parallax, higher values = more pronounced, typically 0.2-0.4).
class ParallaxHero extends StatefulWidget {
  final Widget background;
  final Widget foreground;
  final double intensity;
  final double? height;

  const ParallaxHero({
    super.key,
    required this.background,
    required this.foreground,
    this.intensity = 0.3,
    this.height,
  });

  @override
  State<ParallaxHero> createState() => _ParallaxHeroState();
}

class _ParallaxHeroState extends State<ParallaxHero> {
  double _scrollOffset = 0;
  bool _listening = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _attachListener();
  }

  void _attachListener() {
    if (_listening) return;
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) return;
    _listening = true;
    scrollable.position.addListener(_onScroll);
    _scrollOffset = scrollable.position.pixels;
  }

  void _onScroll() {
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) return;
    setState(() {
      _scrollOffset = scrollable.position.pixels;
    });
  }

  @override
  void dispose() {
    Scrollable.maybeOf(context)?.position.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -_scrollOffset * widget.intensity,
            left: 0,
            right: 0,
            child: widget.background,
          ),
          widget.foreground,
        ],
      ),
    );
  }
}
