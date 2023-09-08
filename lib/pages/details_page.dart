import 'package:assignment/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:assignment/misc/colors.dart';
import 'package:assignment/pages/nav_pages/main_page.dart';
import 'package:assignment/widgets/app_buttons.dart';
import 'package:assignment/widgets/app_text.dart';
import 'package:assignment/widgets/responsive_button.dart';
import '../widgets/app_large_taxt.dart';

class DetailsPage extends StatefulWidget {
  DataModel detail;

  DetailsPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int gottenStars = 3 ;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: Stack(
            children: [

              Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 350,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage('http://mark.bslmeiyu.com/uploads/'+widget.detail.img),
                            fit: BoxFit.cover)),
                  )),
              Positioned(
                  left: 20,
                  top: 50,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ],
                  )),
              Positioned(
                top: 200,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  padding: EdgeInsets.only(left: 20,right: 20,top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppLargeText(text: widget.detail.name,color: Colors.black54.withOpacity(0.8)),
                          AppLargeText(text: "\$ "+widget.detail.price.toString(),color: AppColors.mainColor,),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: AppColors.mainColor,),
                          SizedBox(width: 10,),
                          AppText(text: widget.detail.location,color: AppColors.mainTextColor,)
                        ],
                      ),
                      SizedBox(height:15,),
                      Row(
                        children: [
                          Wrap(
                              children: List.generate(5, (index) {
                                return Icon(Icons.star,color:widget.detail.stars > index ? AppColors.starColor:AppColors.textColor2,);
                              })
                          ),
                          SizedBox(width: 10,),
                          AppText(text: "(5.0)",color:AppColors.textColor2)
                        ],
                      ),
                      SizedBox(height:15,),
                      AppLargeText(text: 'People',color: Colors.black54.withOpacity(0.8),size: 20,),
                      SizedBox(height: 5,),
                      AppText(text: 'Number Of People in your group'),
                      SizedBox(height: 10,),
                      Wrap(
                        children: List.generate(5, (index){
                          return InkWell(onTap: (){
                            setState(() {
                              selectedIndex = index;
                            });
                          },child: AppButtons(index+1,selectedIndex==index?Colors.white:Colors.black,selectedIndex==index?Colors.black:AppColors.buttonBackground,50,AppColors.buttonBackground,null));
                        }),

                      ),
                      SizedBox(height: 10,),
                      AppLargeText(text: 'Description',size: 20,),
                      SizedBox(height: 5,),
                      AppText(text:widget.detail.desc),
                      SizedBox(height: 20,),



                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 40,
                  left: 20,
                  right: 20,
                  child: Row(
                    children: [
                      AppButtons(0, AppColors.textColor2, Colors.white, 60, AppColors.textColor2, Icons.favorite_border),
                      Flexible(child: ResponsiveButton(isResponsive: true,)),
                    ],
                  ))
            ],
          ),
        )

    );
  }
}
