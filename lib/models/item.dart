

import 'package:myapp/models/category.dart';

class Item {
  const Item({
    required this.name,
    required this.description,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  String get priceInString {
    RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '₦${price.toString().replaceAllMapped(regExp, (match) => '${match[1]},')}';
  }

  final String name;
  final String description;
  final int rating;
  final double price;
  final String imageUrl;
  final Category category;
}
