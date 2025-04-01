import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const CustomHeader({
    Key? key,
    required this.title,
    required this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 97,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 19, top: 48),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onBack,
              child: Container(
                width: 36,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                    width: 0.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 11),
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Metropolis',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.18,
                height: 1.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
