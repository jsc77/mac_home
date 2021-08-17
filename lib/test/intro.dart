import 'package:flutter/material.dart';
import 'package:hq/test/helper.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  var controller;
  int count = 0;

  final List<Map<String, String>> pages = [
    {
      "image": "desertback.jpg",
      "title": "夜を守るガディアン",
      "desc":
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry"
    },
    {
      "image": "pokeback.jpg",
      "title": "報告システム",
      "desc":
          "Contrary to popular belief, Lorem Ipsum is not simply random text. "
    },
  ];

  @override
  void initState() {
    controller = new PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              Container(
                height: 400,
                width: double.infinity,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      count = value;
                    });
                  },
                  controller: controller,
                  itemBuilder: (context, index) {
                    return Image.asset(
                        Helper.getAssetName(pages[index]["image"]));
                  },
                  itemCount: pages.length,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: count == 0 ? Colors.orange : Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 5,
                    backgroundColor: count == 1 ? Colors.orange : Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(pages[count]["title"]),
              SizedBox(
                height: 20,
              ),
              Text(
                pages[count]["desc"],
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("次へ"),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
