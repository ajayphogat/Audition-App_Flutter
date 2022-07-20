import 'package:flutter/material.dart';

Widget commonTextField(
    BuildContext context, controller, String hintText, icon, bool isPassword) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 120,
    child: Stack(
      children: [
        Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: MediaQuery.of(context).size.width - 120,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFFDF5F2),
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please fill this";
            } else {
              return null;
            }
          },
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 15,
              color: Color(0xFF979797),
            ),
            errorStyle: const TextStyle(
              height: 0.1,
            ),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 5),
              child: Icon(icon, color: Colors.black, size: 30),
            ),
          ),
        ),
      ],
    ),
  );
}

InkWell basicButton(BuildContext context, formKey, routeName, String text) {
  return InkWell(
    onTap: () {
      if (formKey.currentState!.validate()) {
        routeName == "/home-page"
            ? Navigator.pushNamedAndRemoveUntil(
                context, routeName, (route) => false)
            : Navigator.pushNamed(context, routeName);
      }
    },
    child: Container(
      alignment: Alignment.center,
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF9D422),
      ),
      child: Text(text),
    ),
  );
}
