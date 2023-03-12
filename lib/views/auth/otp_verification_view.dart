import 'dart:async';

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

import '../../components/alerts.dart';
import '../../components/app_custom_button.dart';
import '../../configs/app_routes.dart';
import '../../constants/colors.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/otp_verification_controller.dart';

class OtpVerificationView extends StatelessWidget {
  const OtpVerificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OtpVerificationController controller = Get.put(OtpVerificationController());
    AuthController authController = Get.put(AuthController());
    // final String? phoneNumber = '';
    // bool hasError = false;
    // String currentText = "";
    // final formKey = GlobalKey<FormState>();

    return Scaffold(
      // backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // const SizedBox(height: 30),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height / 3,
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(30),
            //     child: Image.asset(Constants.otpGifImage),
            //   ),
            // ),
            // const SizedBox(height: 8),

            const Text(
              'Verification Code OTP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              textAlign: TextAlign.center,
            ),

            20.height,

            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 8.0),
            //   child: Text(
            //     'Verification Code OTP',
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            //     textAlign: TextAlign.center,
            //   ),
            // ),

            EasyRichText(
              "Entrez le code à 6 chiffres envoyé au ${controller.phoneNumber}",
              textAlign: TextAlign.center,
              defaultStyle:
                  const TextStyle(color: Colors.black54, fontSize: 15),
              patternList: [
                EasyRichTextPattern(
                    hasSpecialCharacters: true,
                    targetString: controller.phoneNumber,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    )),
              ],
            ),

            // Padding(
            //   padding:
            //   const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            //   child: RichText(
            //     text: TextSpan(
            //         text: "Entrez le code à 6 chiffres envoyé au",
            //         children: [
            //           TextSpan(
            //               text: authController.phoneController.text,
            //               style: const TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 15)),
            //         ],
            //         style:
            //         const TextStyle(color: Colors.black54, fontSize: 15)),
            //     textAlign: TextAlign.center,
            //   ),
            // ),

            20.height,

            // const SizedBox(
            //   height: 20,
            // ),

            Form(
              key: controller.formKey,
              child: PinCodeTextField(
                controller: controller.otp,
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                onChanged: (value) {
                  // authController.otpPin = value;
                },
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveColor: Colors.black54,
                  activeColor: Colors.black54,
                  inactiveFillColor: Colors.white,
                  selectedColor: AppColors.customAmber,
                  selectedFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                keyboardType: TextInputType.number,
              ),
            ),

            // Padding(
            //     padding: const EdgeInsets.symmetric(
            //         vertical: 8.0, horizontal: 30),
            //     child:  PinCodeTextField(
            //       appContext: context,
            //       pastedTextStyle: TextStyle(
            //         color: Colors.green.shade600,
            //         fontWeight: FontWeight.bold,
            //       ),
            //       length: 6,
            //       onChanged: (value){
            //         authController.otpPin = value;
            //       },
            //       animationType: AnimationType.fade,
            //       pinTheme: PinTheme(
            //         shape: PinCodeFieldShape.box,
            //         borderRadius: BorderRadius.circular(10),
            //         fieldHeight: 50,
            //         fieldWidth: 40,
            //         activeFillColor: Colors.white,
            //         inactiveColor: Colors.black54,
            //         activeColor: Colors.black54,
            //         inactiveFillColor: Colors.white,
            //         selectedColor: AppColors.customAmber,
            //         selectedFillColor: Colors.white,
            //       ),
            //       cursorColor: Colors.black,
            //       animationDuration: const Duration(milliseconds: 300),
            //       enableActiveFill: true,
            //       keyboardType: TextInputType.number,
            //     )
            // ),

            20.height,

            Obx(() => const Text(
                  "Veuillez renseignez tous les 6 chiffres du code !",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ).visible(controller.hasError.value)),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
            //   child: Text(
            //     hasError ? "SVP entrez un code otp correct" : "",
            //     style: const TextStyle(
            //         color: Colors.red,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),

            10.height,

            // const SizedBox(
            //   height: 20,
            // ),

            AppCustomButton(
              bgColor: AppColors.mainColor,
              onTap: () {
                controller.verifyOTP();

                // if(authController.otpPin.length >=6){
                //   authController.verifyOTP();
                // }
                // else{
                //   Get.snackbar('Code OTP', 'Renseigner correctement le code OTP');
                // }
              },
              isFilled: true,
              textColor: AppColors.white,
              text: 'Vérification',
            ),

            // Container(
            //   margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
            //   child: AppCustomButton(
            //     bgColor: AppColors.customAmber,
            //     onTap: (){
            //       if(authController.otpPin.length >=6){
            //         authController.verifyOTP();
            //       }
            //       else{
            //         Get.snackbar('Code OTP', 'Renseigner correctement le code OTP');
            //       }
            //     },
            //     isFilled: true,
            //     textColor: AppColors.white,
            //     text: 'Vérification',
            //   ),
            //   decoration: BoxDecoration(
            //     color: AppColors.customAmber,
            //     borderRadius: BorderRadius.circular(5),
            //   ),
            // ),

            30.height,

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Pas encore recu le code ?",
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                ),
                InkWell(
                  onTap: ((){
                    authController.requestOTP();
                  }),
                  child: Text(
                    "Renvoyer",
                    style: TextStyle(
                        color: AppColors.mainColor2,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ).center(),
    );
  }
}
