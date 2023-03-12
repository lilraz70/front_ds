import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import '../../components/alerts.dart';
import '../../components/app_custom_button.dart';
import '../../configs/app_routes.dart';
import '../../constants/colors.dart';
import '../../controllers/auth_controller.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class AuthView extends StatefulWidget{
  const AuthView({Key? key}) : super(key: key);
  @override
  AuthViewState createState() => AuthViewState();
}
class AuthViewState extends State<AuthView> {
 AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // AuthController authController = Get.put(AuthController());

    // bool erroBorder = false;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // padding: EdgeInsets.only( left: 30, right: 30),
          children: [
         const Text( 'Connexion',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ).center(),
            20.height,
            const Text(
              'Numéro de téléphone',
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            5.height,
            IntlPhoneField(
              initialCountryCode: "BF",
              flagsButtonPadding: const EdgeInsets.only(left: 10),
              style: const TextStyle(
                fontSize: 18,
              ),
              dropdownTextStyle: const TextStyle(
                  fontSize: 18
              ),
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: "Numéro de téléphone",
                hintStyle: const TextStyle(
                  fontSize: 16,
                ),

                  border: OutlineInputBorder(
                    borderSide: const BorderSide(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: const EdgeInsets.all(7),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(
                      color: Colors.black54
                  ))
              ),
              dropdownIconPosition: IconPosition.trailing,
              showCountryFlag: false,
              onCountryChanged: (country) {
                // controller.countryCode.text = "+${country.name}";
              },

              onChanged: (phone) {
                controller.phone.text = phone.completeNumber;
              },

              onSaved: (phone) {
                controller.phone.text = phone!.completeNumber;
              },
              invalidNumberMessage: 'Numéro incomplète',
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9]'))],
             // searchText: 'Cherchez un pays',
            ),
            15.height,
            AppCustomButton(
              bgColor: AppColors.mainColor,
              onTap: () {
                controller.phone.text.length < 12

                    ? warningAlert(context, "Numéro incomplète", "Veuillez saisir un numero valide.")
                    : Get.toNamed(
                    RouteName.loading,
                    arguments: {
                      'init': controller.requestOTP(),
                      'text': "Envoi du code OTP ..."
                    });

              },

              // onTap: () {
              //   controller.requestOTP();
              // },
              isFilled: true,
              textColor: AppColors.white,
              text:  "Connexion",
            ),
            35.height,
                Column(
                  children: [
                  const  Text("Ou connectez-vous avec"),
                    Container(
                      margin: EdgeInsets.only(right: 20, left: 20, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          builFacebookTextButton(MaterialCommunityIcons.facebook,
                              "Facebook", Color(0xFF3B5999)),
                          builGoogleTextButton(
                              MaterialCommunityIcons.google_plus,
                              "Google",
                              Color(0xFFDE4B39)),
                        ],
                      ),
                    )
                  ],
                ),
          ],
        ),
      ).center(),
    );
  }

  TextButton builFacebookTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
        onPressed: (() {
          controller.facebook() ;
        }),
        style: TextButton.styleFrom(
          side: const BorderSide(width: 1, color: Colors.grey),
          minimumSize: const Size(155, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon),
          const   SizedBox(
              width: 5,
            ),
            Text(title),
          ],
        ));
  }
  TextButton builGoogleTextButton(
      IconData icon, String title, Color backgroundColor) {
    return TextButton(
        onPressed: (() {
          controller.google();
        }),
        style: TextButton.styleFrom(
          side: const BorderSide(width: 1, color: Colors.grey),
          minimumSize: const Size(155, 40),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
        ),
        child: Row(
          children: [
            Icon(icon),
         const SizedBox(
              width: 5,
            ),
            Text(title),
          ],
        ));
  }
}



