import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:task_1/api_services/servicess.dart';
import 'package:task_1/model/doctor_detail_mdel.dart';
import 'package:task_1/view/textpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> list1 = [
    {
      "image": "assets/image/Vector (1).png",
      "text": "Dental",
      "color": Color(0xff2753F3)
    },
    {
      "image": "assets/image/Vector.png",
      "text": "Cardiologist",
      "color": Color(0xff0EBE7E)
    },
    {
      "image": "assets/image/Group (1).png",
      "text": "Eye Specialist",
      "color": Color(0xffFE7F44)
    },
    {
      "image": "assets/image/Group.png",
      "text": "Skin Specialist",
      "color": Color(0xffFF484C)
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: Get.height * 0.2,
                  width: Get.width,
                  margin: EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(10),
                    ),
                  ),
                  child: Center(
                    child: Texts(
                      size: 25,
                      text: "Find Your Doctor",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: Get.height * 0.070,
                    width: Get.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                        hintText: "Search",
                        suffixIcon: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  list1.length,
                  (index) => Column(
                    children: [
                      Container(
                        height: Get.height * 0.090,
                        width: Get.width * 0.22,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            color: list1[index]["color"],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Image(
                          image: AssetImage(list1[index]["image"]),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.005,
                      ),
                      Texts(
                        size: 12,
                        text: list1[index]["text"],
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Texts(
                size: 20,
                text: "Popular Doctor",
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Get.height * 0.015,
            ),
            FutureBuilder(
              future: ApiBaseService.getData(),
              builder: (context, AsyncSnapshot<Detail> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: snapshot.data!.users!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        final info = snapshot.data!.users![index];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          shadowColor: Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Container(
                                  height: Get.height * 0.22,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("${info.avatar}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.005,
                                ),
                                Texts(
                                  size: 18,
                                  fontWeight: FontWeight.bold,
                                  text: "${info.firstName}",
                                ),
                                Texts(
                                  size: 16,
                                  // fontWeight: FontWeight.bold,
                                  text: "${info.lastName}",
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
