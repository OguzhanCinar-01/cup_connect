import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CupConnectLogo extends StatelessWidget {
  const CupConnectLogo({super.key, this.fontSize = 50, this.color = Colors.white});
  final int fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'CupConnect',
      style: GoogleFonts.leckerliOne(
         fontSize: fontSize.toDouble(),
         fontWeight: FontWeight.w100,
         color: color,
        ),
      );
  }
}
