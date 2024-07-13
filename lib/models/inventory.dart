import 'dart:convert';

import 'package:myapp/models/category.dart';
import 'package:myapp/models/item.dart';

class Inventory {
  final List<CategoryModel> inventory;

  List<Item> get allItems {
    final allItems = <Item>[];
    for (final category in inventory) {
      allItems.addAll(category.items);
    }
    return allItems;
  }

  const Inventory({required this.inventory});

  factory Inventory.fromJson(Map<String, dynamic> timbuProductsJson) {
    final products = timbuProductsJson['items'];
    final menFashionItems = <Item>[];
    final womenFashionItems = <Item>[];
    final techGadgetItems = <Item>[];

    for (final item in products) {
      final name = item['name'];
      final myCustomJson =
          jsonDecode((item['description'] as String).replaceAll("\\'", '\''));
      final description = myCustomJson['description'];
      final rating = myCustomJson['rating'];
      final imageUrl =
          'http://api.timbu.cloud/images/${item['photos'][0]['url']}';

      final price = item['current_price'][0]['NGN'][0];
      final category = item['categories']?[0]['name'];

      switch (category) {
        case 'women\'s fashion':
          womenFashionItems.add(
            Item(
              imageUrl: imageUrl,
              name: name,
              price: price,
              description: description,
              rating: rating,
              category: Category.womenFashion,
            ),
          );
          break;
        case 'men\'s fashion':
          menFashionItems.add(
            Item(
              imageUrl: imageUrl,
              name: name,
              price: price,
              description: description,
              rating: rating,
              category: Category.menFashion,
            ),
          );
          break;
        default:
          techGadgetItems.add(
            Item(
              imageUrl: imageUrl,
              name: name,
              price: price,
              description: description,
              rating: rating,
              category: Category.techGadget,
            ),
          );
      }
    }

    return Inventory(
      inventory: [
        CategoryModel(
            category: Category.womenFashion, items: womenFashionItems),
        CategoryModel(category: Category.menFashion, items: menFashionItems),
        CategoryModel(category: Category.techGadget, items: techGadgetItems),
      ],
    );
  }
}
