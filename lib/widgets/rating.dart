import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final bool isFilled;

  const RatingStar({
    super.key,
    required this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    const double widthAndHeight = 16.92;
    const starColor = Color.fromARGB(255, 255, 198, 87);
    return Container(
      width: widthAndHeight,
      height: widthAndHeight,
      decoration: ShapeDecoration(
        shape: StarBorder(
          points: 5,
          innerRadiusRatio: 0.4,
          side: isFilled
              ? BorderSide.none
              : const BorderSide(
                  width: 1,
                  color: starColor,
                ),
        ),
        color: isFilled ? starColor : Colors.transparent,
      ),
    );
  }
}

class Rating extends StatelessWidget {
  const Rating({
    super.key,
    required this.rating,
  });

  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return RatingStar(isFilled: index < rating);
      }),
    );
  }
}
