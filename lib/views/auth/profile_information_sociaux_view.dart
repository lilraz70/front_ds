import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';

import '/components/app_custom_button.dart';
import '/components/custom_text_field.dart';
import '/constants/colors.dart';
import '/controllers/profile_information_controller.dart';




class ProfileInformationSociauxView extends StatelessWidget {
  const ProfileInformationSociauxView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ProfileInformationController controller = Get.put(ProfileInformationController());

    return Scaffold(

      backgroundColor: AppColors.bg,

      body: Container(
        padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Form(
                key: controller.formKey,
                child: Column(
                  children: [

                    const Text(
                      'Profil',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                        color: Colors.black87,
                      ),
                    ),

                    35.height,
                    CustomTextField(
                      title: "Pseudo",
                      textInputAction: TextInputAction.next,
                      placeholder: 'Ex: monvendeur...',
                      controller: controller.pseudo,
                      validator: controller.pseudoValidator,
                    ),

                    15.height,

                    CustomTextField(
                      title: "Nom",
                      textInputAction: TextInputAction.next,
                      placeholder: 'Ex: Ouedraogo...',
                      controller: controller.name,
                      validator: controller.nameValidator,
                    ),
                    15.height,
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
                    16.height,
                    AppCustomButton(
                      onTap: () { controller.postUserData(); },
                      text: "Continuer",
                      textColor: AppColors.white,
                      bgColor: AppColors.customAmber,
                      isFilled: true,
                    ),

                  ],
                ),
              ),

            ],
          ),
        ).center(),
      ),
    );

  }
}