import 'package:flutter/material.dart';

class alertDialog extends StatelessWidget {
  final String? deskripsi;
  final String? textButton;
  final Function()? onTap;
  alertDialog({super.key, this.deskripsi, this.onTap, this.textButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(
          15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              deskripsi!,
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: onTap,
              child: Text(
                textButton!,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
