import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../widgets/custom_header.dart';
import '../../../widgets/purchase_order_component.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_button.dart';
import 'items_list_screen.dart';
import '../../../widgets/form/round_add_button.dart';
import '../../../widgets/form/add_dialog.dart';
import '../../../widgets/item_list_widget.dart';
import '../add_item_screen.dart';

class AddReceivedScreen extends StatefulWidget {
  const AddReceivedScreen({Key? key}) : super(key: key);

  @override
  _AddReceivedScreenState createState() => _AddReceivedScreenState();
}

class _AddReceivedScreenState extends State<AddReceivedScreen> {
  String? selectedPackage;
  String remarks = '';
  double amount = 0;
  List<String> customFields = [];
  List<File> _attachments = [];
  final ImagePicker _picker = ImagePicker();
  final List<ItemData> _selectedItems = [];
  String vendorName = '';

  final List<String> packageOptions = ['Package 1', 'Package 2', 'Package 3'];

  // Calculate the total amount
  void _calculateTotalAmount() {
    double total = 0;
    for (var item in _selectedItems) {
      // Extract the amount value from the formatted string (remove "Rs." and commas)
      String amountStr = item.amount.replaceAll('Rs.', '').replaceAll(',', '');
      double itemAmount = double.tryParse(amountStr) ?? 0;
      total += itemAmount;
    }
    setState(() {
      amount = total;
    });
  }

