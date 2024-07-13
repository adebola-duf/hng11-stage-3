import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/models/inventory.dart';
import 'package:myapp/models/item.dart';
import 'package:myapp/screens/checkout_widget.dart';
import 'package:myapp/widgets/cart_item_card.dart';
import 'package:myapp/widgets/order_summary.dart';
import 'package:myapp/widgets/payment_success.dart';
import 'package:myapp/widgets/payment_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    required this.cartMap,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
    required this.inventory,
  });

  final Map<String, int> cartMap;
  final void Function(Item item) addToCart;
  final void Function(Item item) removeFromCart;
  final void Function() clearCart;
  final Inventory inventory;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _bottomNavBarIsVisible = true;
  String _currentWidgetString = 'cart';

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _total = 0;

  @override
  void initState() {
    widget.cartMap.forEach((key, value) {
      _total += widget.inventory.allItems
          .where((item) => item.name == key)
          .first
          .price;
    });
    super.initState();
  }

  void _increaseTotal(double by) {
    setState(() {
      _total += by;
    });
  }

  void _decreaseTotal(double by) {
    setState(() {
      _total -= by;
    });
  }

  void _clearCart() {
    widget.clearCart();
    setState(() {
      widget.cartMap.clear();
    });
  }

  void _removeCartItemFromCart(Item item) {
    setState(() {
      widget.cartMap.remove(item.name);
    });
  }

  void _updateCurrentWidget(String nextWidget) {
    _scrollController.animateTo(
      0, // scroll to top
      duration: const Duration(milliseconds: 300), // animation duration
      curve: Curves.easeInOut, // animation curve
    );

    setState(() {
      _currentWidgetString = nextWidget;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentWidget = Column(
      children: [
        for (int i = 0; i < widget.cartMap.length; i++)
          CartItemCard(
            increaseTotal: _increaseTotal,
            decreaseTotal: _decreaseTotal,
            removeCartItemFromCart: _removeCartItemFromCart,
            item: widget.inventory.allItems
                .where((item) => item.name == widget.cartMap.keys.toList()[i])
                .first,
            addToCart: widget.addToCart,
            removeSingleItemFromCart: widget.removeFromCart,
            noOfThisItemInCart: widget.cartMap.values.toList()[i],
          ),
        OrderSummary(
          cartMap: widget.cartMap,
          total: _total,
          goToCheckOut: _updateCurrentWidget,
        ),
        const SizedBox(height: 121),
      ],
    );
    if (_currentWidgetString == 'checkout') {
      _bottomNavBarIsVisible = true;
      currentWidget = CheckoutWidget(
        goToPayment: _updateCurrentWidget,
      );
    }

    if (_currentWidgetString == 'payment') {
      _bottomNavBarIsVisible = true;
      currentWidget = PaymentWidget(
        goToPaymentSuccess: _updateCurrentWidget,
        clearCart: _clearCart,
      );
    }
    if (_currentWidgetString == 'payment-success') {
      _bottomNavBarIsVisible = true;
      currentWidget = const PaymentSuccess();
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 24),
                  height: 50,
                  child: Row(
                    children: [
                      _currentWidgetString == 'checkout'
                          ? GestureDetector(
                              onTap: () => _updateCurrentWidget('cart'),
                              child: const Icon(Icons.arrow_back),
                            )
                          : _currentWidgetString == 'payment'
                              ? GestureDetector(
                                  onTap: () => _updateCurrentWidget('checkout'),
                                  child: const Icon(Icons.arrow_back),
                                )
                              : _currentWidgetString == 'payment-success'
                                  ? GestureDetector(
                                      onTap: () {
                                        _clearCart();
                                        _updateCurrentWidget('cart');
                                      },
                                      child: const Icon(Icons.arrow_back),
                                    )
                                  : Image.asset(
                                      'assets/images/logo.png',
                                      height: 31,
                                      width: 99,
                                    ),
                      const Spacer(),
                    ],
                  ),
                ),
                const Text(
                  'Cart',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 42, 42, 42),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    widget.cartMap.isEmpty
                        ? Center(
                            child: Text(
                              'No Item in Cart',
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          )
                        : NotificationListener<ScrollNotification>(
                            onNotification: (scrollNotification) {
                              if (scrollNotification
                                  is UserScrollNotification) {
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
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: _currentWidgetString == 'cart'
                                  ? _scrollController
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0),
                                child: currentWidget,
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
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                'assets/icons/home.png',
                                'assets/icons/cart.png',
                                'assets/icons/cart-with-arrow.png',
                              ]
                                  .map(
                                    (assetPath) => GestureDetector(
                                      onTap: () =>
                                          assetPath == 'assets/icons/home.png'
                                              ? Navigator.of(context).pop()
                                              : null,
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: ShapeDecoration(
                                          shape: const CircleBorder(),
                                          color: assetPath ==
                                                  'assets/icons/cart-with-arrow.png'
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
                                                  'assets/icons/cart-with-arrow.png'
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
