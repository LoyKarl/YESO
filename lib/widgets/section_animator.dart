import 'package:flutter/material.dart';
import '../active_page.dart';

class SectionAnimator extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Axis axis;
  final double offset;

  const SectionAnimator({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.axis = Axis.vertical,
    this.offset = 50,
  });

  @override
  State<SectionAnimator> createState() => _SectionAnimatorState();
}

class _SectionAnimatorState extends State<SectionAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _opacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _slideAnim = Tween<Offset>(
      begin: widget.axis == Axis.vertical
          ? Offset(0, widget.offset / 100)
          : Offset(widget.offset / 100, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
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
      builder: (context, child) => Opacity(
        opacity: _opacityAnim.value,
        child: Transform.translate(
          offset: Offset(
            _slideAnim.value.dx * widget.offset,
            _slideAnim.value.dy * widget.offset,
          ),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int target;
  final String label;
  final IconData icon;
  final Color color;
  final bool autoStart;

  const AnimatedCounter({
    super.key,
    required this.target,
    required this.label,
    required this.icon,
    required this.color,
    this.autoStart = false,
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _started = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    if (widget.autoStart) _startCounting();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_started) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_started) _checkVisibility();
      });
    }
  }

  void _checkVisibility() {
    if (_started) return;
    if (!ActivePage.isActiveOf(context)) return;
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) {
      _startCounting();
      return;
    }
    _scrollPosition?.removeListener(_onScroll);
    _scrollPosition = scrollable.position;
    _evaluate();
    _scrollPosition!.addListener(_onScroll);
  }

  void _onScroll() {
    if (_started) {
      _scrollPosition?.removeListener(_onScroll);
      return;
    }
    _evaluate();
  }

  void _evaluate() {
    if (_started) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final absOffset = renderBox.localToGlobal(Offset.zero).dy;
    final h = renderBox.size.height;
    final viewH = MediaQuery.of(context).size.height;

    if (absOffset < viewH && absOffset + h > 0) _startCounting();
  }

  void _startCounting() {
    if (_started) return;
    _started = true;
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        int count = (_animation.value * widget.target).round();
        return _buildStat(context, count);
      },
    );
  }

  Widget _buildStat(BuildContext context, int count) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(widget.icon, color: widget.color, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            '$count+',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: widget.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
