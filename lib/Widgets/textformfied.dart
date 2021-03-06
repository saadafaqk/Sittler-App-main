import 'package:flutter/material.dart';

class TextFormFields {
  static Widget textFormFields(
      String label, String hint, TextEditingController? controller,
      {required Widget? widget,
      required Widget? sufixIcon,
      required bool obscureText,
      required TextInputType keyboardType,
      required TextInputAction textInputAction,
      required FormFieldValidator validator}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Column(
        children: [
          const SizedBox(
            height: 4.0,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  // readOnly: widget == null ? false : true,
                  textInputAction: textInputAction,
                  autofocus: false,
                  cursorColor: const Color(0xff004aa0),
                  controller: controller,
                  validator: validator,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: hint,
                    label: Text(
                      hint,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: sufixIcon,
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff004aa0), width: 2.0),
                    ),
                  ),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    ),
            ],
          ),
          const SizedBox(
            height: 4.0,
          ),
        ],
      ),
    );
  }
}
