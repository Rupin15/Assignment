import 'package:assignment/pages/home_page.dart';
import 'package:assignment/pages/nav_pages/main_page.dart';
import 'package:assignment/services/data_services.dart';
import 'package:flutter/material.dart';
import 'package:assignment/misc/colors.dart';
import 'package:assignment/widgets/app_large_taxt.dart';
import 'package:assignment/widgets/app_text.dart';
import 'package:assignment/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    'assets/welcome-one.png',
    "assets/welcome-two.png",
    'assets/welcome-three.png'
  ];

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_,index){

            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(images[index])
                )
              ),
              child: Container(
                margin: EdgeInsets.only(top: 150,left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: "Trips"),
                        AppText(text: "Mountain" , size: 30),
                        SizedBox(height: 20,),
                        Container(
                          width: size.height*0.5,
                          child: AppText(
                            text: "Mountain hikes give you an incredible sense of freedom along with endurance test",
                            color: AppColors.textColor2,
                            size: 14,
                          ),
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                          },child: ResponsiveButton(width: 100,)),
                      ],
                    ),
                    Column(
                      children: List.generate(3, (indexDots) => Container(
                        margin: EdgeInsets.only(bottom: 2),
                        width: 8,
                        height:index==indexDots?25:8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3)
                        ),
                      )),
                    )
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
