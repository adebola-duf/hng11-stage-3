import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/models/item.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.addToCart,
    required this.removeSingleItemFromCart,
    required this.noOfThisItemInCart,
    required this.removeCartItemFromCart,
    required this.increaseTotal,
    required this.decreaseTotal,
  });

  final Item item;
  final void Function(Item shoe) addToCart;
  final void Function(Item shoe) removeSingleItemFromCart;
  final void Function(Item shoe) removeCartItemFromCart;
  final void Function(double by) decreaseTotal;
  final void Function(double by) increaseTotal;
  final int noOfThisItemInCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 138,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.only(bottom: 21.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromRGBO(42, 42, 42, 0.1),
        ),
      ),
      child: Row(
        children: [
          Image.network(
            item.imageUrl,
            width: 60,
            height: 78,
          ),
          const SizedBox(width: 17),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.name,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(height: 13),
              QuantityComponent(
                increaseTotal: increaseTotal,
                decreaseTotal: decreaseTotal,
                item: item,
                addToCart: addToCart,
                removeFromCart: removeSingleItemFromCart,
                removeCartItemFromCart: removeCartItemFromCart,
                noOfThisItemInCart: noOfThisItemInCart,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              GestureDetector(
                onTap: () => removeCartItemFromCart(item),
                child:  Image.asset('assets/images/trash.png'),
              ),
              const Spacer(),
              Text('₦${item.price * noOfThisItemInCart}'),
            ],
          )
        ],
      ),
    );
  }
}

class QuantityComponent extends StatefulWidget {
  const QuantityComponent({
    super.key,
    required this.item,
    required this.addToCart,
    required this.removeFromCart,
    required this.noOfThisItemInCart,
    required this.removeCartItemFromCart,
    required this.increaseTotal,
    required this.decreaseTotal,
  });

  final Item item;
  final void Function(Item shoe) addToCart;
  final void Function(Item shoe) removeFromCart;
  final void Function(Item shoe) removeCartItemFromCart;
  final void Function(double by) decreaseTotal;
  final void Function(double by) increaseTotal;
  final int noOfThisItemInCart;

  @override
  State<QuantityComponent> createState() => _QuantityComponentState();
}

class _QuantityComponentState extends State<QuantityComponent> {
  late int noOfThisItemInCart;
  @override
  void initState() {
    noOfThisItemInCart = widget.noOfThisItemInCart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            widget.removeFromCart(widget.item);
            widget.decreaseTotal(widget.item.price);
            if (--noOfThisItemInCart == 0) {
              widget.removeCartItemFromCart(widget.item);
            }
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(
                color: const Color.fromARGB(255, 42, 42, 42),
              ),
            ),
            child: const Text('-'),
          ),
        ),
        const SizedBox(width: 21),
        Text(noOfThisItemInCart.toString()),
        const SizedBox(width: 21),
        GestureDetector(
          onTap: () {
            widget.addToCart(widget.item);
            widget.increaseTotal(widget.item.price);
            setState(() {
              noOfThisItemInCart++;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
              border: Border.all(
                color: const Color.fromARGB(255, 42, 42, 42),
              ),
            ),
            child: const Text('+'),
          ),
        ),
      ],
    );
  }
}
