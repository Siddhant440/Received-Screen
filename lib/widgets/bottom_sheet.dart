import 'package:flutter/material.dart';
import 'item_list_widget.dart';
import 'cart_button.dart';

class EditItemBottomSheet extends StatefulWidget {
  final ItemData item;
  final Function(ItemData)? onSave;

  const EditItemBottomSheet({
    Key? key,
    required this.item,
    this.onSave,
  }) : super(key: key);

  static void show(BuildContext context, ItemData item,
      {Function(ItemData)? onSave}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.85,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: EditItemBottomSheet(
            item: item,
            onSave: onSave,
          ),
        ),
      ),
    );
  }

  @override
  State<EditItemBottomSheet> createState() => _EditItemBottomSheetState();
}

class _EditItemBottomSheetState extends State<EditItemBottomSheet> {
  late String selectedMaterial;
  late TextEditingController quantityController;
  late TextEditingController rateController;
  late TextEditingController unitController;
  late String amount = "Rs. 1,74,350";

  @override
  void initState() {
    super.initState();
    selectedMaterial = widget.item.name;
    quantityController = TextEditingController(text: "100");
    rateController = TextEditingController();
    unitController = TextEditingController();
    _calculateAmount();
  }

  @override
  void dispose() {
    quantityController.dispose();
    rateController.dispose();
    unitController.dispose();
    super.dispose();
  }

  void _calculateAmount() {
    // Calculate amount based on the inputs
    // This would normally calculate based on rate and quantity
    setState(() {
      amount = "Rs. 1,74,350";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Cement',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              thickness: 1,
              color: Color(0xFFF2F2F2),
            ),

            const SizedBox(height: 20),

            // Material field
            _buildField(
              label: 'Material*',
              child: _buildDropdownField(
                value: 'Cement',
                prefixIcon: Icons.category_outlined,
                onChanged: (val) {
                  setState(() {
                    selectedMaterial = val ?? '';
                  });
                },
              ),
            ),

            const SizedBox(height: 15),

            // PO Quantity field
            _buildField(
              label: 'PO Quantity*',
              child: _buildInputField(
                controller: quantityController,
                onChanged: (_) => _calculateAmount(),
              ),
            ),

            const SizedBox(height: 15),

            // Rate field
            _buildField(
              label: 'Rate*',
              child: _buildInputField(
                controller: rateController,
                hintText: 'Enter Rate',
                onChanged: (_) => _calculateAmount(),
              ),
            ),

            const SizedBox(height: 15),

            // Unit of Measurement field
            _buildField(
              label: 'Unit of Measurement*',
              child: _buildInputField(
                controller: unitController,
                hintText: 'Enter Unit of Measurement',
              ),
            ),

            const SizedBox(height: 15),

            // Amount display
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Amount',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4B4B4B),
                  ),
                ),
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Save button
            CartButton.light(
              text: 'Save',
              onPressed: () {
                final updatedItem = ItemData(
                  name: selectedMaterial,
                  stockQty: '${quantityController.text} ${unitController.text}',
                  price:
                      'Rs.${rateController.text}/${unitController.text.toLowerCase()}',
                  amount: amount,
                );

                if (widget.onSave != null) {
                  widget.onSave!(updatedItem);
                }

                Navigator.pop(context);
              },
              height: 48,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildField({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B4B4B),
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    String? hintText,
    Function(String)? onChanged,
  }) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFFABAFB1),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String value,
    required IconData prefixIcon,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE8E8E8),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Icon(
              prefixIcon,
              size: 20,
              color: const Color(0xFFABAFB1),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: value,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFFABAFB1),
                  ),
                  onChanged: onChanged,
                  items: ['Cement', 'Steel', 'Brick', 'Sand', 'Aggregate']
                      .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
