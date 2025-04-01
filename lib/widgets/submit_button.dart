import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;
  final String buttonText;
  final double amount;
  final bool isEnabled;

  const SubmitButton({
    Key? key,
    required this.onSubmit,
    this.buttonText = 'Submit',
    this.amount = 0.0,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 19.0, vertical: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Amount:',
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 12,
                  letterSpacing: -0.12,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              Text(
                'Rs. ${amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 12,
                  letterSpacing: -0.12,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color:
                  isEnabled ? const Color(0xFF695CFF) : const Color(0xFFEFEFEF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextButton(
              onPressed: isEnabled ? onSubmit : null,
              child: Text(
                buttonText,
                style: TextStyle(
                  fontFamily: 'Metropolis',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.14,
                  color: isEnabled ? Colors.white : const Color(0xFF707070),
                  height: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
