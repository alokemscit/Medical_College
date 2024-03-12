import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_user_image_and_details.dart';

class ParentPageTopWidget extends StatelessWidget {
  const ParentPageTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   // Size size = MediaQuery.of(context).size;
    return Positioned(
      top: 0,
      left: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
         // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(
                "ERP System",
                style: GoogleFonts.carlito(
                    fontSize: 30 ,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const LoginUsersImageAndDetails(),
          ],
        ),
      ),
    );
  }
}
