import 'package:flutter/material.dart';

class PasswordDidNotMatch extends StatefulWidget {
  final bool isVisible;
  final Widget child;
  final Duration duration;
  final VoidCallback? onDismissed;

  const PasswordDidNotMatch({
    super.key,
    required this.isVisible,
    required this.child,
    this.duration = const Duration(seconds: 2),
    this.onDismissed,
  });

  @override
  State<PasswordDidNotMatch> createState() => _PasswordDidNotMatchState();
}

class _PasswordDidNotMatchState extends State<PasswordDidNotMatch> {
  bool _show = false;

  @override
  void initState() {
    super.initState();
    _show = widget.isVisible;
    if (_show) _startTimer();
  }

  @override
  void didUpdateWidget(covariant PasswordDidNotMatch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible && !oldWidget.isVisible) {
      setState(() {
        _show = true;
      });
      _startTimer();
    }
  }

  void _startTimer() {
    Future.delayed(widget.duration, () {
      if (mounted) {
        setState(() {
          _show = false;
        });
        widget.onDismissed?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _show ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: _show ? widget.child : const SizedBox.shrink(),
    );
  }
}
