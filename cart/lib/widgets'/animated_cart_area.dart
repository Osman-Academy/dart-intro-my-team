// lib/widgets/animated_cart_area.dart
import 'package:flutter/material.dart';

class AnimatedCartArea extends StatefulWidget {
  final Widget child;
  final bool isExpanded;
  
  const AnimatedCartArea({
    Key? key,
    required this.child,
    required this.isExpanded,
  }) : super(key: key);
  
  @override
  State<AnimatedCartArea> createState() => _AnimatedCartAreaState();
}

class _AnimatedCartAreaState extends State<AnimatedCartArea> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _sizeAnimation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _sizeAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
  
  @override
  void didUpdateWidget(AnimatedCartArea oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _sizeAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _sizeAnimation.value,
          child: Opacity(
            opacity: _sizeAnimation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}