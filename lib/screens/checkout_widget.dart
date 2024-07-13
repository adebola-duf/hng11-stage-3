import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';

class CheckoutWidget extends StatefulWidget {
  const CheckoutWidget({
    super.key,
    required this.goToPayment,
  });
  final Function(String nextWidget) goToPayment;

  @override
  State<CheckoutWidget> createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget> {
  String _selectedValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select how to receive your package(s)',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(42, 42, 42, 1),
            ),
          ),
        ),
        const SizedBox(height: 21),
        Text(
          'Pickup',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(42, 42, 42, 1),
            ),
          ),
        ),
        RadioListTile<String>(
          activeColor: primaryPink,
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Old Secretariat Complex, Area q, Garki Abaji Abji',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(42, 42, 42, 0.5),
                fontSize: 12,
              ),
            ),
          ),
          value: 'Option 1',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
        RadioListTile<String>(
          activeColor: primaryPink,
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Sokoto Streen, Area q, Garki Area 1 AMAC',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromRGBO(42, 42, 42, 0.5),
                fontSize: 12,
              ),
            ),
          ),
          value: 'Option 2',
          groupValue: _selectedValue,
          onChanged: (value) {
            setState(() {
              _selectedValue = value!;
            });
          },
        ),
        const SizedBox(height: 35),
        Text(
          'Delivery',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color.fromRGBO(42, 42, 42, 1),
            ),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color.fromRGBO(42, 42, 42, 0.4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 35),
        SizedBox(
          width: 248,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contact',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(42, 42, 42, 1),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38.83,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Phone nos 1',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(42, 42, 42, 0.4),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(42, 42, 42, 0.4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 38.83,
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(42, 42, 42, 0.4),
                    ),
                    hintText: 'Phone nos 1',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(42, 42, 42, 0.4),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 62.33,
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 36.5),
          child: ElevatedButton(
            onPressed: () {
              widget.goToPayment('payment');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryPink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Go to Payment',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 150),
      ],
    );
  }
}
