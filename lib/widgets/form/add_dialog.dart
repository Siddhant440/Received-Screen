import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../cart_button.dart';

class AddDialog extends StatefulWidget {
  final Function(String) onAdd;
  final VoidCallback onClose;

  const AddDialog({
    Key? key,
    required this.onAdd,
    required this.onClose,
  }) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required Function(String) onAdd,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext dialogContext) {
        return AddDialog(
          onAdd: (Name) {
            onAdd(Name);
            Navigator.of(dialogContext).pop();
          },
          onClose: () {
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_validateInput);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 354,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFFE9EAEB),
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svgs/add__icon.svg',
                      width: 24,
                      height: 24,
                      // Use no color filter to maintain the SVG's original colors
                      // or specify a strokeWidth if needed
                    ),
                  ),
                ),
                // Close button at the top-right corner inside container
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: widget.onClose,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.close,
                        color: Color(0xFF414651),
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            Text(
              ' Name*',
              style: TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF414651),
              ),
            ),
            const SizedBox(height: 7),
            Container(
              height: 44,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFABAFB1),
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Enter  Name',
                    hintStyle: TextStyle(
                      fontFamily: 'Metropolis',
                      fontSize: 12,
                      color: Color(0xFFABAFB1),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CartButton.primary(
              text: 'Add',
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  widget.onAdd(_controller.text);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
