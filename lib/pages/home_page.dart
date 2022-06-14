import 'package:click_app/customs/custom_card.dart';
import 'package:click_app/customs/custom_error_dialog.dart';
import 'package:click_app/customs/custom_headline.dart';
import 'package:click_app/customs/loading.dart';
import 'package:click_app/models/partners_error.dart';
import 'package:click_app/models/partners_succes.dart';
import 'package:click_app/utils/colors.dart';
import 'package:click_app/utils/db.dart';
import 'package:click_app/utils/numbers.dart';
import 'package:click_app/utils/paddings.dart';
import 'package:click_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/apis.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<String> headline = [
  //   "New Freshman Party",
  //   "New Freshman Party",
  //   "New Freshman Party",
  //   "New Freshman Party"
  // ];
  // List<String> subline = [
  //   "Morbi tincidunt pulvinar fames aliquam etiam quis volutpat id purus. Dui nec eu tortor interdum ultricies viverra feugiat tristique.",
  //   "Morbi tincidunt pulvinar fames aliquam etiam quis volutpat id purus. Dui nec eu tortor interdum ultricies viverra feugiat tristique.",
  //   "Morbi tincidunt pulvinar fames aliquam etiam quis volutpat id purus. Dui nec eu tortor interdum ultricies viverra feugiat tristique.",
  //   "Morbi tincidunt pulvinar fames aliquam etiam quis volutpat id purus. Dui nec eu tortor interdum ultricies viverra feugiat tristique.",
  // ];
  // List<String> images = [
  //   "assets/png/img1.png",
  //   "assets/png/img2.png",
  //   "assets/png/img3.png",
  //   "assets/png/img4.png",
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getData() async {
    var accessToken = await Database().readFromDb("accessToken");
    print("accessToken $accessToken");
    var response;
    try {
      print('get request');
      response = await http.get(
          Uri.parse(API.PARTNERS),
          headers: {"Content-type":"application/json", "Authorization": "Bearer $accessToken"});
      print(response.body);
    } catch (error) {
      print("error $error");
      return Future.error(
          PartnersError(status: "Failed", message: error.toString()));
    }
    print(response.body);
    if (response.statusCode == 200) {
      return Future.value(partnersSuccessFromJson(response.body));
    } else {
      return Future.error(partnersErrorFromJson(response.body));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.kBackgroundColor,
        body: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CustomHeadLine(text: "Hey! Welcome back"),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: CustomPadding.kBackBtnPadding),

                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              var newData = snapshot.data.data.data;
                              return CustomCard(image: newData[index].logo, title: newData[index].title, subTitle: newData[index].desc);
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 16,
                              );
                            },
                            itemCount: snapshot.data.data.data.length),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error.runtimeType);
              var error = snapshot.error as PartnersError;
              return CustomError(text: error.message);
            }
            return CustomLoading();
          },
        ));
  }
}
