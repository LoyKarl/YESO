import 'package:flutter/material.dart';

/// Wraps a card with web hover effects: subtle scale-up and glow/shadow
/// elevation. On touch devices [MouseRegion] never fires so the widget
/// renders as a plain pass-through.
class HoverCard extends StatelessWidget {
  final Widget child;
  final double scale;
  final double elevationShift;
  final Color? glowColor;
  final double glowRadius;
  final BorderRadius borderRadius;
  final Duration duration;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const HoverCard({
    super.key,
    required this.child,
    this.scale = 1.02,
    this.elevationShift = 6.0,
    this.glowColor,
    this.glowRadius = 20.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.duration = const Duration(milliseconds: 200),
    this.onTap,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return _HoverCardStateful(
      scale: scale,
      glowColor: glowColor,
      glowRadius: glowRadius,
      borderRadius: borderRadius,
      duration: duration,
      onTap: onTap,
      margin: margin,
      child: child,
    );
  }
}

class _HoverCardStateful extends StatefulWidget {
  final Widget child;
  final double scale;
  final Color? glowColor;
  final double glowRadius;
  final BorderRadius borderRadius;
  final Duration duration;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  const _HoverCardStateful({
    required this.child,
    required this.scale,
    this.glowColor,
    required this.glowRadius,
    required this.borderRadius,
    required this.duration,
    this.onTap,
    this.margin,
  });

  @override
  State<_HoverCardStateful> createState() => _HoverCardStatefulState();
}

class _HoverCardStatefulState extends State<_HoverCardStateful> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final glow = widget.glowColor ??
        (isDark ? Colors.greenAccent : const Color(0xFF2E7D32));

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? widget.scale : 1.0,
        duration: widget.duration,
        child: AnimatedContainer(
          duration: widget.duration,
          margin: widget.margin,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: glow.withValues(alpha: 0.3),
                      blurRadius: widget.glowRadius,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: widget.glowRadius + 4,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: widget.borderRadius,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: widget.borderRadius,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
