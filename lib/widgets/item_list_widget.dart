import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:praone/widgets/form/round_add_button.dart';
import 'bottom_sheet.dart';
import 'cart_button.dart';
import '../screens/material/add_item_screen.dart';
import 'item_card.dart';

class ItemListWidget extends StatefulWidget {
  final String searchQuery;
  final Function(ItemData)? onAddToCart;

  const ItemListWidget({
    Key? key,
    this.searchQuery = '',
    this.onAddToCart,
  }) : super(key: key);

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  // List to store all items including both demo items and newly added items
  List<ItemData> _items = [];

  @override
  void initState() {
    super.initState();
    // Initialize with demo items
    _items = _getDemoItems();
  }

  List<ItemData> _getFilteredItems() {
    if (widget.searchQuery.isEmpty) return _items;

    return _items
        .where((item) =>
            item.name.toLowerCase().contains(widget.searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Add New Field container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 12),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RoundAddButton(
                label: 'Add New Item',
                onTap: () {
                  // Navigate to Add Item screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddItemScreen(
                        onSave: (ItemData newItem) {
                          // Add the new item to our local list at the first index
                          setState(() {
                            _items.insert(0, newItem);
                          });

                          // Add the new item to the list and notify if needed
                          if (widget.onAddToCart != null) {
                            widget.onAddToCart!(newItem);
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // Divider below Add New Field button
        const Divider(
          color: Color(0xFFF2F2F2),
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
        ),

        // Item list
        Expanded(
          child: ListView.builder(
            itemCount: _getFilteredItems().length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final item = _getFilteredItems()[index];
              return ItemCard(
                item: item,
                onEdit: (updatedItem) {
                  // In a real app, you would update the item in state or database
                  // For this example, we'll just call the callback
                },
                onAdd: () {
                  // If an external onAddToCart callback is provided, use it
                  if (widget.onAddToCart != null) {
                    widget.onAddToCart!(item);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // This would typically come from a model/repository in a real app
  List<ItemData> _getDemoItems() {
    return [
      ItemData(
        name: 'Cement',
        price: 'Rs.1,585/Bag',
        amount: 'Rs.1,58,500',
        stockQty: '100 Bags',
      ),
      ItemData(
        name: 'Steel',
        price: 'Rs.70/Kg',
        amount: 'Rs.70,000',
        stockQty: '1000 Kg',
      ),
      ItemData(
        name: 'Sand',
        price: 'Rs.2,500/Cubic m',
        amount: 'Rs.25,000',
        stockQty: '10 Cubic m',
      ),
      ItemData(
        name: 'Brick',
        price: 'Rs.8/Piece',
        amount: 'Rs.80,000',
        stockQty: '10000 Pieces',
      ),
      ItemData(
        name: 'Aggregate',
        price: 'Rs.1,800/Cubic m',
        amount: 'Rs.18,000',
        stockQty: '10 Cubic m',
      ),
      ItemData(
        name: 'Tiles',
        price: 'Rs.45/Piece',
        amount: 'Rs.45,000',
        stockQty: '1000 Pieces',
      ),
      ItemData(
        name: 'Wood',
        price: 'Rs.1,200/Cubic ft',
        amount: 'Rs.12,000',
        stockQty: '10 Cubic ft',
      ),
    ];
  }
}

// Model class for Item data
class ItemData {
  final String name;
  final String price;
  final String amount;
  final String stockQty;

  ItemData({
    required this.name,
    required this.price,
    required this.amount,
    required this.stockQty,
  });
}
