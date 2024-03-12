
import 'package:agmc/config/const.dart';

Widget getPage( String id) {
  switch (id) {
    case "28":
      {
        return  Container();
      }
   
      
      case "":
      return const SizedBox(
        //child: Text("Under Construction!"),
      );
    default:
      return const Center(
        child: Text("Under Construction!",style: TextStyle(fontSize: 30,color: Colors.blue),),
      );
  }
}