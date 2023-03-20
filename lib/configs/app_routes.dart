import 'package:front_ds/bindings/edit_profil_binding.dart';
import 'package:front_ds/configs/session_data.dart';
import 'package:front_ds/views/pubs/my_pub_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../bindings/pub_binding.dart';
import '../bindings/auth_binding.dart';
import '../bindings/besoin_binding.dart';
import '../bindings/home_binding.dart';
import '../bindings/loading_binding.dart';
import '../bindings/otp_verification_binding.dart';
import '../bindings/profile_information_binding.dart';
import '../bindings/edit_pub_binding.dart';
import '../bindings/release_good_binding.dart';
import '../pages/enregistrerReleaseGood.dart';
import '../pages/home.dart';
import '../pages/initReleaseGoodSearch.dart';
import '../pages/searchReleaseGoods.dart';
import '../pages/updateReleaseGood.dart';
import '../views/auth/auth_view.dart';
import '../views/auth/profile_information_sociaux_view.dart';
import '../views/auth/profile_information_view.dart';
import '../views/besoin/besoin_view.dart';
import '../views/besoin/besoin_form_edit_view.dart';
import '../views/besoin/besoin_form_view.dart';
import '../views/besoin/my_besoin_view.dart';
import '../views/loading_view.dart';
import '../views/home/navigation_view.dart';
import '../views/onboarding/on_boarding_view.dart';
import '../views/auth/otp_verification_view.dart';
import '../views/profil/edit_profil_view.dart';
import '../views/profil/profil_view.dart';
import '../widgets/details_widget_view.dart';

class RouteName {
  static String init = '/';
  static String home = '/home';
  static String user = '/register/:userString';

  static String initReleaseGoodSearch = "/initReleaseGoodSearch";
  static String mesPubs = '/mesPubs';
  static String login = '/login';
  static String searchReleaseGood = '/searchReleaseGood';

  static String updateReleaseGood = "/updateReleaseGood";

  static String storeReleaseGood = '/storeReleaseGood';

  static String onBoardingView = '/onBoardingView';
  static String loading = '/loading';
  static String authView = '/authView';
  static String otpVerification = '/otpVerification';
  static String profileInformation = '/profileInformation';
  static String profileInformationSociaux = '/profileInformationSociaux';
  static String besoinView = '/besoinView';
  static String besoinFormView = '/besoinFormView';
  static String besoinFormEditView = '/besoinFormEditView';
  static String detailsWidgetView = '/detailsWidgetView';
  static String navigationView = '/navigationView';
  static String profilView = "/profilView";
  static String editProfilView = '/editProfilView';
  static String myBesoinView = '/myBesoinView';
  static String myPubView = '/myPubView';
}

List<GetPage<dynamic>> appRoutes = [
  GetPage(
      name: RouteName.init,
    //page: ()=> const OnBoardingView() ,
    page: !SessionData.isLoggedIn() ?  ()=> const OnBoardingView() : () => const NavigationView(),
    binding: HomeBinding(),
      ),
  GetPage(
    name: RouteName.home,
    page: () => const Home(),
    binding: HomeBinding(),
  ),
  GetPage(
    name: RouteName.initReleaseGoodSearch,
    page: () => const InitReleaseGoodSearch(),
    // binding:  HomeBinding(),
  ),
  GetPage(
    name: RouteName.login,
    page: () => const AuthView(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: RouteName.searchReleaseGood,
    page: () => const SearchReleaseGoods(),
    binding:  HomeBinding(),
  ),
  GetPage(
    name: RouteName.updateReleaseGood,
    page: () => const UpdateReleaseGood(),
    binding: EditPubBinding(),
  ),
  GetPage(
    name: RouteName.storeReleaseGood,
    page: () => EnregisterReleaseGood(),
    binding: ReleaseGoodBinding(),
  ),
  GetPage(
    name: RouteName.profileInformation,
    page: () => const ProfileInformationView(),
    binding: ProfileInformationBinding(),
  ),
  GetPage(
    name: RouteName.profileInformationSociaux,
    page: () => const ProfileInformationSociauxView(),
    binding: ProfileInformationBinding(),
  ),
  GetPage(
    name: RouteName.loading,
    page: () => const LoadingView(),
    binding: LoadingBinding(),
  ),
  GetPage(
    name: RouteName.authView,
    page: () => const AuthView(),
    binding: AuthBinding(),
  ),
  GetPage(
    name: RouteName.otpVerification,
    page: () => const OtpVerificationView(),
    binding: OtpVerificationBinding(),
  ),
  GetPage(
      name: RouteName.besoinView,
      page: () => BesoinView(),
    binding: BesoinBinding(),
  ),
  GetPage(
    name: RouteName.myBesoinView,
    page: () => const MyBesoinView(),
    binding: BesoinBinding(),
  ),
  GetPage(
    name: RouteName.besoinFormView,
    page: ()=> const  BesoinFormView(),
    binding: BesoinBinding(),
  ),
  GetPage(name: RouteName.besoinFormEditView, page: ()=> const BesoinFormEditView(),
    binding: BesoinBinding(),
  ),
  GetPage(name: RouteName.detailsWidgetView, page: ()=> const DetailsWidgetView(),
    binding: HomeBinding(),
  ),
  GetPage(name: RouteName.navigationView, page: ()=> const NavigationView(),
    binding: HomeBinding(),
  ),
  GetPage(name: RouteName.profilView, page: ()=> const ProfileView(),
    binding: EditProfilBinding(),
  ),
  GetPage(
      name: RouteName.editProfilView,
      page: () => EditProfilView(),
      binding: EditProfilBinding()),
  GetPage(
      name: RouteName.myPubView,
      page: () => const MyPubView(),
      binding: PubBinding()),

];
