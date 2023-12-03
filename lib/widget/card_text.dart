import 'package:flutter/material.dart';
import 'package:todolistapp/constants/colors.dart';

class card_text extends StatelessWidget {
  final String cardText;
  final double fontSize;
  const card_text({super.key, required this.cardText, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Text(
      cardText,
      textAlign: TextAlign.center,
      softWrap: true,
      style: TextStyle(
        color: AppColors.bluegrey,
        fontSize: fontSize,
      ),
    );
  }
}
