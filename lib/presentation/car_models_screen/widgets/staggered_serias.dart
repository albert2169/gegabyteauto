import 'package:flutter/material.dart';

class StaggeredSerias extends StatefulWidget {
  final List<String> serias;
  final bool open;
  final VoidCallback? onHideCompleted;
  final void Function(String seria)? onSeriaTap;

  const StaggeredSerias({
    super.key,
    required this.serias,
    required this.open,
    this.onHideCompleted,
    this.onSeriaTap,
  });

  @override
  State<StaggeredSerias> createState() => _StaggeredSeriasState();
}

class _StaggeredSeriasState extends State<StaggeredSerias> {
  late List<bool> _visible;

  @override
  void initState() {
    super.initState();
    _visible = List<bool>.filled(widget.serias.length, false);
    if (widget.open) _runShowSequence();
  }

  @override
  void didUpdateWidget(covariant StaggeredSerias oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.open && !oldWidget.open) {
      _runShowSequence();
    } else if (!widget.open && oldWidget.open) {
      _runHideSequence();
    }
  }

  Future<void> _runShowSequence() async {
    for (int i = 0; i < widget.serias.length; i++) {
      if (!mounted) return;
      setState(() {
        _visible[i] = true;
      });
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  Future<void> _runHideSequence() async {
    if (!mounted) return;
    setState(() {
      for (int i = 0; i < _visible.length; i++) {
        _visible[i] = false;
      }
    });

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted && !widget.open) {
      widget.onHideCompleted?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < widget.serias.length; i++)
          AnimatedOpacity(
            opacity: _visible[i] ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: AnimatedSlide(
              offset: _visible[i] ? Offset.zero : const Offset(-0.3, 0),
              duration: const Duration(milliseconds: 500),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => widget.onSeriaTap?.call(widget.serias[i]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      widget.serias[i],
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
