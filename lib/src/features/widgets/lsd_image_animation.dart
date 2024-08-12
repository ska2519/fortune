import 'package:flutter/material.dart';

class LSDImageAnimation extends StatefulWidget {
  final Image image;

  const LSDImageAnimation({super.key, required this.image});

  @override
  _LSDImageAnimationState createState() => _LSDImageAnimationState();
}

class _LSDImageAnimationState extends State<LSDImageAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  // late Animation<ColorFilter> _colorFilterAnimation;
  late ColorFilter _colorFilterAnimation;
  late ColorFilter _colorFilter;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 14),
      vsync: this,
    )..repeat();
    _rotationAnimation = Tween<double>(begin: 0, end: 100)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _scaleAnimation = Tween<double>(begin: 1, end: 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _opacityAnimation = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    // _colorFilterAnimation = ColorFilter.mode(
    //   begin: ColorFilter.mode(Colors.transparent, BlendMode.color),
    //   end: ColorFilter.mode(Colors.blue, BlendMode.color),
    // ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorFilterAnimation = ColorFilter.mode(
      const Color.fromARGB(255, 147, 161, 173).withOpacity(0.3),
      BlendMode.color,
    );
    _colorFilter = ColorFilter.mode(
      Colors.deepPurpleAccent.withOpacity(0.3),
      BlendMode.color,
    );
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
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _rotationAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: ColorFiltered(
                colorFilter: _controller.value % 2 == 0
                    ? _colorFilterAnimation
                    : _colorFilter,
                child: widget.image,
              ),
            ),
          ),
        );
      },
    );
  }
}
