import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/pages/splashScreen/firstScreen.dart';
import 'package:first_app/pages/splashScreen/firstScreenNew.dart';
import 'package:first_app/provider/job_post_provider.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/routes/generated_routes.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserProvider1(),
    ),
    ChangeNotifierProvider(
      create: (context) => StudioProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => StudioProvider1(),
    ),
    ChangeNotifierProvider(
      create: (context) => JobProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => JobProvider1(),
    ),
  ], child: const MyAPP()));
}

class MyAPP extends StatefulWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  State<MyAPP> createState() => _MyAPPState();
}

class _MyAPPState extends State<MyAPP> {
  final AuthService authService = AuthService();
  final _messangerKey = GlobalKey<ScaffoldMessengerState>();

  Future<dynamic> waitForToken() async {
    return await authService.getUserData(context);
  }

  late Future<dynamic> _future;

  @override
  void initState() {
    _future = waitForToken();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage("asset/images/illustration/fg.png"), context);
    var user = Provider.of<UserProvider>(context).user;
    var studioUser = Provider.of<StudioProvider>(context).user;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        scaffoldMessengerKey: _messangerKey,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
          fontFamily: fontFamily,
        ),
        onGenerateRoute: (settings) => generatedRoute(settings),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const FirstSplashScreen();
              } else if (snapshot.hasData) {
                final data = snapshot.data.toString();
                if (data == FirstSplashScreen.routeName) {
                  return const FirstSplashScreen();
                } else {
                  if (snapshot.data.toString() == user.token) {
                    return const BottomNavigationPage();
                  } else if (snapshot.data.toString() == studioUser.token) {
                    return const SBottomNavigationPage();
                  }
                }
              }
            }
            return const FirstSplashScreenNew();
          },
          future: _future,
        ),
      ),
    );
  }
}
