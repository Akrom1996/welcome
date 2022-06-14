import 'dart:convert';
import 'dart:io';

import 'package:click_app/customs/back_button.dart';
import 'package:click_app/customs/custom_button.dart';
import 'package:click_app/customs/custom_error_dialog.dart';
import 'package:click_app/customs/custom_headline.dart';
import 'package:click_app/customs/custom_sub_headline.dart';
import 'package:click_app/customs/loading.dart';
import 'package:click_app/models/registration_model.dart';
import 'package:click_app/models/registration_success.dart';
import 'package:click_app/pages/otp_page.dart';
import 'package:click_app/utils/apis.dart';
import 'package:click_app/utils/colors.dart';
import 'package:click_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;

import '../models/registration_error.dart';
import '../utils/paddings.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var maskFormatter = MaskTextInputFormatter(
      mask: '+998(##) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  Future doSingInRequest(var body) async {
    var response;
    try{
    response = await http.post(Uri.parse(API.REGISTRATION),
        headers: {"Content-type": "application/json"}, body: body);
    }catch(error){
      return Future.error(RegistrationError(status: "Failed",message: error.toString()));
    }
    if (response.statusCode == 200) {
      return Future.value(registrationSuccessFromJson(response.body));
    } else {
      return Future.error(registrationErrorFromJson(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBackgroundColor,
      body: SafeArea(
        child: Form(
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBackButton(press: () {
                Navigator.pop(context);
              }),
              const SizedBox(
                height: 24,
              ),
              const CustomHeadLine(
                text: "Hey! Welcome back",
              ),
              const SizedBox(
                height: 8,
              ),
              const CustomSubHeadLine(text: "Sign In to your account"),
              const SizedBox(
                height: 32,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: CustomPadding.kDefaultPadding),
                child: TextFormField(
                  controller: controller,
                  cursorColor: Colors.white,
                  validator: (txt) {
                    if (txt?.length == 18) {
                      return null;
                    } else {
                      return "Enter the phone number";
                    }
                  },
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Colors.white),
                  inputFormatters: [maskFormatter],
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Image.asset(
                        "assets/png/call-calling.png",
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                      onPressed: null,
                    ),
                    disabledBorder: CustomStyles.borderStyle.copyWith(
                        borderSide: BorderSide(color: CustomColors.kGrayColor)),
                    border: CustomStyles.borderStyle,
                    focusedBorder: CustomStyles.borderStyle,
                    hintText: "Phone number",
                    hintStyle: CustomStyles.kGrayStyle.copyWith(fontSize: 14),
                  ),
                ),
              ),
              Spacer(),
              CustomButton(
                  text: "Log into account",
                  press: () {
                    if (key.currentState!.validate()) {
                      Registration registrationModel = Registration(
                          type: "Phone",
                          number: "998" + maskFormatter.getUnmaskedText());

                      showDialog(
                          context: context,
                          builder: (_) {
                            return FutureBuilder(
                                future:
                                    doSingInRequest(registrationModel.toJsonString()),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    WidgetsBinding.instance
                                        ?.addPostFrameCallback((_) {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => OTP(data: snapshot.data.data)));
                                    });
                                  } else if (snapshot.hasError) {
                                    var message =
                                        snapshot.error as RegistrationError;
                                    return CustomError(text: message.message,);
                                  }
                                  return CustomLoading();
                                });
                          });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
