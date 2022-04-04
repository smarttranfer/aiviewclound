import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWidget extends StatefulWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final Widget? headerText;
  final Widget? suffixIcon;
  final String? hint;
  final String? errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType? inputType;
  final TextStyle? textStyle;
  final double? hintFontSize;
  final String? hintFontFamily;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode? focusNode;
  final ValueChanged? onFieldSubmitted;
  final ValueChanged? onChanged;
  final bool autoFocus;
  final TextInputAction? inputAction;
  final bool? isDense;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();

  const TextFieldWidget({
    Key? key,
    this.icon,
    this.errorText,
    required this.textController,
    this.inputType,
    this.headerText,
    this.hint,
    this.suffixIcon,
    this.iconWidget,
    this.isDense = false,
    this.textStyle,
    this.isObscure = false,
    this.isIcon = false,
    this.padding = const EdgeInsets.all(0),
    this.hintFontSize = 17,
    this.hintFontFamily = 'SFProDisplay-Regular',
    this.hintColor = const Color(0xff818181),
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
  }) : super(key: key);
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late bool _obscureText;

  Widget? get _suffixIcon {
    if (widget.isObscure) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: widget.textController.text.isNotEmpty
              ? Icon(
                  _obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye,
                  color: Theme.of(context).primaryColor,
                )
              : Container(),
        ),
      );
    } else {
      return widget.suffixIcon;
    }
  }

  @override
  void initState() {
    _obscureText = widget.isObscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        widget.headerText ?? Container(),
        TextFormField(
          controller: widget.textController,
          focusNode: widget.focusNode,
          onFieldSubmitted: widget.onFieldSubmitted,
          onChanged: widget.onChanged,
          autofocus: widget.autoFocus,
          textInputAction: widget.inputAction,
          obscureText: widget.isObscure,
          keyboardType: this.widget.inputType,
          style: widget.textStyle ??
              TextStyle(
                fontFamily: 'SFProDisplay-Regular',
                fontSize: 17.sp,
                color: Colors.white,
              ),
          inputFormatters: [
            LengthLimitingTextInputFormatter(150),
          ],
          decoration: InputDecoration(
            hintText: this.widget.hint,
            isDense: this.widget.isDense,
            contentPadding: EdgeInsets.only(left: 16),
            filled: true,
            fillColor: const Color(0xff2b2f33),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide.none),
            enabledBorder: InputBorder.none,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.iconWidget ?? null,
            suffixIconConstraints: BoxConstraints(maxHeight: 24, minHeight: 24),
            errorStyle: TextStyle(
                color: const Color(0xfffd413c),
                fontWeight: FontWeight.w400,
                fontFamily: "SFProDisplay",
                fontStyle: FontStyle.normal,
                height: 0.9,
                fontSize: 11.0),
            errorText: this.widget.errorText ?? "",
            hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: widget.hintColor,
                fontSize: widget.hintFontSize,
                fontFamily: widget.hintFontFamily),
          ),
        )
      ]),
    );
  }
}

const String _svg_z8sqxk =
    '<svg viewBox="0.4 24.0 343.0 47.5" ><path transform="translate(0.39, 24.0)" d="M 335 0 C 339.4182739257812 0 343 3.546777009963989 343 7.921948909759521 L 343 39.60974502563477 C 343 43.98491668701172 339.4182739257812 47.53169250488281 335 47.53169250488281 L 8 47.53169250488281 C 3.581721782684326 47.53169250488281 0 43.98491668701172 0 39.60974502563477 L 0 7.921948909759521 C 0 3.546777009963989 3.581721782684326 0 8 0 L 335 0 Z" fill="#2b2f33" stroke="none" stroke-width="1" stroke-miterlimit="10" stroke-linecap="butt" /></svg>';
