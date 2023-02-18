import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/bottomNavigation/inbox.dart';
import 'package:first_app/bottomNavigation/myApplication.dart';
import 'package:first_app/bottomNavigation/notificationPage.dart';
import 'package:first_app/login/loginPage.dart';
import 'package:first_app/login/signUpPage.dart';
import 'package:first_app/pages/categorySection/actorPageGrid.dart';
import 'package:first_app/pages/categorySection/appliedPage.dart';
import 'package:first_app/pages/categorySection/chefPageGrid.dart';
import 'package:first_app/pages/categorySection/chirographerPageGrid.dart';
import 'package:first_app/pages/categorySection/dancerPageGrid.dart';
import 'package:first_app/pages/categorySection/designerPageGrid.dart';
import 'package:first_app/pages/categorySection/musicianPageGrid.dart';
import 'package:first_app/pages/categorySection/painterPageGrid.dart';
import 'package:first_app/pages/categorySection/singerPageGrid.dart';
import 'package:first_app/pages/categorySection/writerPageGrid.dart';
import 'package:first_app/pages/inboxPages/inboxPage.dart';
import 'package:first_app/pages/inboxPages/messagePage.dart';
import 'package:first_app/pages/myApplicationPages/acceptedJobPage.dart';
import 'package:first_app/pages/myApplicationPages/appliedJobPage.dart';
import 'package:first_app/pages/myApplicationPages/declinedJobPage.dart';
import 'package:first_app/pages/myApplicationPages/bookmarkJobPage.dart';
import 'package:first_app/pages/myApplicationPages/shortlistedJobPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/appearancePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/createProfilePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/creditsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/membershipPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/skillsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/socialMediaPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/subscriptionPage.dart';
import 'package:first_app/pages/myProfilePages/mediaPage.dart';
import 'package:first_app/pages/myProfilePages/myProfilePage.dart';
import 'package:first_app/pages/myProfilePages/settingsPage.dart';
import 'package:first_app/pages/paymentPage/paymentPage.dart';
import 'package:first_app/pages/splashScreen/firstScreenNew.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:first_app/studio_code/sbottomNavigation/shomePage.dart';
import 'package:first_app/studio_code/sbottomNavigation/sinbox.dart';
import 'package:first_app/studio_code/sbottomNavigation/smyProfile.dart';
import 'package:first_app/studio_code/sbottomNavigation/snotificationPage.dart';
import 'package:first_app/studio_code/spages/sinboxPages/sinboxPage.dart';
import 'package:first_app/studio_code/spages/sinboxPages/smessagePage.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sAcceptedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sAppliedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sShortlistedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sactorProfilePage.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sallJobs.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sdancerProfilePage.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sdesignationPage.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/swriterProfilePage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/followersPage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sinviteFriends.dart';
import 'package:first_app/studio_code/spages/sprofilePages/smyProfilePage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/saddCard.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/spaymentPage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/ssubscriptionPage.dart';
import 'package:flutter/material.dart';

import '../login/forgotPassword.dart';
import '../login/mainPage.dart';
import '../login/verifiedPage.dart';
import '../login/verifyMobile.dart';
import '../pages/categorySection/categoryDetailPage.dart';
import '../pages/categorySection/descriptionPage.dart';
import '../pages/categorySection/studio_description.dart';
import '../pages/splashScreen/firstScreen.dart';
import '../pages/splashScreen/secondScreen.dart';
import '../studio_code/sbottomNavigation/smyApplication.dart';

