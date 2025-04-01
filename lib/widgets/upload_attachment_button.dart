import 'package:flutter/material.dart';

class UploadAttachmentButton extends StatelessWidget {
  final VoidCallback onUpload;

  const UploadAttachmentButton({
    Key? key,
    required this.onUpload,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Attachments',
            style: TextStyle(
              fontFamily: 'Metropolis',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.14,
              height: 1.0,
              color: Colors.black,
            ),
          ),
        ),
        InkWell(
          onTap: onUpload,
          child: Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFABAFB1),
                width: 0.5,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.file_upload_outlined,
                    size: 16,
                    color: Color(0xFF455A64),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Upload',
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
      ],
    );
  }
}
