import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coffee_shop/utils/app_colors.dart';

class MyButton extends StatefulWidget {
  const MyButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.color,
  });

  final void Function() onTap;
  final String title;
  final Color color;

  @override
  _MyButtonState createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> with SingleTickerProviderStateMixin {
  bool _isTappedDown = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTappedDown = true;
        });
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() {
          _isTappedDown = false;
        });
        _controller.reverse();
      },
      onTapCancel: () {
        setState(() {
          _isTappedDown = false;
        });
        _controller.reverse();
      },
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 250,
          height: 65,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.color,
            boxShadow: _isTappedDown
                ? []
                : [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
          ),
          child: Center(
            child: Text(
              widget.title,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: AppColors.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
