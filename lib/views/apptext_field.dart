import 'package:flutter/material.dart';
import 'package:flutter/src/services/text_formatter.dart';
import 'package:get/get.dart';

class AppTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNodeName;
  final String? Function(String?)? validator;
  final double Function(dynamic value)? onChanged;
  final FocusNode? nextFocus;
  final Widget? prefix;
  final Text? title;
  final TextEditingController? controller;
  final bool obscureText;
  final bool visibleText;
  final TextInputType? keyboardType;
  final List<FilteringTextInputFormatter>? inputFormatters;

  const  AppTextField({
    Key? key,
    this.hintText,
    this.labelText,
    this.focusNodeName,
    this.validator,
    this.nextFocus,
    this.title,
    this.prefix,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.visibleText = false,
    this.inputFormatters,
    this.onChanged,
  }) : super(key: key);

  @override
  AppTextFieldState createState() => AppTextFieldState();
}

class AppTextFieldState extends State<AppTextField> {
  bool _isVisible = true;
  // bool _textVisible = true;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            // height: Get.height*0.05,
            // width: Get.width*0.06,
            child: widget.title,),
        SizedBox(height: Get.height*0.01,),
        SizedBox(
          width: screenSize.width * 0.92,
          //height: _screenSize.height*0.08,
          child: TextFormField(
            style:  TextStyle(
              color: Colors.black,
            ),
            controller: widget.controller,
            focusNode: widget.focusNodeName,
            validator: widget.validator,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              // enabledBorder: const UnderlineInputBorder(
              //   borderSide: BorderSide(color: AppColors.bluishGrey),
              // ),
              hintStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
              // hintStyle: const TextStyle(color: AppColors.bluishGrey, fontSize: 20),
              hintText: widget.hintText,
              labelText: widget.labelText,
              labelStyle:  TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
              errorMaxLines: 5,
              // show password
              prefixIcon : widget.prefix,
             //  suffixIcon: widget.obscureText
             //      ? IconButton(
             //    icon: Icon(
             //      _isVisible ? Icons.visibility_off : Icons.visibility,
             //      color: AppColors.grey,
             //    ),
             //    onPressed: () {
             //      setState(() => _isVisible = !_isVisible);
             //    },
             //  )
             //      : null,
             suffixIcon : widget.obscureText
                 ? TextButton(
                 onPressed: (){
                   setState(() => _isVisible = !_isVisible);
                 },
                 child: _isVisible  ?  Text('Show',
                 style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),)
                     :  Text('Hide',
                 style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),)
        : null,

             fillColor: const Color(0xffF4F9FF),
                border:  OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey,
                  ),
                ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:  BorderSide(
                  //color: AppColors.backgroundpurple,
                  width: 2
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide:  BorderSide(
                  color: Colors.grey
                ),
              ),
              //contentPadding:  EdgeInsets.only(left: 15, right: 10.0,bottom: Get.height*0.01),
              //filled: true,

            ),
            //  unfocus on the tap on screen
            textInputAction: widget.nextFocus != widget.focusNodeName
                ? TextInputAction.next
                : TextInputAction.done,
            onEditingComplete: () {
              if(widget.nextFocus != widget.focusNodeName) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(widget.nextFocus);
              } else {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            cursorColor: Theme.of(context).hoverColor,

            //for Password obsure field
            obscureText: widget.obscureText ? _isVisible : false,
          ),
        ),
      ],
    );
  }
}