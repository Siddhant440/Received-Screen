import 'package:flutter/material.dart';
import '../../../widgets/header_widget.dart';
import '../../../widgets/item_list_widget.dart';
import '../../../widgets/footer_widget.dart';
import '../../../widgets/item_card.dart';

class ItemsListScreen extends StatefulWidget {
  final Function(List<ItemData>)? onItemsSelected;

  const ItemsListScreen({
    Key? key,
    this.onItemsSelected,
  }) : super(key: key);

  @override
  State<ItemsListScreen> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends State<ItemsListScreen> {
  String _searchQuery = '';
  final List<ItemData> _selectedItems = [];

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _addItem(ItemData item) {
    // Check if the item is not already in the list to avoid duplicates
    if (!_selectedItems.any((selectedItem) => selectedItem.name == item.name)) {
      setState(() {
        _selectedItems.add(item);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F0FC),
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            SearchHeaderWidget(
              onSearch: _handleSearch,
            ),

            // Item List with Add New Item button
            Expanded(
              child: ItemListWithAddButton(
                searchQuery: _searchQuery,
                onAddItem: _addItem,
              ),
            ),

            // Footer showing selected items count and continue button
            _selectedItems.isNotEmpty
                ? ItemsFooterWidget(
                    itemCount: _selectedItems.length,
                    onContinue: () {
                      // Pass selected items back to the previous screen
                      if (widget.onItemsSelected != null) {
                        widget.onItemsSelected!(_selectedItems);
                      }
                      Navigator.pop(context);
                    },
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

// Widget that combines the RoundAddButton and the ListView
class ItemListWithAddButton extends StatelessWidget {
  final String searchQuery;
  final Function(ItemData) onAddItem;

  const ItemListWithAddButton({
    Key? key,
    required this.searchQuery,
    required this.onAddItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemListWidget(
      searchQuery: searchQuery,
      onAddToCart: (item) {
        onAddItem(item);
      },
    );
  }
}
