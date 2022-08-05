import 'package:flutter/material.dart';
import 'package:sittler_app/Pages/Onboarding-Screen/verifyuser.dart';
import 'package:sittler_app/Routes/routes.dart';
import 'package:sittler_app/Widgets/sizebox.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final _controller = PageController();
  bool _islastPage = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: PageView(
          controller: _controller,
          onPageChanged: (index) => setState(() {
            _islastPage = index == 2;
          }),
          children: [
            pageViewContent(
                "images/start2.png",
                " ",
                "The Marketplace to hire Babysitters",
                "Welcome to Sittlers!",
                Colors.white),
                pageViewContent(
                "images/image4.png",
                " ",
                " ",
                "Connect With Top Best Babysitters In Your Area",
                Colors.white),
                pageViewContent(
                "images/image5.png",
                " ",
                "",
                "Find Responsible Babysitters For Your Toddler",
                Colors.white),
          ],
        ),
      ),
      // bottomSheet: _islastPage
      //     ?
      //     TextButton(
      //         style: TextButton.styleFrom(
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(2),
      //             ),
      //             primary: Colors.white,
      //             backgroundColor: Colors.orange,
      //             minimumSize: const Size.fromHeight(80),
      //             textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      //         onPressed: () async {
      //           final prefs = await SharedPreferences.getInstance();
      //           prefs.setBool("showHome", true);
      //           NavigateRoute.gotoPage(context, const MyHomeScreen());
      //           // Navigator.of(context).pushReplacement(
      //           //     MaterialPageRoute(builder: (context) => MyHomeScreen()));
      //         },
      //         child: Text(
      //           "Get Started",
      //         ),
      //       )
      //     :

      bottomSheet: Container(
        padding: const EdgeInsets.all(5),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                style: TextButton.styleFrom(
                  primary: const Color(0xff004aa0),
                ),
                onPressed: () {
                  NavigateRoute.gotoPage(context, const verifyuser());
                },
                child: const Text("Skip")),
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: const SlideEffect(
                    spacing: 8.0,
                    // radius: 4.0,
                    // dotWidth: 24.0,
                    // dotHeight: 16.0,
                    paintStyle: PaintingStyle.stroke,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Color(0xff004aa0)),
                onDotClicked: (index) => _controller.animateToPage(
                  index,
                  duration: const Duration(
                    microseconds: 500,
                  ),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            !_islastPage
                ? TextButton(
                    style: TextButton.styleFrom(
                      primary: const Color(0xff004aa0),
                    ),
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(
                          microseconds: 500,
                        ),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text("Next"))
                : TextButton(
                    style: TextButton.styleFrom(
                      primary: const Color(0xff004aa0),
                    ),
                    onPressed: () {
                      NavigateRoute.gotoPage(context, const verifyuser());
                    },
                    child: const Text("Done"))
          ],
        ),
      ),
    );
  }

  Widget pageViewContent(
      String image, String title, String subtitle, String description, Color colors) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        addVerticalSpace(10),
        Center(
            child: Text(
          title,
          style: const TextStyle(fontSize: 22),
        )),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: description,
              style: const TextStyle(fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold),
              children: const <TextSpan>[
                // TextSpan(
                //   text: "For NY Apartments",
                //   style: TextStyle(
                //     letterSpacing: 2,
                //     fontSize: 25.0,
                //     color: Colors.blue,
                //   ),
                // ),
              ]),
        ),

        Container(
            alignment: Alignment.center,
            child: Text(
              subtitle,
              style: const TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            )),

        //addVerticalSpace(20),
        Container(
          color: colors,
          height: 400,
          width: double.infinity,
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
        addVerticalSpace(10),
      ],
    );
  }
}
