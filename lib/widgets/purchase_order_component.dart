import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PurchaseOrderComponent extends StatelessWidget {
  final String purchaseOrderNumber;
  final String invoiceNumber;
  final String date;
  final VoidCallback onEdit;

  const PurchaseOrderComponent({
    Key? key,
    required this.purchaseOrderNumber,
    required this.invoiceNumber,
    required this.date,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                purchaseOrderNumber,
                style: const TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.14,
                  color: Color(0xFF695CFF),
                  height: 1.2,
                ),
              ),
              GestureDetector(
                onTap: onEdit,
                child: Row(
                  children: [
                    const Text(
                      'Edit',
                      style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.14,
                        color: Color(0xFF695CFF),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      'assets/svgs/edit_icon.svg',
                      width: 10,
                      height: 10,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF695CFF),
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            invoiceNumber,
            style: const TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.14,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            date,
            style: const TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: -0.14,
              color: Colors.black,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
