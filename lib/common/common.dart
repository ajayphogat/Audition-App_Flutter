import 'package:flutter/material.dart';

Widget commonTextField(
    BuildContext context, controller, String hintText, icon, bool isPassword) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 120,
    child: Stack(
      children: [
        Material(
          elevation: 5,
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
        routeName == "/bottomNavigation-Page"
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

InkWell longBasicButton(BuildContext context, routeName, String text) {
  return InkWell(
    onTap: () {
      Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
    },
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 160,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF9D422)),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    ),
  );
}

Material textContainer(double screenWidth, double screenHeight, String s1,
    String s2, String s3, picture) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.175,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: Image.asset(
              "asset/images/uiImages/$picture.png",
              isAntiAlias: true,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  s1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s2,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  s3,
                  style: const TextStyle(
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Material gridViewContainer(
    double screenWidth, double screenHeight, String s1, String s2, String s3) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.21,
            width: screenWidth * 0.50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: Image.asset(
              s3,
              isAntiAlias: true,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(
                  s1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s2,
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xFF979797)),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
