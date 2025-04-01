import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'cart_button.dart';
import 'bottom_sheet.dart';
import 'item_list_widget.dart';

class ItemCard extends StatelessWidget {
  final ItemData item;
  final Function(ItemData)? onEdit;
  final VoidCallback? onAdd;

  const ItemCard({
    Key? key,
    required this.item,
    this.onEdit,
    this.onAdd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Divider(
            color: Color(0xFFF2F2F2),
            height: 1,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 19,
              right: 19,
              top: 18,
              bottom: 0,
            ),
            child: SizedBox(
              height: 93,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/items_icon.svg',
                    width: 30,
                    height: 30,
                  ),

                  const SizedBox(width: 15),

                  // Item details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF414651),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.price,
                          overflow: TextOverflow.visible,
                          style: const TextStyle(
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Stock Qty, Amount, and buttons
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Stock Qty and Amount
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Stock Qty: ${item.stockQty}',
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color(0xFF8891A5),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Amount: ${item.amount}',
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Buttons row
                      Row(
                        children: [
                          // Edit button
                          CartButton.edit(
                            onPressed: () {
                              if (onEdit != null) {
                                EditItemBottomSheet.show(
                                  context,
                                  item,
                                  onSave: onEdit,
                                );
                              }
                            },
                          ),

                          const SizedBox(width: 8),

                          // Add button
                          CartButton.add(
                            onPressed: onAdd ?? () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
