import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';

class OrderSummary extends StatelessWidget {
  const OrderSummary({
    super.key,
    required this.cartMap,
    required this.total,
    required this.goToCheckOut,
  });

  final Map<String, int> cartMap;
  final double total;
  final Function(String nextWidget) goToCheckOut;

  @override
  Widget build(BuildContext context) {
    const double discountPercentage = 0.05;
    const double deliveryPercentage = 0.03;
    const textBaseColor = Color.fromRGBO(42, 42, 42, 0.7);
    final mostUsedTextStyle = GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textBaseColor,
      ),
    );
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(237, 237, 237, 0.67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shopping Summary',
            style: mostUsedTextStyle.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const SizedBox(height: 25),
          Text(
            'Discount Code',
            style: mostUsedTextStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(42, 42, 42, 0.7),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 36,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Text(
                    'Apply',
                    style: mostUsedTextStyle.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 41.82),
          Row(
            children: [
              Text('Sub-Total', style: mostUsedTextStyle),
              const Spacer(),
              Text(
                '₦$total',
                style: mostUsedTextStyle.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                'Delivery Fee',
                style: mostUsedTextStyle,
              ),
              const Spacer(),
              Text('₦${(total * deliveryPercentage).toStringAsFixed(2)}',
                  style:
                      mostUsedTextStyle.copyWith(fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Text(
                'Discount Amount',
                style: mostUsedTextStyle,
              ),
              const Spacer(),
              Text('₦${(total * discountPercentage).toStringAsFixed(2)}',
                  style:
                      mostUsedTextStyle.copyWith(fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 26),
          const DashedDivider(),
          const SizedBox(height: 23),
          Row(
            children: [
              Text(
                'Total Amount',
                style: mostUsedTextStyle,
              ),
              const Spacer(),
              Text(
                  '₦${(total - total * discountPercentage + total * deliveryPercentage).toStringAsFixed(2)}',
                  style:
                      mostUsedTextStyle.copyWith(fontWeight: FontWeight.w400)),
            ],
          ),
          const SizedBox(height: 36),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 36.5),
            child: ElevatedButton(
              onPressed: () => goToCheckOut('checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryPink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Checkout',
                style: mostUsedTextStyle.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Color color;

  DashedLinePainter({
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.color = Colors.black,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DashedDivider({
    super.key,
    this.height = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: CustomPaint(
        painter: DashedLinePainter(
          dashWidth: dashWidth,
          dashSpace: dashSpace,
          color: color,
        ),
      ),
    );
  }
}
