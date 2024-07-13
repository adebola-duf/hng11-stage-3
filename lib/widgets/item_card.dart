import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/models/item.dart';
import 'package:myapp/widgets/rating.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.onAddToCart,
  });

  final Item item;
  final void Function(Item item) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 184,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromRGBO(237, 237, 237, .67)),
          child: Image.network(item.imageUrl),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          item.name,
          maxLines: 1,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          item.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Rating(rating: item.rating),
        Text(
          item.priceInString,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: primaryPink,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 17),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item Added to cart'),
              ),
            );
            onAddToCart(item);
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1, color: primaryPink),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              'Add to Cart',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
