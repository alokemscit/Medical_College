import 'package:asgar_ali_hospital/constant/const.dart';
 

class ConnectionErrorPage extends StatelessWidget {
  const ConnectionErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               const Icon(Icons.signal_wifi_off_outlined,size: 50,color: Colors.red),
              Text("No Internet connection available!\nPlease enable your Internet connection and try again.",
              textAlign:TextAlign.center,
              style: customTextStyle.copyWith(color: Colors.red.withOpacity(0.9),
              
              fontSize: 12,fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}