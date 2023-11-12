import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_dashboard/cubit/auth/auth_cubit.dart';
import 'package:school_dashboard/ui/components/components.dart';

List<String> genderitem = [
  'Male',
  'Female',
];
List<String> isinbus = [
  'Yes',
  'No',
];

List<String> RollAdmin = [
  'Admin',
  'Library',
];
List<String> section = [];


late List<String> classStudent = [];

Widget buttonRegister(
    cubit, height, width, ontap, onenter, onexit, title, color, fontweight) {
  return InkWell(
      onTap: ontap,
      child: MouseRegion(
        onEnter: onenter,
        onExit: onexit,
        child: Container(
          height: height * 0.055,
          width: width * 0.085,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
              child: Text(
                title,
                style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                ),
              )),
        ),
      ));
}

// Widget Row_Name_phone_gender(
//     context,
//     height,
//     width,
//     nameController,
//     nameFocusNode,
//     PhoneController,
//     phoneFocusNode,
//     genderFocusNode,
//     iserrorgender,
//     Valuegender,
//     emailFocusNode) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       def_Container_RegitsterText(
//         focusnode: nameFocusNode,
//         onfieldsubmitted: (value) {
//           FocusScope.of(context).requestFocus(phoneFocusNode);
//         },
//         height: height,
//         width: width,
//         hinttext: "Enter name",
//         title: "Full Name",
//         MyController: nameController,
//         sufix: Icon(
//           Icons.person,
//           size: width * 0.018,
//         ),
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Please Type The Name';
//           }
//           return null;
//         },
//       ),
//       // SizedBox(
//       //   width: width * 0.1,
//       // ),
//       def_Container_RegitsterText(
//         focusnode: phoneFocusNode,
//         onfieldsubmitted: (value) {
//           FocusScope.of(context).requestFocus(genderFocusNode);
//         },
//         height: height,
//         width: width,
//         hinttext: "Enter phone",
//         title: "Phone Number",
//         MyController: PhoneController,
//         sufix: Icon(
//           Icons.phone,
//           size: width * 0.018,
//         ),
//         validator: (value) {
//           value = int.tryParse(value);
//           if (value == null) {
//             return 'Please Type The Phone number';
//           }
//           return null;
//         },
//       ),
//       // SizedBox(
//       //   width: width * 0.05,
//       // ),

//       FormField(
//         validator: (value) {
//           value == null ? iserrorgender = true : iserrorgender = false;
//           if (value == null) {
//             print('errror select');
//             return;
//           }
//           return null;
//         },
//         builder: (FormFieldState<dynamic> state) {
//           return def_Container_Regitsterdropdown(
//             height: height,
//             width: width,
//             hinttext: "Select gender",
//             title: "Gender",
//             item: genderitem,
//             selectedValue: Valuegender,
//             iserror: iserrorgender,
//             focusnode: genderFocusNode,
//             onChanged: (value) {
//               FocusScope.of(context).requestFocus(emailFocusNode);

//               Valuegender = value;

//               value == null ? iserrorgender = true : iserrorgender = false;
//               RegisterCubit.get(context).updatdropdown();

//               state.didChange(value);
//             },
//           );
//         },
//       ),
//     ],
//   );
// }
