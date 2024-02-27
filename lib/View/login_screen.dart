import 'package:chat_app/Controllers/login_controller.dart';
import 'package:chat_app/View/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  LogInController controller = Get.put(LogInController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Get.height*0.02),
        child: Form(
          key: controller.key,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: Get.height*0.10),
                Text(
                  'Login Here',
                  style: Get.textTheme.headline1!.copyWith(
                    color: Colors.blue,
                    fontSize: Get.width*0.08,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: Get.height*0.05),
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
                  decoration:  InputDecoration(
                    filled: true,
                    fillColor: Colors.blue.withOpacity(.2),
                    enabledBorder:  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder:  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                    ),
                    disabledBorder:  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
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
                    const TextStyle(color: Colors.black),
                    hintStyle:  const TextStyle(
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: Get.height*0.03),
                TextFormField(
                  controller: controller.password,
                  maxLines: 1,
                  enabled: true,
                  obscureText: controller.secureText.value,
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.blue,

                  style: const TextStyle(
                    fontSize: 14,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter your password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                    Colors.blue.withOpacity(.2),
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.secureText.value = !controller.secureText.value;
                      },
                      icon: Icon(controller.secureText.value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      color: Colors.black,
                    ),
                    enabledBorder:  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                    ),
                    focusedBorder:  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue,
                          width: 1.5),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
                    ),
                    disabledBorder:  const OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue),
                      borderRadius:
                      BorderRadius.all(Radius.circular(5)),
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
                    const TextStyle(color: Colors.black),
                    contentPadding:
                    const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    hintStyle:  const TextStyle(
                        color: Colors.blue),
                  ),
                ),
                SizedBox(height: Get.height*0.06),
                controller.isLogin.value ?
                const CircularProgressIndicator(color: Colors.blue,)
                   : Bounce(
                  duration: const Duration(milliseconds: 150),
                  onPressed: ()async {
                    FocusScope.of(context).unfocus();
                    if(controller.key.currentState!.validate()){
                      controller.isLogin.value = true;
                      controller.login(context);
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
                          "Login",
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
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: Get.width * 0.042,
                        color:Colors.black,
                      ),
                    ),
                    SizedBox(width: Get.width * 0.01),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen()));

                      },
                      child: Text(
                        "Register",
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
