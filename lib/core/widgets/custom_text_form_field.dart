import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/core/utilities/app_colors.dart';
import 'package:svg_flutter/svg.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.isPassword = false,
    required this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.controller,
    this.visibility,
    this.onChanged,
    this.withValidator = false,
    this.isEmail = false,
    this.isName = false,
    this.suffixIconPath,
    this.prefixIconPath,
    this.maxLines = 1,
  });
  final bool isEmail, isName, isPassword;
  final String hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final Function()? visibility;
  final Function(dynamic value)? onChanged;
  final bool? withValidator;
  final String? suffixIconPath;
  final String? prefixIconPath;
  final int maxLines;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isSecureValue = widget.isPassword;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeColor = Theme.of(context);
    return TextFormField(
      obscureText: isSecureValue,
      controller: widget.controller,
      cursorColor: themeColor.primaryColor,
      cursorHeight: 25,
      maxLines: widget.maxLines,
      validator: (value) {
        if (widget.withValidator!) {
          if (value == null || value.isEmpty) {
            return "${widget.hintText} is Required";
          } else if (widget.isPassword == true) {
            if (value.length < 8) {
              return "Password must be at least 8 characters";
            }
          } else if (widget.isEmail == true) {
            if (!value.contains("@") ||
                !value.contains(".") ||
                !(RegExp(r'[a-zA-Z0-9@._-]')).hasMatch(value)) {
              return "Email is not valid";
            }
          }
        }
        return null;
      },
      onSaved: (newValue) {
        widget.controller?.text = newValue!;
      },
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      textInputAction: widget.textInputAction,
      canRequestFocus: true,
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus(
          disposition: UnfocusDisposition.previouslyFocusedChild,
        );
      },
      onTapUpOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(
        disposition: UnfocusDisposition.previouslyFocusedChild,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.lightBlack,
        hintText: widget.hintText,
        suffixIcon: widget.isPassword == true
            ? GestureDetector(
                onTap: () {
                  isSecureValue = !isSecureValue;
                  setState(() {});
                },
                child: isSecureValue
                    ? const Icon(CupertinoIcons.eye, color: AppColors.white)
                    : const Icon(
                        CupertinoIcons.eye_slash,
                        color: AppColors.white,
                      ),
              )
            : widget.suffixIconPath != null
            ? SvgPicture.asset(
                widget.suffixIconPath!,
                height: 24,
                width: 24,
                fit: .scaleDown,
                colorFilter: const ColorFilter.mode(AppColors.white, .srcIn),
              )
            : null,
        prefixIcon: widget.prefixIconPath != null
            ? SvgPicture.asset(
                widget.prefixIconPath!,
                colorFilter: const ColorFilter.mode(AppColors.white, .srcIn),
                height: 24,
                width: 24,
                fit: .scaleDown,
              )
            : null,
      ),
    );
  }
}