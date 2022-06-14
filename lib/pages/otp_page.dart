import 'dart:convert';

import 'package:click_app/customs/custom_button.dart';
import 'package:click_app/customs/loading.dart';
import 'package:click_app/models/otp_error.dart';
import 'package:click_app/models/otp_model.dart';
import 'package:click_app/models/otp_success.dart';
import 'package:click_app/pages/home_page.dart';
import 'package:click_app/utils/colors.dart';
import 'package:click_app/utils/db.dart';
import 'package:click_app/utils/numbers.dart';
import 'package:click_app/utils/paddings.dart';
import 'package:click_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;
import '../customs/back_button.dart';
import '../customs/custom_error_dialog.dart';
import '../customs/custom_headline.dart';
import '../customs/custom_sub_headline.dart';
import '../utils/apis.dart';

class OTP extends StatefulWidget {
  final data;

  const OTP({Key? key, required this.data}) : super(key: key);
  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController otpController = TextEditingController();
  Future doSignIn(String body) async {
    var response;
    try {
      response = await http.post(Uri.parse(API.SIGN_IN),
          headers: {"Content-type": "application/json"}, body: body);
    }catch(error){
      return Future.error(OtpError(status: "Failed", message: error.toString()));
    }
    if (response.statusCode == 200) {
      var responseData = otpSuccessFromJson(response.body);
      //save access and refresh tokens
      Database()
          .addToDb("accessToken", responseData.data.accessToken.toString());
      Database()
          .addToDb("refreshToken", responseData.data.refreshToken.toString());
      return Future.value(responseData);
    } else {
      print("error otp ${otpErrorFromJson(response.body)}");
      return Future.error(otpErrorFromJson(response.body));
    }
  }
  void callFunction(){
    OTPModel otpModel = OTPModel(
        requestId: widget.data.requestId,
        password: otpController.text);
    showDialog(
        context: context,
        builder: (_) {
          return FutureBuilder(
              future: doSignIn(otpModel.toJsonString()),
              builder:
                  (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  WidgetsBinding.instance
                      ?.addPostFrameCallback((_) {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => HomePage()));
                  });
                } else if (snapshot.hasError) {
                  print(snapshot.error.runtimeType);
                  var message = snapshot.error as OtpError;
                  print(message.message);
                  return CustomError(
                    text: message.message,
                  );
                }
                return CustomLoading();
              });
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomBackButton(press: () {
              Navigator.pop(context);
            }),
            const SizedBox(
              height: 24,
            ),
            const CustomHeadLine(
              text: "Verification Code",
            ),
            const SizedBox(
              height: 8,
            ),
            const CustomSubHeadLine(
                text:
                    "Enter the verification code that we have sent to your email"),
            const SizedBox(
              height: 24,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 51),
                child: PinCodeTextField(
                  appContext: context,
                  controller: otpController,
                  length: 4,
                  onChanged: (txt) {},
                  onCompleted: (txt){
                    callFunction();
                  },
                  obscureText: false,
                  animationType: AnimationType.fade,
                  keyboardType: TextInputType.number,
                  textStyle: CustomStyles.kHeadingStyle
                      .copyWith(fontSize: 24, fontWeight: FontWeight.w600),
                  autoFocus: true,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: CustomNumbers.pinHeight,
                      fieldWidth: CustomNumbers.pinHeight,
                      activeFillColor: CustomColors.kBtnBackgroundColor,
                      activeColor: CustomColors.kBtnBackgroundColor,
                      inactiveFillColor: CustomColors.kBtnBackgroundColor,
                      selectedFillColor: CustomColors.kBtnBackgroundColor,
                      inactiveColor: CustomColors.kBtnBackgroundColor,
                      selectedColor: CustomColors.kBtnActiveColor),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: CustomColors.kBackgroundColor,
                  enableActiveFill: true,
                )),
            const SizedBox(
              height: 43,
            ),
            Center(
              // margin: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn’t receive the code?",
                      style: CustomStyles.kHeadingStyle
                          .copyWith(fontSize: 14, fontWeight: FontWeight.w400)),
                  TextButton(
                    onPressed: () {

                    },
                    child: Text(
                      "Send again!",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              press: () {
                callFunction();
              },
              text: "Continue",
            ),
          ],
        ),
      ),
    );
  }
}
