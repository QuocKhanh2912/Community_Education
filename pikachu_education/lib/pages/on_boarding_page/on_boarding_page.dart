import 'package:flutter/material.dart';
import 'package:pikachu_education/routes/page_name.dart';
import 'package:pikachu_education/service/initialization/initialization_service.dart';
import 'package:pikachu_education/utils/management_color.dart';
import 'package:pikachu_education/utils/management_image.dart';
import 'component/dot_widget.dart';

class OnBoardingPage1 extends StatefulWidget {
  const OnBoardingPage1({super.key});

  @override
  State<OnBoardingPage1> createState() => _OnBoardingPage1State();
}

class _OnBoardingPage1State extends State<OnBoardingPage1> {
  PageController pageViewController = PageController();
  int pageViewIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagementColor.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(ManagementImage.logo),
                Expanded(
                    child: PageView(
                  controller: pageViewController,
                  onPageChanged: (value) {
                    setState(() {
                      pageViewIndex = value;
                    });
                  },
                  children: const [
                    Center(
                      child: Text(
                        'On Boarding 1',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(
                      child: Text(
                        'On Boarding 2',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Center(
                      child: Text(
                        'On Boarding 3',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                )),
                Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              InitializationService.saveOnBoardingAlready();
                              Navigator.pushNamed(context, PageName.loginPage);
                            },
                            child: const Text('Skip')),
                        DotBuild(pageViewIndex: pageViewIndex),
                        InkWell(
                            onTap: () {
                              if (pageViewIndex == 0) {
                                pageViewController.animateToPage(
                                    pageViewIndex + 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              }
                              if (pageViewIndex == 1) {
                                pageViewController.animateToPage(
                                    pageViewIndex + 1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              }
                              if (pageViewIndex == 2) {
                                InitializationService.saveOnBoardingAlready();
                                Navigator.pushNamed(
                                    context, PageName.loginPage);
                              }
                            },
                            child: const Text('Next'))
                      ],
                    ))
              ]),
        ),
      ),
    );
  }
}
