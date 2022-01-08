import 'package:flutter/material.dart';
import 'package:golf_app/Pages/AddPlayers.dart';
import 'package:golf_app/Pages/EnterScore.dart';
import 'package:golf_app/Pages/Login.dart';
import 'package:golf_app/Pages/PickCourse.dart';
import 'package:golf_app/Pages/SelectTeeBox.dart';
import 'package:golf_app/utils/RoundProvider.dart';
import 'package:golf_app/utils/UserProvider.dart';
import 'package:golf_app/utils/MatchProvider.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'utils/constants.dart';
import 'Pages/Home.dart';
import 'Pages/Login.dart';
import 'Pages/SplashPage.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnnonKey);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RoundProvider()),
        ChangeNotifierProvider(create: (_) => MatchProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'golf-app',
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/login': (_) => const Login(),
        '/home': (_) => Home(),
        '/pickCourse' : (_) => PickCourse(),
        '/addPlayers' : (_) => AddPlayers(),
        '/selectTeeBox' : (_) => SelectTeeBox(),
        '/enterScore' : (_) => EnterScore(),
      },
    );
  }
}