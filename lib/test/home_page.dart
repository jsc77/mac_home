import 'package:flutter/material.dart';
import 'package:hq/pages/home_screen.dart';
import 'package:hq/pages/report.dart';
import 'package:hq/test/bottom.dart';
import 'package:hq/test/helper.dart';
import 'package:hq/test/saved_tab.dart';
import 'package:hq/list/upload_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _tabsPageController;
  int _selectedTab = 0;
  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _tabsPageController,
            onPageChanged: (num) {
              setState(() {
                _selectedTab = num;
                print("Selected Tab: ${_selectedTab}");
              });
            },
            children: [
              HomeScreen(),
              UploadTab(),
              Report(),
              SavedTab(),
            ],
          ),
          Positioned(
            bottom: 30,
            child: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                backgroundColor: Colors.orange[800],
                elevation: 0,
                onPressed: () {},
                child: Image.asset(
                  Helper.getAssetName("home.png"),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: BottomTabs(
              selectedTab: _selectedTab,
              tabPressed: (num) {
                _tabsPageController.animateToPage(num,
                    duration: Duration(milliseconds: 30),
                    curve: Curves.easeOutCubic);
              },
            ),
          ),
        ],
      ),
    );
  }
}
