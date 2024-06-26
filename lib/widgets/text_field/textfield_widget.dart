import 'package:common_jds_flutter/common/app_colors.dart';
import 'package:common_jds_flutter/common/styles/app_border_style.dart';
import 'package:common_jds_flutter/common/styles/app_text_style.dart';
import 'package:common_jds_flutter/common/styles/dimens.dart';
import 'package:common_jds_flutter/common/util/validators.dart';
import 'package:common_jds_flutter/widgets/custom_text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomUnderlineTextFieldWithLabel extends StatelessWidget {
  final String? labelText, hintText;
  final String? initialValue, prefixText, suffixText;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType keyboardType;
  final FormFieldValidator<String?>? validator;
  final TextEditingController? controller;
  final ValueChanged<String?>? onChanged, onSaved;
  final int? maxLength, maxLines;
  final int? minLines;
  final bool readOnly, enabled;
  final bool? isDense;
  final Function()? onTap;
  final InputBorder? border;
  final InputBorder? focussedBorder;
  final InputBorder? disableBorder;
  final AutovalidateMode autovalidateMode;
  final BoxConstraints? suffixIconConstraints;
  final EdgeInsets? prefixIconPadding;
  final Color? fillColor;
  final EdgeInsets? contentPadding;
  final FocusNode? focusNode;
  final Widget? rightWidgetToLabel;
  final Color? contentTextColor;
  final Color? labelTextColor;
  final double? labelFontSize;
  final Function? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final bool isObscure;
  final int? errorMaxLines;
  final bool autoFocus;
  final Color? enteredTextColor;
  final bool showHint;
  final bool showLabel;
  final List<TextInputFormatter>? inputFormatters;

  const CustomUnderlineTextFieldWithLabel(
      {Key? key,
      this.labelText,
      this.hintText,
      this.controller,
      this.prefixIcon,
      this.suffixIcon,
      this.showHint = true,
      this.keyboardType = TextInputType.text,
      this.validator = Validators.validateEmpty,
      this.onChanged,
      this.onSaved,
      this.maxLength,
      this.maxLines,
      this.isObscure = false,
      this.minLines,
      this.initialValue,
      this.readOnly = false,
      this.onTap,
      this.focussedBorder = AppBorderStyle.underLineInputBorder,
      this.border = AppBorderStyle.underLineInputBorder,
      this.disableBorder = AppBorderStyle.disableUnderLineInputBorder,
      this.enabled = true,
      this.autovalidateMode = AutovalidateMode.onUserInteraction,
      this.suffixIconConstraints,
      this.prefixText,
      this.suffixText,
      this.isDense,
      this.prefixIconPadding,
      this.fillColor,
      this.focusNode,
      this.rightWidgetToLabel,
      this.contentPadding,
      this.labelFontSize = 20.0,
      this.labelTextColor = AppColors.A6000000,
      this.onFieldSubmitted,
      this.textInputAction,
      this.contentTextColor = AppColors.FF404040,
      this.errorMaxLines = 1,
      this.enteredTextColor,
      this.autoFocus = false,
      this.inputFormatters,
      this.showLabel = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle = AppTextStyle.regularStyle.copyWith(
      color: contentTextColor,
      fontSize: Dimens.size15,
    );

    return IgnorePointer(
      ignoring: readOnly == true || enabled == false,
      child: Theme(
        data: ThemeData(
          focusColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
        ),
        child: TextFormField(
          autofocus: autoFocus,
          onFieldSubmitted: (_) =>
              onFieldSubmitted != null ? onFieldSubmitted!(_) : null,
          textInputAction: textInputAction,
          focusNode: focusNode,
          onTap: onTap,
          readOnly: readOnly,
          obscureText: isObscure,
          initialValue: initialValue,
          keyboardType: keyboardType,
          autovalidateMode: autovalidateMode,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          minLines: minLines,
          maxLines: maxLines,
          /*maxLength: maxLength,*/
          onSaved: onSaved,
          // enabled: enabled,
          cursorColor: AppColors.kPrimaryColor,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          inputFormatters: maxLength == null
              ? null
              : inputFormatters ??
                  [
                    LengthLimitingTextInputFormatter(maxLength),
                    if (keyboardType == TextInputType.number)
                      FilteringTextInputFormatter.digitsOnly,
                    if (keyboardType ==
                        const TextInputType.numberWithOptions(
                            decimal: true, signed: true))
                      FilteringTextInputFormatter.allow(
                          Validators.validDecimal),
                    if (keyboardType ==
                        const TextInputType.numberWithOptions(signed: true))
                      FilteringTextInputFormatter.allow(Validators.validNumber),
                  ],
          style: AppTextStyle.regularStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: (readOnly || !enabled)
                  ? AppColors.FFB5B5B5
                  : enteredTextColor ?? AppColors.FF141414,
              fontSize: 16.0),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            /*  floatingLabelStyle: AppTextStyle.regularStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.A6000000,
                fontSize: Dimens.size14), */
            /*helperText: ' ',*/
            contentPadding: contentPadding,
            fillColor: fillColor,
            filled: fillColor != null,
            isDense: isDense,
            border:
                enabled ? border : AppBorderStyle.disableUnderLineInputBorder,
            // labelText: showLabel ? labelText : null,
            label: (showLabel || labelText != null)
                ? Row(
                    children: [
                      CustomText(
                        text: showLabel ? labelText : null,
                        size: 19,
                        color: (readOnly || !enabled)
                            ? AppColors.textDisabledColor
                            : labelTextColor,
                        fontWeight: CustomFontWeight.medium,
                      ),
                    ],
                  )
                : null,
            enabledBorder:
                enabled ? border : AppBorderStyle.disableUnderLineInputBorder,
            focusedBorder: enabled
                ? focussedBorder
                : AppBorderStyle.disableUnderLineInputBorder,
            errorMaxLines: errorMaxLines,
            labelStyle: AppTextStyle.regularStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: (readOnly || !enabled)
                    ? AppColors.textDisabledColor
                    : labelTextColor,
                fontSize: 19.0),
            alignLabelWithHint: true,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelStyle: AppTextStyle.regularStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: (readOnly || !enabled)
                    ? AppColors.textDisabledColor
                    : AppColors.A6000000,
                fontSize: 19.0),
            hintText: showHint ? hintText : "",
            hintStyle: AppTextStyle.regularStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: (readOnly || !enabled)
                    ? AppColors.textDisabledColor
                    : AppColors.FFB5B5B5,
                fontSize: 16.0),
            prefixIconConstraints: const BoxConstraints(
              maxHeight: 40,
              maxWidth: 40,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Padding(
                    padding:
                        prefixIconPadding ?? const EdgeInsets.only(right: 10),
                    child: prefixIcon,
                  ),
            prefixText: prefixText,
            suffixText: suffixText,
            prefixStyle: textStyle,
            suffixStyle: textStyle,
            suffixIcon: suffixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: suffixIcon,
                  ),
            suffixIconConstraints: suffixIconConstraints ??
                const BoxConstraints(
                  maxHeight: 40,
                  maxWidth: 40,
                ),
          ),
        ),
      ),
    );
  }
}
