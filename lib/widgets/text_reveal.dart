import 'package:flutter/material.dart';
import '../active_page.dart';

enum RevealMode { words, chars }

/// Displays text with a word-by-word (or char-by-char) fade + slide reveal
/// animation. Properly handles `\n` line breaks.
class TextReveal extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final RevealMode mode;
  final Duration itemDuration;
  final double offset;
  final Curve curve;
  final VoidCallback? onComplete;

  const TextReveal({
    super.key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow = TextOverflow.visible,
    this.mode = RevealMode.words,
    this.itemDuration = const Duration(milliseconds: 60),
    this.offset = 20,
    this.curve = Curves.easeOut,
    this.onComplete,
  });

  @override
  State<TextReveal> createState() => _TextRevealState();
}

enum _SegType { word, space, newline }

class _TextRevealState extends State<TextReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<(_SegType, String)> _segments;
  int _animatableCount = 0;
  bool _started = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _processText();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: _animatableCount * widget.itemDuration.inMilliseconds,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkVisibility();
    });
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

  void _processText() {
    _segments = [];
    _animatableCount = 0;

    if (widget.mode == RevealMode.chars) {
      for (final ch in widget.text.split('')) {
        if (ch == '\n') {
          _segments.add((_SegType.newline, ch));
        } else {
          _segments.add((_SegType.word, ch));
          _animatableCount++;
        }
      }
      return;
    }

    // words mode — split preserving spaces and newlines
    for (final ch in widget.text.split('')) {
      if (ch == '\n') {
        _segments.add((_SegType.newline, ch));
      } else if (ch == ' ') {
        _segments.add((_SegType.space, ch));
      } else {
        if (_segments.isNotEmpty && _segments.last.$1 == _SegType.word) {
          _segments[_segments.length - 1] = (
            _SegType.word,
            _segments.last.$2 + ch,
          );
        } else {
          _segments.add((_SegType.word, ch));
          _animatableCount++;
        }
      }
    }
  }

  void _checkVisibility() {
    if (_started) return;
    if (!ActivePage.isActiveOf(context)) return;
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable == null) {
      _start();
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

    if (absOffset < viewH && absOffset + h > 0) _start();
  }

  void _start() {
    if (_started) return;
    _started = true;
    _scrollPosition?.removeListener(_onScroll);
    _controller.forward().then((_) {
      widget.onComplete?.call();
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
    if (_segments.isEmpty) return const SizedBox.shrink();

    final totalMs = _controller.duration!.inMilliseconds;

    // No animatable segments — render plain text
    if (_animatableCount == 0 || totalMs == 0) {
      return Text(widget.text, style: widget.style, textAlign: widget.textAlign);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        int animIdx = 0;
        return Text.rich(
          TextSpan(
            style: widget.style,
            children: _segments.map((seg) {
              if (seg.$1 == _SegType.newline) {
                return const TextSpan(text: '\n');
              }
              if (seg.$1 == _SegType.space) {
                return const TextSpan(text: ' ');
              }

              final i = animIdx;
              animIdx++;
              final itemStart =
                  (i * widget.itemDuration.inMilliseconds) / totalMs;
              final itemEnd =
                  ((i + 1) * widget.itemDuration.inMilliseconds) / totalMs;

              final interval = Interval(itemStart, itemEnd, curve: widget.curve);
              final curved = CurvedAnimation(
                parent: _controller,
                curve: interval,
              );
              final progress =
                  Tween<double>(begin: 0, end: 1).evaluate(curved);

              return WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Opacity(
                  opacity: progress,
                  child: Transform.translate(
                    offset: Offset(0, (1 - progress) * widget.offset),
                    child: Text(seg.$2, style: widget.style),
                  ),
                ),
              );
            }).toList(),
          ),
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          overflow: widget.overflow,
        );
      },
    );
  }
}
