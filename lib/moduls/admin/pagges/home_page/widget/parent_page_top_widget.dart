 
import '../../../../../core/config/const.dart';
 
import 'login_user_image_and_details.dart';

class ParentPageTopWidget extends StatelessWidget {
  const ParentPageTopWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
   // Size size = MediaQuery.of(context).size;
    return const Positioned(
      top: 0,
      left: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Row(
         // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 6),
              child: Text(
                "ERP System",
                style: TextStyle(fontFamily: appFontMuli,
                    fontSize: 30 ,
                    fontWeight: FontWeight.bold),
              ),
            ),
            LoginUsersImageAndDetails(),
          ],
        ),
      ),
    );
  }
}
