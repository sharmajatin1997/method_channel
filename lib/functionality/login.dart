import 'dart:convert';

import 'package:esferasoft_task/animations/staggered_list_animation.dart';
import 'package:esferasoft_task/app_helpers/app_buttons.dart';
import 'package:esferasoft_task/app_helpers/app_strings.dart';
import 'package:esferasoft_task/app_helpers/app_textfields.dart';
import 'package:esferasoft_task/colors/app_colors.dart';
import 'package:esferasoft_task/functionality/controller/authcontroller.dart';
import 'package:esferasoft_task/functionality/native_api.dart';
import 'package:esferasoft_task/functionality/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform, exit;
import '../app_helpers/app_text.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final email=TextEditingController();
  final password=TextEditingController();
  final controller=Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    controller.username.value='';
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit?'),
            content: Text('Do you really want to exit?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(), // Dismiss dialog
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  exit(0);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ).then((confirmed) {
          if (confirmed == true) {
            exit(0);
          }
        });

      },
      child: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 60,left: 20,right: 20),
                child: Obx(
                  ()=> Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StaggeredListAnimation(
                        initialDelay: 100,
                        interval: 100,
                        children: [
                          Center(child: Image.asset('assets/mic.png',height: 80,width: 80,)),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: AppText(
                                text: 'SIGN IN\n TO CONTINUE',
                                textSize: 16,
                                lineHeight: 1.5,
                                textAlign: TextAlign.center,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          AppText(
                            text: 'Email Address',
                            fontWeight: FontWeight.w700,
                            textSize: 18.0,
                            color: AppColors.textColor,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          AppTextFields(
                            textFieldColor: Colors.white,
                            borderRadius: 30,
                            validator: (String? value) => LoginValidator.loginValidator(value!, 'email'),
                            textInputType: TextInputType.emailAddress,
                            hintText: "Email Address",
                            controller: email,
                            textLimit: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          AppText(
                            text: 'Password',
                            fontWeight: FontWeight.w700,
                            textSize: 18.0,
                            color: AppColors.textColor,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                         AppTextFields(
                              textFieldColor: Colors.white,
                              borderRadius: 30,
                              obscureText: controller.passVisibility.value,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  controller.passVisibility.value =
                                  !controller.passVisibility.value;
                                },
                                child: Icon(
                                  controller.passVisibility.value
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              textInputType: TextInputType.emailAddress,
                              validator: (String? value) => LoginValidator.loginValidator(value!, 'password'),
                              hintText: "Password",
                              controller: password,
                            ),

                          SizedBox(
                            height: 20,
                          ),
                          AppButtons(
                              text: "LOGIN",
                              onTap: ()async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (formKey.currentState!.validate()) {
                                  controller.isLoading.value=true;
                                  final result = await NativeApiService.loginUser(
                                      email: email.text,
                                      password: password.text,
                                      deviceType: Platform.isAndroid?"android":"ios");
                                  controller.isLoading.value=false;
                                  if(result!=null){
                                    final parsedJson = json.decode(result);
                                    final fullName = parsedJson['data']['full_name'];
                                    controller.username.value=fullName;
                                  }
                                }

                              },
                              margin: const EdgeInsets.only(top: 10, bottom: 30),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child:controller.isLoading.value?SizedBox(
                                height: 20,width: 20,
                                  child: CircularProgressIndicator(color: Colors.white,)):
                              const AppText(
                                text: "LOGIN",
                                textSize: 17.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppStrings.poppins,
                              ),
                            ),
                          SizedBox(
                            height: 20,
                          ),
                           controller.username.value.isNotEmpty?
                            Center(
                              child: AppText(
                                text: "Login Username:- ${controller.username.value}",
                                textSize: 17.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppStrings.poppins,
                              ),
                            ):SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
