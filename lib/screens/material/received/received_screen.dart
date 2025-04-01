import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/transitions/slide_right_to_left_route.dart';
import '../../../widgets/item_list_widget.dart';
import 'add_received_screen.dart';

class ReceivedScreen extends StatefulWidget {
  const ReceivedScreen({Key? key}) : super(key: key);

  @override
  State<ReceivedScreen> createState() => _ReceivedScreenState();
}

class _ReceivedScreenState extends State<ReceivedScreen> {
  // List to store received materials
  List<Map<String, dynamic>> receivedMaterials = [];
  // List to store filtered materials for search
  List<Map<String, dynamic>> filteredMaterials = [];
  // Search query
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredMaterials = receivedMaterials;
  }

  // Filter materials based on search query
  void _filterMaterials(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredMaterials = receivedMaterials;
      } else {
        filteredMaterials = receivedMaterials
            .where((material) => material['vendor']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.zero,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Search bar - only show when there are materials
              if (receivedMaterials.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Container(
                    height: 40,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Icon(
                            Icons.search,
                            color: Color(0xFF8891A5),
                            size: 20,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search Vendor',
                              hintStyle: TextStyle(
                                fontFamily: 'Metropolis',
                                fontSize: 14,
                                color: Color(0xFF8891A5),
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: _filterMaterials,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Received Materials List
              Expanded(
                child: receivedMaterials.isEmpty
                    ? const Center(
                  child: Text(
                          'No received materials yet',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredMaterials.length,
                        itemBuilder: (context, index) {
                          final material = filteredMaterials[index];
                          final items = material['items'] as List<ItemData>;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFE8E8E8),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  offset: const Offset(0, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                // Header with PO number, edit icon and date
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Color(0xFFE8E8E8),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          material['purchaseOrderNumber'] ?? '',
                                          style: const TextStyle(
                                            fontFamily: 'Metropolis',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Show popup menu
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SimpleDialog(
                                                title: const Text('Options'),
                                                children: <Widget>[
                                                  SimpleDialogOption(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // Edit functionality would go here
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(
                                                            Icons.edit_outlined,
                                                            color: Color(
                                                                0xFF695CFF),
                                                            size: 16),
                                                        SizedBox(width: 8),
                                                        Text('Edit'),
                                                      ],
                                                    ),
                                                  ),
                                                  SimpleDialogOption(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      // Delete functionality
                                                      setState(() {
                                                        receivedMaterials
                                                            .removeWhere((m) =>
                                                                m['purchaseOrderNumber'] ==
                                                                material[
                                                                    'purchaseOrderNumber']);
                                                        if (searchQuery
                                                            .isNotEmpty) {
                                                          _filterMaterials(
                                                              searchQuery);
                                                        } else {
                                                          filteredMaterials =
                                                              receivedMaterials;
                                                        }
                                                      });
                                                    },
                                                    child: const Row(
                                                      children: [
                                                        Icon(
                                                            Icons
                                                                .delete_outline,
                                                            color: Color(
                                                                0xFFD22121),
                                                            size: 16),
                                                        SizedBox(width: 8),
                                                        Text('Delete'),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          'Edit #',
                                          style: const TextStyle(
                                            fontFamily: 'Metropolis',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF695CFF),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Vendor and Package info
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        material['vendor'] ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Metropolis',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        material['package'] ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Metropolis',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF8891A5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Amount and Approve button
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: Color(0xFFE8E8E8),
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Amount:',
                                            style: const TextStyle(
                                              fontFamily: 'Metropolis',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF8891A5),
                                            ),
                                          ),
                                          Text(
                                            'Rs.${material['totalAmount'].toStringAsFixed(2)}',
                                            style: const TextStyle(
                                              fontFamily: 'Metropolis',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Handle approve action
                                          setState(() {
                                            // Update the material status to approved
                                            material['status'] = 'Approved';

                                            // Show a snackbar to confirm
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${material['purchaseOrderNumber']} approved successfully'),
                                                duration:
                                                    const Duration(seconds: 2),
                                              ),
                                            );
                                          });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              material['status'] == 'Approved'
                                                  ? Colors.green
                                                  : const Color(0xFF695CFF),
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                        ),
                                        child: Text(
                                          material['status'] == 'Approved'
                                              ? 'Approved'
                                              : 'Approve',
                                          style: const TextStyle(
                                            fontFamily: 'Metropolis',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                ),
              ),
            ],
          ),
        ),
        // Circular Add Button
        Positioned(
          right: 12.0,
          bottom: 21.0,
          child: SizedBox(
            width: 62.0,
            height: 62.0,
            child: ElevatedButton(
              onPressed: () async {
                // Navigate to Add Received Screen with right to left transition
                final result = await Navigator.push(
                  context,
                  SlideRightToLeftPageRoute(
                    page: const AddReceivedScreen(),
                  ),
                );

                // Handle the returned data
                if (result != null && mounted) {
                  setState(() {
                    // Add status field to the received material data
                    Map<String, dynamic> materialWithStatus =
                        result as Map<String, dynamic>;
                    materialWithStatus['status'] = 'Pending';

                    receivedMaterials.add(materialWithStatus);
                    // If there's a search query, filter the materials again
                    if (searchQuery.isNotEmpty) {
                      _filterMaterials(searchQuery);
                    } else {
                      filteredMaterials = receivedMaterials;
                    }
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF695CFF),
                foregroundColor: Colors.white,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(0),
                elevation: 2,
              ),
              child: const CustomPlusSymbol(
                length: 21,
                thickness: 2,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomPlusSymbol extends StatelessWidget {
  final double length;
  final double thickness;
  final Color color;

  const CustomPlusSymbol({
    Key? key,
    required this.length,
    required this.thickness,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: length,
      height: length,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Horizontal strip
          Container(
            width: length,
            height: thickness,
            color: color,
          ),
          // Vertical strip
          Container(
            width: thickness,
            height: length,
            color: color,
          ),
        ],
      ),
    );
  }
}
