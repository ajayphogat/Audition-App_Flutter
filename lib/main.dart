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
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            "asset/images/illustration/blog.svg"),
        context);
    precacheImage(
        const AssetImage("asset/images/illustration/fg.png"), context);
    precachePicture(
        ExactAssetPicture(SvgPicture.svgStringDecoderBuilder,
            "asset/images/illustration/d.svg"),
        context);
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
              print("c done");
              if (snapshot.hasError) {
                print("has error");
                return const FirstSplashScreen();
              } else if (snapshot.hasData) {
                print(snapshot.data);
                final data = snapshot.data.toString();
                if (data == FirstSplashScreen.routeName) {
                  print("data");
                  return const FirstSplashScreen();
                } else {
                  if (snapshot.data.toString() == user.token) {
                    print("bottom");
                    return const BottomNavigationPage();
                  } else if (snapshot.data.toString() == studioUser.token) {
                    print("sbottom");
                    return const SBottomNavigationPage();
                  }
                }
              }
            }
            print("re");
            return const FirstSplashScreenNew();
          },
          future: _future,
        ),
      ),
    );
  }

  // Future<dynamic> showFirstScreenAsDialog(
  //     BuildContext context, double screenWidth, double screenHeight) {
  //   return showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (context) {
  //         return Center(
  //           child: Stack(
  //             alignment: AlignmentDirectional.center,
  //             children: [
  //               Container(
  //                 width: screenWidth,
  //                 height: screenHeight,
  //                 alignment: Alignment.center,
  //                 padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
  //                 child: Image.asset("asset/images/illustration/find.png"),
  //               ),
  //               Positioned(
  //                 bottom: screenHeight * 0.20,
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     Text(
  //                       "Made to be Found",
  //                       style: TextStyle(
  //                         fontSize: 35,
  //                         fontWeight: FontWeight.w900,
  //                         color: const Color(0xFF979797).withOpacity(0.5),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}


// Provider.of<UserProvider>(context).user.token.isNotEmpty
//             ? const BottomNavigationPage()
//             : const FirstSplashScreen(),






// Builder(builder: (context) {
//           return FutureBuilder(
//               future: authService.getUserData(context),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   return Provider.of<UserProvider>(context)
//                           .user
//                           .token
//                           .isNotEmpty
//                       ? const HomePage()
//                       : const LoginPage();
//                 }
//                 return const LoginPage();
//               });
//         }),

// initialRoute: "/",
        // routes: {
        //   "/": (context) => const FirstSplashScreen(),

        //   SecondSplashScreen.routeName: (context) => const SecondSplashScreen(),

        //   // Authentication Page Section
        //   MainPage.routeName: (context) => const MainPage(),
        //   LoginPage.routeName: (context) => const LoginPage(),
        //   SignupPage.routeName: (context) => const SignupPage(),
        //   VerifyMobile.routeName: (context) => const VerifyMobile(),
        //   VerifiedPage.routeName: (context) => const VerifiedPage(),
        //   ForgotPassword.routeName: (context) => ForgotPassword(),

        //   // Home Page Section
        //   HomePage.routeName: (context) => const HomePage(),
        //   // Home Page - Category Pages
        //   CategoryDetailPage.routeName: (context) => const CategoryDetailPage(),
        //   CategoryGirdPage.routeName: (context) => const CategoryGirdPage(),

        //   // Description Page
        //   DescriptionPage.routeName: (context) => const DescriptionPage(),
        //   StudioDescriptionPage.routeName: (context) =>
        //       const StudioDescriptionPage(),
        //   AppliedPage.routeName: (context) => const AppliedPage(),

        //   // My Application Page Section
        //   MyApplicationPage.routeName: (context) => const MyApplicationPage(),
        //   MyApplicationAppliedPage.routeName: (context) =>
        //       const MyApplicationAppliedPage(),

        //   // Inbox Page Section
        //   InboxPage.routeName: (context) => const InboxPage(),
        //   InboxMessagePage.routeName: (context) => const InboxMessagePage(),
        //   MessagePage.routeName: (context) => const MessagePage(),

        //   // My Profile Page Section
        //   // MyProfile.routeName: (context) => const MyProfile(),
        //   MyProfilePage.routeName: (context) => const MyProfilePage(),
        //   MediaProfilePage.routeName: (context) => const MediaProfilePage(),
        //   // My Profile Page - Basic Page
        //   BasicInfoPage.routeName: (context) => const BasicInfoPage(),
        //   // My Profile Page - Appearance Page
        //   AppearancePage.routeName: (context) => const AppearancePage(),
        //   // My Profile Page - Social Media Page
        //   SocialMediaPage.routeName: (context) => const SocialMediaPage(),
        //   // My Profile Page - Membership Page
        //   MembershipPage.routeName: (context) => const MembershipPage(),
        //   // My Profile Page - Skills Page
        //   SkillsPage.routeName: (context) => const SkillsPage(),
        //   // My Profile Page - Credits Page
        //   CreditsPage.routeName: (context) => const CreditsPage(),
        //   // My Profile Page - Subscription Page
        //   SubscriptionPage.routeName: (context) => const SubscriptionPage(),
        //   // My Profile Page - Create Profile Page
        //   CreateProfilePage.routeName: (context) => const CreateProfilePage(),
        //   // My Profile Page - Settings Page
        //   SettingsPage.routeName: (context) => const SettingsPage(),

        //   // Payment Page
        //   PaymentPage.routeName: (context) => const PaymentPage(),

        //   // Bottom Navigation Bar
        //   BottomNavigationPage.routeName: (context) =>
        //       const BottomNavigationPage(),

        //   // Studio Part

        //   // Home Page
        //   SHomePage.routeName: (context) => const SHomePage(),

        //   // MyApplication Page
        //   SMyApplicationPage.routeName: (context) => const SMyApplicationPage(),
        //   // MyApplication Page - All Jobs Page
        //   SAllJobsPage.routeName: (context) => const SAllJobsPage(),
        //   // My Application Page - Actor Profile Page
        //   SActorProfilePage.routeName: (context) => const SActorProfilePage(),
        //   // My Application Page - Designation Page
        //   SDesignationPage.routeName: (context) => const SDesignationPage(),
        //   // My Application Page - Dancer Profile Page
        //   SDancerProfilePage.routeName: (context) => const SDancerProfilePage(),
        //   // My Application Page - Writer Page
        //   SWriterProfilePage.routeName: (context) => const SWriterProfilePage(),

        //   // Inbox Page
        //   SInboxPage.routeName: (context) => const SInboxPage(),
        //   // Inbox Page - Message Page
        //   SInboxMessagePage.routeName: (context) => const SInboxMessagePage(),
        //   // Inbox Page - Chat Page
        //   SMessagePage.routeName: (context) => const SMessagePage(),

        //   // My Profile Page
        //   SMyProfile.routeName: (context) => const SMyProfile(),
        //   // My Profile Page - Project Page
        //   SMyProfilePage.routeName: (context) => const SMyProfilePage(),
        //   // My Profile Page - Subscription Page
        //   SSubscriptionPage.routeName: (context) => const SSubscriptionPage(),
        //   // My Profile Page - Payment Page
        //   SPaymentPage.routeName: (context) => const SPaymentPage(),
        //   // My Profile Page - Payment Page - Add Card
        //   SAddCardPage.routeName: (context) => const SAddCardPage(),
        //   // My Profile Page - Invite Page
        //   SInviteFriendsPage.routeName: (context) => const SInviteFriendsPage(),

        //   // Studio Bottom Navigation Bar
        //   SBottomNavigationPage.routeName: (context) =>
        //       const SBottomNavigationPage(),
        // },