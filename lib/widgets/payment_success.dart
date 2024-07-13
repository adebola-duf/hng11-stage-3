import 'package:flutter/material.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Center(
        child: Image.asset('assets/images/check-mark.png'),
      ),
    );
  }
}