  void _handleAddNewField() {
    AddDialog.show(
      context,
      onAdd: (fieldName) {
        setState(() {
          customFields.add(fieldName);
        });
      },
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _attachments.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      _showErrorDialog('Error picking image: $e');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildAttachmentsList() {
    if (_attachments.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attached Files (${_attachments.length})',
              style: const TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF455A64),
              ),
            ),
            if (_attachments.isNotEmpty)
              TextButton(
                onPressed: () {
                  setState(() {
                    _attachments.clear();
                  });
                },
                child: Text(
                  'Clear All',
                  style: TextStyle(
                    fontFamily: 'Metropolis',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF695CFF),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _attachments.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFABAFB1),
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.file(
                          _attachments[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _attachments.removeAt(index);
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 14,
                            color: Color(0xFF414651),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedItemsList() {
    if (_selectedItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _selectedItems.length,
          itemBuilder: (context, index) {
            final item = _selectedItems[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFE8E8E8),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/svgs/items_icon.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            fontFamily: 'Metropolis',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Rate: ${item.price}',
                          style: const TextStyle(
                            fontFamily: 'Metropolis',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF414651),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Stock Qty: ${item.stockQty}',
                        style: const TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF8891A5),
                        ),
                      ),
                      Text(
                        'Amount: ${item.amount}',
                        style: const TextStyle(
                          fontFamily: 'Metropolis',
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // Cross icon that shows options when clicked
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Color(0xFF8891A5),
                    ),
                    onSelected: (value) {
                      if (value == 'edit') {
                        // Navigate to edit item screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddItemScreen(
                              itemToEdit: item,
                              onSave: (updatedItem) {
                                setState(() {
                                  _selectedItems[index] = updatedItem;
                                  _calculateTotalAmount();
                                });
                              },
                            ),
                          ),
                        );
                      } else if (value == 'delete') {
                        // Remove the item
                        setState(() {
                          _selectedItems.removeAt(index);
                          _calculateTotalAmount();
                        });
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem<String>(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined,
                                color: Color(0xFF695CFF), size: 16),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete_outline,
                                color: Color(0xFFD22121), size: 16),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isFormValid =
        selectedPackage != null; // Add more conditions as needed

    return Scaffold(
      backgroundColor: const Color(0xFFF2F0FC),
      body: Column(
        children: [
          // Header
          CustomHeader(
            title: 'Received',
            onBack: () => Navigator.pop(context),
          ),

          // Main scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 13.0),
                child: Column(
                  children: [
                    // First Container: Purchase Order
                    Container(
                      width: screenWidth,
                      color: Colors.white,
                      child: PurchaseOrderComponent(
                        purchaseOrderNumber: 'Purchase order #543',
                        invoiceNumber: 'Original Invoice #',
                        date: '14 Dec 2024',
                        onEdit: () {
                          // Handle editing purchase order
                        },
                      ),
                    ),

                    const SizedBox(height: 13),

                    // Second Container: Vendor, Package, Items
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Vendor
                          CustomTextField(
                            label: 'Vendor',
                            hintText: 'Add Vendor',
                            isRequired: true,
                            onChanged: (value) {
                              setState(() {
                                vendorName = value;
                              });
                            },
                            prefixIcon: const Icon(
                              Icons.person_outline,
                              size: 18,
                              color: Color(0xFFABAFB1),
                            ),
                          ),

                          // Package
                          const SizedBox(height: 16),
                          Text(
                            'Package*',
                            style: const TextStyle(
                              fontFamily: 'Metropolis',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.14,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: const Color(0xFFABAFB1),
                                width: 0.5,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: selectedPackage,
                                  hint: Row(
                                    children: [
                                      Icon(
                                        Icons.inventory_2_outlined,
                                        size: 20,
                                        color: Color(0xFFABAFB1),
                                      ),
                                      SizedBox(width: 12),
                                      Text(
                                        'Select Package',
                                        style: TextStyle(
                                          fontFamily: 'Metropolis',
                                          fontSize: 12,
                                          color: Color(0xFFABAFB1),
                                        ),
                                      ),
                                    ],
                                  ),
                                  icon: Icon(Icons.keyboard_arrow_down,
                                      color: Color(0xFFABAFB1)),
                                  items: packageOptions.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontFamily: 'Metropolis',
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPackage = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),

                          // Custom Fields
                          ...customFields.map((fieldName) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: CustomTextField(
                                label: fieldName,
                                hintText: 'Enter $fieldName',
                              ),
                            );
                          }).toList(),

                          // Items
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Items*',
                                style: const TextStyle(
                                  fontFamily: 'Metropolis',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: -0.14,
                                  color: Colors.black,
                                  height: 1.2,
                                ),
                              ),
                              RoundAddButton(
                                label: 'Add New Field',
                                onTap: _handleAddNewField,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            height: 44,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F0FC),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {
                                  // Navigate to Items List Screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemsListScreen(
                                        onItemsSelected: (items) {
                                          setState(() {
                                            // Add only items that don't already exist in the list
                                            for (var item in items) {
                                              if (!_selectedItems.any(
                                                  (selectedItem) =>
                                                      selectedItem.name ==
                                                      item.name)) {
                                                _selectedItems.add(item);
                                              }
                                            }
                                            _calculateTotalAmount();
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    _selectedItems.isEmpty
                                        ? 'Add Items'
                                        : 'Add More',
                                    style: TextStyle(
                                      fontFamily: 'Metropolis',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.14,
                                      color: const Color(0xFF695CFF),
                                      height: 1.14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Selected items list
                          _buildSelectedItemsList(),

                          const SizedBox(height: 21),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Third Container: Remarks and Attachments
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Remarks
                          CustomTextField(
                            label: 'Remarks',
                            hintText: 'Add remarks...',
                            maxLines: 5,
                            height: 90,
                            onChanged: (value) {
                              setState(() {
                                remarks = value;
                              });
                            },
                          ),

                          // Attachments
                          const SizedBox(height: 16),
                          Text(
                            'Attachments',
                            style: const TextStyle(
                              fontFamily: 'Metropolis',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.14,
                              color: Colors.black,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 55,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: DashedBorderPainter(
                                      color: const Color(0xFFABAFB1),
                                      strokeWidth: 1.0,
                                      dashPattern: [4, 4],
                                      borderRadius: 8,
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: _pickImage,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'assets/svgs/upload_images_icon.svg',
                                                width: 18,
                                                height: 18,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Color(0xFF455A64),
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Text(
                                                'Upload Images',
                                                style: TextStyle(
                                                  fontFamily: 'Metropolis',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.43,
                                                  color: Color(0xFF455A64),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Display attached images
                          _buildAttachmentsList(),

                          const SizedBox(height: 16),
                        ],
                      ),
                    ),

                    // Add bottom padding to ensure content doesn't get hidden behind the footer
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Fixed footer with amount and submit button
          Container(
            width: screenWidth,
            padding:
                const EdgeInsets.symmetric(horizontal: 19.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Amount:',
                      style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Rs. ${amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontFamily: 'Metropolis',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: CustomButton(
                    label: 'Submit',
                    onPressed: isFormValid
                        ? () {
                            // Create a data object with all the details
                            final receivedMaterialData = {
                              'purchaseOrderNumber': 'Purchase order #543',
                              'vendor': vendorName,
                              'package': selectedPackage ?? 'Package 1',
                              'items': _selectedItems,
                              'totalAmount': amount,
                              'date': '14 Dec 2024',
                            };

                            // Navigate back to the received screen with the data
                            Navigator.pop(context, receivedMaterialData);
                          }
                        : () {},
                    isPrimary: isFormValid,
                    isEnabled: isFormValid,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter for dashed border
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double borderRadius;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Create a rectangular path with rounded corners
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    // Create a dash path
    final dashPath = Path();
    final dashWidth = dashPattern[0];
    final dashSpace = dashPattern[1];
    final dist = dashWidth + dashSpace;

    // Calculate the length of the path
    final metrics = path.computeMetrics().first;
    final len = metrics.length;

    // Create a dashed path by moving a pointer along the original path
    var distance = 0.0;
    while (distance < len) {
      final extractPath = metrics.extractPath(distance, distance + dashWidth);
      dashPath.addPath(extractPath, Offset.zero);
      distance += dist;
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
