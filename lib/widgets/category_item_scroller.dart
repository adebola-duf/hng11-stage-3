import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/models/item.dart';
import 'package:myapp/widgets/item_card.dart';

class CategoryItemScroller extends StatefulWidget {
  const CategoryItemScroller({
    super.key,
    required this.category,
    required this.onAddToCart,
  });

  final CategoryModel category;
  final void Function(Item item) onAddToCart;

  @override
  State<CategoryItemScroller> createState() => _CategoryItemScrollerState();
}

class _CategoryItemScrollerState extends State<CategoryItemScroller>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 44.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.category.categoryInString,
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 346.92,
            child: PageView(
              controller: _pageViewController,
              onPageChanged: _handlePageViewChanged,
              children: List.generate(
                (widget.category.items.length / 2).ceil(),
                (rowIndex) {
                  return Row(
                    children: List.generate(2, (colIndex) {
                      int itemIndex = rowIndex * 2 + colIndex;
                      if (itemIndex < widget.category.items.length) {
                        return Expanded(
                          child: Padding(
                            padding: itemIndex == 0
                                ? const EdgeInsets.only(right: 6.5)
                                : const EdgeInsets.only(left: 6.5),
                            child: ItemCard(
                              item: widget.category.items[itemIndex],
                              onAddToCart: widget.onAddToCart,
                            ),
                          ),
                        );
                      } else {
                        return Expanded(
                          child: Container(),
                        ); // Empty Expanded for alignment
                      }
                    }),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 7.0),
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: ShapeDecoration(
                    color: _currentPageIndex == index
                        ? primaryPink
                        : Colors.transparent,
                    shape: CircleBorder(
                      side: _currentPageIndex == index
                          ? BorderSide.none
                          : const BorderSide(color: primaryPink, width: 1),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
