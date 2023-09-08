import 'package:assignment/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:assignment/misc/colors.dart';
import 'package:assignment/model/data_model.dart';
import 'package:assignment/widgets/app_large_taxt.dart';
import 'package:assignment/widgets/app_text.dart';

import '../services/data_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<DataModel> data=[];
  var images = {
    'balloning.png' : "Balloning",
    'hiking.png' : "Hiking",
    'kayaking.png' : "Kayaking",
    'snorkling.png' : "Snorkling",
  };

  Future<void> getData() async {
    final temp= await DataServices.getInfo();
    setState(() {
      data=temp!;
    });
  }
  @override
  void initState() {
    getData();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    Size size=MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: data.isEmpty? Container(
            height: size.height,
            child: Center(
              child: CircularProgressIndicator(),),
          ):
          Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menu text
            Container(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.black54,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    width: size.width*0.1,
                    height: size.width*0.1,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.5)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height*0.01,
            ),
            // Discover text
            Container(
                margin: EdgeInsets.only(left: 20),
                child: AppLargeText(text: 'Discover')),
            SizedBox(
              height: size.height*0.01,
            ),
            // Tab bar
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                controller: tabController,
                isScrollable: true,
                indicator:
                CircleTabIndicator(radius: 4, color: AppColors.mainColor),
                tabs: [
                  Tab(text: "All"),
                  Tab(
                    text: "Inspiration",
                  ),
                  Tab(
                    text: "Emotion",
                  ),
                ],
              ),
            ),
            ListTab(tabController: tabController, info: data!),
            SizedBox(
              height: size.height*0.03,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: AppLargeText(text: "Explore More", size: 22)

            ),

            Container(
                width: double.maxFinite,
                height: size.height*0.2,
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: size.width*0.2,
                              height: size.height*0.12,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage('assets/${images.keys.elementAt(index)}'),
                                      fit: BoxFit.cover)),
                            ),
                            Container(
                              child: AppText(text:images.values.elementAt(index),color: AppColors.textColor2),
                            )
                          ],
                        ),
                      );
                    })),
          ],
        ),

          ),
        );
  }
}

class ListTab extends StatelessWidget {
  const ListTab({
    super.key,
    required this.tabController,
    required this.info,
  });

  final TabController tabController;
  final List<DataModel> info;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: size.height*0.4,
      width: double.maxFinite,
      child: TabBarView(
        controller: tabController,
        children: [
          ListMountain(info: info),
          ListMountain(info: info),
          ListMountain(info: info),
        ],
      ),
    );
  }
}

class ListMountain extends StatelessWidget {
  const ListMountain({
    super.key,
    required this.info,
  });

  final List<DataModel> info;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: info.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
             Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailsPage(detail: info[index],)));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 15, top: 10),
              width: size.width*0.5,
              height: size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage("http://mark.bslmeiyu.com/uploads/${info[index].img}"),
                      fit: BoxFit.cover)),
            ),
          );
        });
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;
  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  final double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint paint = Paint();
    paint.color = color;
    paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);

    canvas.drawCircle(circleOffset + offset, radius, paint);
  }
}