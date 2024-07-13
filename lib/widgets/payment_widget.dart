import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({
    super.key,
    required this.goToPaymentSuccess,
    required this.clearCart,
  });
  final Function(String nextWidget) goToPaymentSuccess;
  final void Function() clearCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 217,
              padding: const EdgeInsets.all(21),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromRGBO(42, 42, 42, 0.95),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        'VISA',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '5047 1245 7689 2345',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Card holder name',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Hafsat Ardo',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 36),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Expiry date',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '02/30',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset('assets/images/sim.png'),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Positioned(
              top: -54,
              left: 169,
              child: Container(
                height: 158,
                width: 158,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(.25),
                  shape: const CircleBorder(),
                ),
              ),
            ),
            Positioned(
              top: -10,
              left: 240,
              child: Container(
                height: 158,
                width: 158,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(.25),
                  shape: const CircleBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 34),
        const Text('Card Number'),
        const SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            hintText: '0000 0000 0000 0000',
            hintStyle: GoogleFonts.montserrat(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color.fromRGBO(42, 42, 42, 0.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromRGBO(151, 151, 151, 1),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Expiry Date'),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'mm/yy',
                      hintStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color.fromRGBO(42, 42, 42, 0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(151, 151, 151, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 22),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CVV'),
                  const SizedBox(height: 10),
                  TextField(
                    decoration: InputDecoration(
                      hintText: '123',
                      hintStyle: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: const Color.fromRGBO(42, 42, 42, 0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color.fromRGBO(151, 151, 151, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 63),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 36.5),
          child: ElevatedButton(
            onPressed: () => goToPaymentSuccess('payment-success'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Make Payment',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 150),
      ],
    );
  }
}
