


// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:chat_app/Controllers/registration_controller.dart';
import 'package:chat_app/View/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  RegistrationScreen({Key? key}) : super(key: key);

  RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(Get.height*0.02),
        child: SingleChildScrollView(
          child: Form(
            key: controller.key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*0.10),
                Text(
                  'Register Here',
                  style: Get.textTheme.headline1!.copyWith(
                    color: Colors.blue,
                    fontSize: Get.width*0.08,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Get.height*0.05),
                TextFormField(
                  controller: controller.userName,
                  enabled: true,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blue,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter your Name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                    Colors.blue.withOpacity(.2),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    disabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    labelText: "User name",
                    contentPadding:
                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    labelStyle:
                    TextStyle(color: Colors.black),
                    hintStyle:  TextStyle(
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: Get.height*0.03),
                TextFormField(
                  controller: controller.phoneNumber,
                  enabled: true,
                  maxLines: 1,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.blue,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  validator: (value){
                    if (value!.isEmpty) {
                      return "Enter your mobile number.";
                    } else if (value.length < 10) {
                      return "Enter a valid mobile number.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                    Colors.blue.withOpacity(.2),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    disabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    labelText: "Mobile Number",
                    contentPadding:
                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    labelStyle:
                    TextStyle(color: Colors.black),
                    hintStyle:  TextStyle(
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: Get.height*0.03),
                TextFormField(
                  controller: controller.email,
                  enabled: true,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blue,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter your Email";
                    }else if(!controller.emailRegex.hasMatch(value)){
                      return "Enter a valid email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                    Colors.blue.withOpacity(.2),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    disabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    labelText: "Email",
                    contentPadding:
                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    labelStyle:
                    TextStyle(color: Colors.black),
                    hintStyle:  TextStyle(
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: Get.height*0.03),
                TextFormField(
                  controller: controller.password,
                  enabled: true,
                  maxLines: 1,
                  obscureText: controller.secureText.value,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blue,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter your password";
                    }else if(value.length < 6){
                      return "Password should be at least 6 characters";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.secureText.value =
                        !controller.secureText.value;
                      },
                      icon: Icon(controller.secureText.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      color: Colors.black,
                    ),
                    fillColor:
                    Colors.blue.withOpacity(.2),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    disabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    labelText: "Password",
                    labelStyle:
                    TextStyle(color: Colors.black),
                    contentPadding:
                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    hintStyle:  TextStyle(
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: Get.height*0.03),
                TextFormField(
                  controller: controller.confirmPassword,
                  enabled: true,
                  maxLines: 1,
                  obscureText: controller.securePText.value,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blue,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter ConfirmPassword";
                    }else if(controller.password.value.text != controller.confirmPassword.value.text){
                      return "Password not match";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.securePText.value =
                        !controller.securePText.value;
                      },
                      icon: Icon(controller.securePText.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      color: Colors.black,
                    ),
                    fillColor: Colors.blue.withOpacity(.2),
                    enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    disabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(5)),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    labelText: "Confirm Password",
                    labelStyle:
                    TextStyle(color: Colors.black),
                    contentPadding:
                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    hintStyle:  TextStyle(
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: Get.height*0.06),
                controller.isRegister.value ?
                const CircularProgressIndicator(color: Colors.blue,)
                    :  Bounce(
                  duration: const Duration(milliseconds: 150),
                  onPressed: ()async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(const Duration(milliseconds: 500));
                    if(controller.key.currentState!.validate()){
                      controller.isRegister.value = true;
                      controller.registration(context);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(05),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue
                                .withOpacity(0.5),
                            spreadRadius: 1.5,
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ]),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(
                          Get.width*0.02,
                        ),
                        child: Text(
                          "Register",
                          style: Get.textTheme.headline1!.copyWith(
                            color: Colors.white,
                            fontSize: Get.width*0.07,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Get.height*0.06),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: Get.width * 0.042,
                        color:Colors.black,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.01),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()),result: (Route<dynamic> route) => false,);
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: Get.width * 0.042,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    ));
  }
}
