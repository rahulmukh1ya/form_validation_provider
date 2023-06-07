import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.errorText,
      this.onChanged,
      this.validator,
      this.inputFormatters});

  final String hintText;
  final String labelText;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            onChanged: onChanged,
            validator: validator,
            inputFormatters: inputFormatters,
            decoration:
                InputDecoration(hintText: hintText, errorText: errorText),
          )
        ],
      ),
    );
  }
}
