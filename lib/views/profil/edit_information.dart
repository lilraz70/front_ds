import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../constants/colors.dart';
import '../../controllers/edit_profil_controller.dart';

class EditInformationView extends StatefulWidget {
  @override
  EditeInformationViewState createState() => EditeInformationViewState();
}

class EditeInformationViewState extends State<EditInformationView> {
  @override
  Widget build(BuildContext context) {
    EditProfilController controller = Get.put(EditProfilController());
    return Column(
      children: [
        buildTextField(
          icon: MaterialCommunityIcons.account_outline,
          labelText: "Nom et prenom",
          isPassword: false,
          isEmail: false,
          controller: controller.name,
          validator: controller.NameValidator,
        ),
        10.height,
        buildTextField(
          icon: MaterialCommunityIcons.account_outline,
          labelText: "Pseudo",
          isPassword: false,
          isEmail: false,
          controller: controller.pseudo,
          validator: controller.PseudoValidator,
        ),
        10.height,
        buildTextField(
            icon: MaterialCommunityIcons.phone,
            labelText: "Numéro de téléphone",
            isPassword: false,
            isEmail: false,
            controller: controller.telephone,
            validator: controller.telephoneValidator),
        20.height,
        Container(
            alignment: Alignment.center,
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(() {
              if (controller.isLoading ==  false ) {
                return InkWell(
                  onTap: (() {
                    controller.updateUser();
                  }),
                  child: const Text(
                    "Modifier ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                );
              } else {
                return  LoadingAnimationWidget.fourRotatingDots(
                  color: Colors.white,
                  size: 20,
                );
              }
            })),
        15.height,
      ],
    );
  }

  Widget buildTextField(
      {IconData? icon,
      String? labelText,
      bool? isPassword,
      bool? isEmail,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        validator: validator,
        obscureText: isPassword!,
        keyboardType:
            isEmail! ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(
              icon,
              color: const Color(0xFFB6C7D1),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFA7BCC7)),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFA7BCC7)),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: const EdgeInsets.all(10),
            //   hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
            )),
        controller: controller,
      ),
    );
  }

  Widget buildDateTextField(
      {IconData? icon,
      String? labelText,
      bool? isPassword,
      TextEditingController? controller,
      String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        validator: validator,
        readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(
              icon,
              color: Color(0xFFB6C7D1),
            ),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFA7BCC7)),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0XFFA7BCC7)),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: const EdgeInsets.all(10),
            //   hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 14,
            )),
        onTap: () async {
          await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2030),
          ).then((selectedDate) {
            if (selectedDate != null) {
              controller!.text = DateFormat('dd-MM').format(selectedDate);
            }
          });
        },
      ),
    );
  }
}
