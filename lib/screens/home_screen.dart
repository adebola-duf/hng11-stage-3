import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/api_services/api_service.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/models/inventory.dart';
import 'package:myapp/models/item.dart';
import 'package:myapp/screens/cart_screen.dart';
import 'package:myapp/widgets/category_item_scroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _bottomNavBarIsVisible = true;
  late Future<Inventory> _loadInventoryFuture;

  @override
  void initState() {
    _loadInventoryFuture = loadInventory();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<Inventory> loadInventory() async {
    return (await ApiServices().loadInventory());
  }

  final Map<String, int> _cart = {};

  void _addItemToCart(Item item) {
    if (_cart.containsKey(item.name)) {
      _cart[item.name] = _cart[item.name]! + 1;
    } else {
      _cart[item.name] = 1;
    }
    setState(() {});
  }

  void _removeItemFromCart(Item item) {
    if (_cart.containsKey(item.name)) {
      if (_cart[item.name]! > 1) {
        _cart[item.name] = _cart[item.name]! - 1;
      } else {
        _cart.remove(item.name);
      }
    }
    setState(() {});
  }

  void _emptyCart() {
    setState(() {
      _cart.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 24),
                  height: 50,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: 31,
                        width: 99,
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        'Product List',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 42, 42, 42),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text(
                  'Product List',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 42, 42, 42),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<Inventory>(
                future: _loadInventoryFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error ${snapshot.error}'),
                    );
                  }
                  final inventory = snapshot.data!;
                  return Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification is UserScrollNotification) {
                            if (scrollNotification.direction ==
                                ScrollDirection.forward) {
                              setState(() {
                                _bottomNavBarIsVisible = true;
                              });
                            } else if (scrollNotification.direction ==
                                ScrollDirection.reverse) {
                              setState(() {
                                _bottomNavBarIsVisible = false;
                              });
                            }
                          }
                          return false;
                        },
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(24, 33, 24, 178.08),
                            child: Column(
                              children: [
                                Container(
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Image.asset(
                                          'assets/images/main-headphone.png'),
                                      const Padding(
                                        padding: EdgeInsets.only(left: 26.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Premium Sound,\nPremium Savings',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                              ),
                                            ),
                                            SizedBox(height: 7),
                                            Text(
                                              'Limited offer, hop on and get yours now',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                for (final category in inventory.inventory)
                                  CategoryItemScroller(
                                    category: category,
                                    onAddToCart: _addItemToCart,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 25,
                        right: 25,
                        bottom: 25,
                        child: AnimatedOpacity(
                          opacity: _bottomNavBarIsVisible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context)
                                  .appBarTheme
                                  .titleTextStyle!
                                  .color,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  'assets/icons/home.png',
                                  'assets/icons/cart.png',
                                  'assets/icons/cart-with-arrow.png',
                                ]
                                    .map(
                                      (assetPath) => GestureDetector(
                                        onTap: () {
                                          if (assetPath ==
                                              'assets/icons/cart-with-arrow.png') {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    CartScreen(
                                                  cartMap: _cart,
                                                  addToCart: _addItemToCart,
                                                  removeFromCart:
                                                      _removeItemFromCart,
                                                  clearCart: _emptyCart,
                                                  inventory: inventory,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: ShapeDecoration(
                                            shape: const CircleBorder(),
                                            color: assetPath ==
                                                    'assets/icons/home.png'
                                                ? primaryPink
                                                : null,
                                          ),
                                          child: Image.asset(
                                            assetPath,
                                            height: assetPath ==
                                                    'assets/icons/cart-with-arrow.png'
                                                ? 30
                                                : 24,
                                            width: assetPath ==
                                                    'assets/icons/cart-with-arrow.png'
                                                ? 30
                                                : 24,
                                            color: assetPath ==
                                                    'assets/icons/home.png'
                                                ? Colors.black
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
