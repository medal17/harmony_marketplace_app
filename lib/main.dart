//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/splashScreen.dart';
import 'notifier/Auth_Notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(
    MultiProvider(
            providers: [
              ChangeNotifierProvider(create:(context)=>AuthNotifier())
            ],
          child:MaterialApp(
            debugShowCheckedModeBanner : false,
            home: Home()
            ),
    )
  );
}

class Home extends StatelessWidget {
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      //debugShowCheckedBanner : false;
      body: SplashScreen()
       );
  }
}
/*Stack(
children: <Widget>[
DrawerScreen(),
EmptyScreen(),
HomeScreen()
],
),*/