Route<dynamic> generatedRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case FirstSplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FirstSplashScreen(),
      );

    case FirstSplashScreenNew.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const FirstSplashScreenNew(),
      );

    case SecondSplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SecondSplashScreen(),
      );

    // Authentication Page Section
    case MainPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainPage(),
      );

    case LoginPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginPage(),
      );

    case SignupPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupPage(),
      );

    case VerifyMobile.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VerifyMobile(),
      );

    case VerifiedPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const VerifiedPage(),
      );

    case ForgotPassword.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ForgotPassword(),
      );

    // Home Page Section
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomePage(),
      );

    // Home Page - Category Pages
    case CategoryDetailPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CategoryDetailPage(),
      );

    // case CategoryGirdPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const CategoryGirdPage(),
    //   );

    // Description Page
    case DescriptionPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const DescriptionPage(),
      );

    case StudioDescriptionPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const StudioDescriptionPage(),
      );

    case AppliedPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AppliedPage(),
      );

    // My Application Page Section
    case MyApplicationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyApplicationPage(),
      );

    case SNotificationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SNotificationPage(),
      );
    case NotificationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotificationPage(),
      );

    // case AcceptedJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AcceptedJobPage(),
    //   );

    // case AppliedJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const AppliedJobPage(),
    //   );

    // case DeclinedJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const DeclinedJobPage(),
    //   );

    // case BookmarkJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const BookmarkJobPage(),
    //   );
    // case FollowersPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const FollowersPage(),
    //   );

    // case ShortlistedJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const ShortlistedJobPage(),
    //   );

    // Inbox Page Section
    case InboxPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const InboxPage(),
      );

    case InboxMessagePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const InboxMessagePage(),
      );

    case MessagePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MessagePage(),
      );

    // My Profile Page Section
    case MyProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MyProfilePage(),
      );

    case MediaProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MediaProfilePage(),
      );

    // My Profile Page - Basic Page
    case BasicInfoPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BasicInfoPage(),
      );

    // My Profile Page - Appearance Page
    case AppearancePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AppearancePage(),
      );

    // My Profile Page - Social Media Page
    case SocialMediaPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SocialMediaPage(),
      );

    // My Profile Page - Membership Page
    case MembershipPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MembershipPage(),
      );

    // My Profile Page - Skills Page
    case SkillsPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SkillsPage(),
      );

    // My Profile Page - Credits Page
    case CreditsPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreditsPage(),
      );

    // My Profile Page - Subscription Page
    case SubscriptionPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SubscriptionPage(),
      );

    // My Profile Page - Create Profile Page
    case CreateProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateProfilePage(),
      );

    // My Profile Page - Settings Page
    case SettingsPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SettingsPage(),
      );

    // Payment Page
    case PaymentPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const PaymentPage(),
      );

    // Bottom Navigation Bar
    case BottomNavigationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const BottomNavigationPage(),
      );

    // Studio Part

    // Home Page
    case SHomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SHomePage(),
      );

    // MyApplication Page
    case SMyApplicationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SMyApplicationPage(),
      );

    // MyApplication Page - All Jobs Page
    // case SAllJobsPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SAllJobsPage(searchEdit: "",),
    //   );

    // case SAppliedJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SAppliedJobPage(),
    //   );
    // case SAcceptedJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SAcceptedJobPage(),
    //   );

    // case SShortlistedJobPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SShortlistedJobPage(),
    //   );

    // My Application Page - Actor Profile Page
    case SActorProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SActorProfilePage(),
      );

    // My Application Page - Designation Page
    case SDesignationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SDesignationPage(),
      );

    // My Application Page - Dancer Profile Page
    case SDancerProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SDancerProfilePage(),
      );

    // My Application Page - Writer Page
    case SWriterProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SWriterProfilePage(),
      );

    // Inbox Page
    case SInboxPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SInboxPage(),
      );

    // Inbox Page - Message Page
    case SInboxMessagePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SInboxMessagePage(),
      );

    // Inbox Page - Chat Page
    case SMessagePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SMessagePage(
          groupId: "",
          groupName: "",
          userName: "",
          profilePic: "",
          adminProfilePic: "",
          chatUserId: "",
        ),
      );

    // My Profile Page
    case SMyProfile.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SMyProfile(),
      );

    // My Profile Page - Project Page
    case SMyProfilePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SMyProfilePage(),
      );

    // My Profile Page - Subscription Page
    case SSubscriptionPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SSubscriptionPage(),
      );

    // My Profile Page - Payment Page
    case SPaymentPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SPaymentPage(),
      );

    // My Profile Page - Payment Page - Add Card
    case SAddCardPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SAddCardPage(),
      );

    // My Profile Page - Invite Page
    case SInviteFriendsPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SInviteFriendsPage(),
      );

    // Studio Bottom Navigation Bar
    case SBottomNavigationPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SBottomNavigationPage(),
      );

    // case ActorGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => ActorGridPage(),
    //   );

    // case ChefGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const ChefGridPage(),
    //   );

    // case DancerGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const DancerGridPage(),
    //   );

    // case DesignerGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const DesignerGridPage(),
    //   );

    // case SingerGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const SingerGridPage(),
    //   );

    // case ChirographerGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const ChirographerGridPage(),
    //   );

    // case PainterGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const PainterGridPage(),
    //   );

    // case MusicianGridPage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const MusicianGridPage(),
    //   );

    // case WriterGridpage.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (_) => const WriterGridpage(),
    //   );

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("404 Not Found"),
                ),
              ));
  }
}
