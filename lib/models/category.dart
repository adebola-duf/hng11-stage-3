import 'package:myapp/models/item.dart';

enum Category {
  techGadget,
  menFashion,
  womenFashion,
}

class CategoryModel {
  const CategoryModel({
    required this.category,
    required this.items,
  });

  final Category category;
  final List<Item> items;

  String get categoryInString => category == Category.techGadget
      ? 'Tech Gadget'
      : category == Category.menFashion
          ? 'Men\'s Fashion'
          : 'Women\'s Fashion';
}
