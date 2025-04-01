import 'package:flutter/material.dart';
import '../../widgets/custom_header.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/cart_button.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/item_list_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddItemScreen extends StatefulWidget {
  final Function(ItemData)? onSave;
  final ItemData? itemToEdit;

  const AddItemScreen({
    Key? key,
    this.onSave,
    this.itemToEdit,
  }) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  String _selectedMaterial = 'Cement';
  double _amount = 0;

  @override
  void initState() {
    super.initState();
    // Prefill form if editing an existing item
    if (widget.itemToEdit != null) {
      final item = widget.itemToEdit!;
      _selectedMaterial = item.name;

      // Parse stockQty to get quantity and unit (format: '100 Bags')
      final qtyParts = item.stockQty.split(' ');
      if (qtyParts.length > 0) {
        _quantityController.text = qtyParts[0];
        if (qtyParts.length > 1) {
          _unitController.text = qtyParts.sublist(1).join(' ');
        }
      }

      // Parse price to get rate (format: 'Rs.1,585/Bag')
      final priceParts = item.price.split('/');
      if (priceParts.length > 0) {
        String rateStr =
            priceParts[0].replaceAll('Rs.', '').replaceAll(',', '');
        _rateController.text = rateStr;
      }

      _calculateAmount();
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _rateController.dispose();
    _unitController.dispose();
    super.dispose();
  }

  void _calculateAmount() {
    // Simple calculation (would be more complex in a real app)
    double quantity = double.tryParse(_quantityController.text) ?? 0;
    double rate = double.tryParse(_rateController.text) ?? 0;
    double total = quantity * rate;

    setState(() {
      _amount = total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header component - using CustomHeader
            CustomHeader(
              title: widget.itemToEdit != null ? 'Edit Item' : 'Add Items',
              onBack: () => Navigator.pop(context),
            ),

            // Form fields
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Material field with dropdown
                      _buildMaterialField(),
                      const SizedBox(height: 16),

                      // PO Quantity field - using CustomTextField
                      CustomTextField(
                        label: 'PO Quantity',
                        hintText: 'Enter Purchase Order',
                        isRequired: true,
                        controller: _quantityController,
                        onChanged: (_) => _calculateAmount(),
                      ),
                      const SizedBox(height: 16),

                      // Unit of Measurement field - using CustomTextField
                      CustomTextField(
                        label: 'Unit of Measurement',
                        hintText: 'Enter Unit of Measurement',
                        isRequired: true,
                        controller: _unitController,
                      ),
                      const SizedBox(height: 16),

                      // Rate field - using CustomTextField
                      CustomTextField(
                        label: 'Rate',
                        hintText: 'Enter Rate',
                        isRequired: true,
                        controller: _rateController,
                        onChanged: (_) => _calculateAmount(),
                      ),
                      const SizedBox(height: 16),

                      // Amount display
                      _buildAmountDisplay(),
                    ],
                  ),
                ),
              ),
            ),

            // Save button - using CartButton
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: SizedBox(
                width: 120, // Reduced width
                child: CartButton.light(
                  text: 'Approve',
                  onPressed: _saveItem,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialField() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFABAFB1),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PO-2023-001',
                    style: TextStyle(
                      color: Color(0xFF6750A4), // Primary purple color
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Vendor Name',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Package: ABC-123',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 8),
                        Text('Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'edit') {
                    // Handle edit
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddItemScreen(
                          itemToEdit: widget.itemToEdit,
                        ),
                      ),
                    );
                  } else if (value == 'delete') {
                    // Handle delete
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAmountDisplay() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Amount',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Text(
              'Rs. ${_amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveItem() {
    // Validate data first
    if (_quantityController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _unitController.text.isEmpty) {
      // Show validation error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Create an ItemData object with the form values
    final newItem = ItemData(
      name: _selectedMaterial,
      price: 'Rs.${_rateController.text}/${_unitController.text}',
      amount: 'Rs.${_amount.toStringAsFixed(2)}',
      stockQty: '${_quantityController.text} ${_unitController.text}',
    );

    // Pass the new item back to the caller
    if (widget.onSave != null) {
      widget.onSave!(newItem);
    }

    Navigator.pop(context);
  }
}
