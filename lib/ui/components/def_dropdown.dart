import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecorator CustomDropdownButton2({
  required String hint,
  value,
  final List<String>? dropdownItems,
  ValueChanged? onChanged,
  final DropdownButtonBuilder? selectedItemBuilder,
  final Alignment? hintAlignment,
  final Alignment? valueAlignment,
  final double? buttonHeight,
  buttonWidth,
  final EdgeInsetsGeometry? buttonPadding,
  final BoxDecoration? buttonDecoration,
  final int? buttonElevation,
  final Widget? icon,
  final double? iconSize,
  final Color? iconEnabledColor,
  final Color? iconDisabledColor,
  final double? itemHeight,
  final EdgeInsetsGeometry? itemPadding,
  final double? dropdownHeight,
  dropdownWidth,
  final EdgeInsetsGeometry? dropdownPadding,
  final BoxDecoration? dropdownDecoration,
  final int? dropdownElevation,
  final Radius? scrollbarRadius,
  final double? scrollbarThickness,
  final bool? scrollbarAlwaysShow,
  final Offset? offset,
  required final double width,
  required final double height,
  final FormFieldValidator? validator,
  final Key? formkey,
  required bool? iserror,
  context,
  FormFieldState? state,
  final Object? function,
  focusnode,
}) {
  return InputDecorator(
    decoration: InputDecoration(
      border: InputBorder.none,
      //labelText: 'Select an option',
      errorText: iserror! ? 'Please select an option' : null,
      errorStyle: TextStyle(fontSize: width * 0.008),
    ),
    child: DropdownButtonHideUnderline(
      child: DropdownButton2(
        //To avoid long text overflowing.
        isExpanded: true,
        focusNode:focusnode ,
        hint: Text(
          hint,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: width * 0.01,
            color: const Color.fromARGB(255, 154, 177, 189),
          ),
        ),
        value: value,

        items: dropdownItems
            ?.map((item) => DropdownMenuItem<String>(
          value: item,
          child: Container(
            alignment: valueAlignment,
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 16.sp,
              ),
            ),
          ),
        ))
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          // height: buttonHeight ?? 40,
          // width: buttonWidth ?? 140,
          padding: buttonPadding ?? const EdgeInsets.only(left: 0, right: 0),
          decoration: buttonDecoration ??
              const BoxDecoration(

                // borderRadius: BorderRadius.circular(14),
                // border: Border.all(
                //   color: Colors.black45,
                // ),
              ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: width * 0.02,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? height * 0.2,
          // width: dropdownWidth ?? width * 0.15,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(14),
              ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          //offset: offset,
          //Default is false to show menu below button
          isOverButton: false,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                ? MaterialStateProperty.all<double>(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? height * 0.05,
          padding:
          itemPadding ?? EdgeInsets.symmetric(horizontal: width * 0.009),
        ),
      ),
    ),
  );
}
