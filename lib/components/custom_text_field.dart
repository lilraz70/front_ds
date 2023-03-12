import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomTextField extends StatelessWidget {

  final String placeholder;
  final String title;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool? autofocus;

  const CustomTextField({
    Key? key,
    required this.placeholder,
    required this.title,
    required this.controller,
    required this.textInputAction,
    this.validator,
    this.keyboardType,
    this.autofocus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),

        5.height,
        // const SizedBox(height: 5.0),

        TextFormField(
          autofocus: autofocus ?? false,
          validator: validator,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            isDense: true,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black38,
            ),
            fillColor: Colors.white,
            hintText: placeholder,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.2, color: Colors.black54),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.2, color: Colors.black54),
              borderRadius: BorderRadius.circular(10.0),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.2, color: Colors.black54),
              borderRadius: BorderRadius.circular(10.0),
            ),

            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(width:  1.2, color: Colors.red),
              borderRadius: BorderRadius.circular(10.0),
            ),

          ),
          controller: controller,
        )
      ],
    );
  }

}