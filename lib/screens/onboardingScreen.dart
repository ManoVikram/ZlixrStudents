import 'package:flutter/material.dart';

import './loginScreen.dart';
import '../widgets/onboardContent.dart';

class OnboardingScreen extends StatefulWidget {
  static const String routeName = "/onboarding";

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _screenNumber = 0;
  List<Map<String, String>> _data = [
    // TODO: Change title and description
    {
      "title": "WELCOME",
      "description": "We welcome all the amazing coders onboard",
      "element1": "assets/images/PeachIllustrations/Scene Elements/plant-3.png",
      "element2": "assets/images/PeachIllustrations/Scene Elements/tree-1.png",
      "image": "assets/images/proud_coder.png",
    },
    {
      "title": "EARN",
      "description": "Earn points according to your tasks completed",
      "element1":
          "assets/images/PeachIllustrations/UI Elements/speech-modal-2.png",
      "element2":
          "assets/images/PeachIllustrations/UI Elements/like-button.png",
      "image": "assets/images/online_payments.png",
    },
    {
      "title": "ANALYZE DATA",
      "description": "Analyze all your earned scores, points and more",
      "element1":
          "assets/images/PeachIllustrations/UI Elements/comment-card.png",
      "element2":
          "assets/images/PeachIllustrations/UI Elements/profile-card.png",
      "image": "assets/images/Data_trends.png",
    },
  ];

  List<Color> _colors = [
    Color(0xFFFFAF4E),
    Color(0xFFFFBE98),
    Color(0xFF1FB08F),
  ];

  AnimatedContainer buildDots(int index) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 7,
      width: _screenNumber == index ? 20 : 7,
      decoration: BoxDecoration(
        color: _screenNumber == index ? Colors.indigoAccent : Colors.blueGrey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: _colors[Random().nextInt(_colors.length)],
      backgroundColor: _colors[_screenNumber],
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      _screenNumber = value;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contxt, index) => OnboardContent(
                    text: _data[index]["title"],
                    description: _data[index]["description"],
                    element1: _data[index]["element1"],
                    element2: _data[index]["element2"],
                    image: _data[index]["image"],
                  ),
                  itemCount: _data.length,
                ),
              ),
              Expanded(
                flex: 1,
                child: LayoutBuilder(
                  builder: (contxt, constraints) {
                    if (constraints.maxWidth > 600) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                _data.length,
                                (index) => buildDots(index),
                              ),
                            ],
                          ),
                          Flexible(
                            child: FractionallySizedBox(
                              widthFactor: 0.16,
                            ),
                          ),
                          if (_screenNumber != 2)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    LoginScreen.routeName);
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size(
                                  size.width > 600
                                      ? size.width * 0.4
                                      : size.width * 0.9,
                                  size.height * 0.075,
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          /* FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.navigate_next,
                      ),
                      label: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ), */
                          if (_screenNumber == 2)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    LoginScreen.routeName);
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size(
                                  size.width > 600
                                      ? size.width * 0.4
                                      : size.width * 0.9,
                                  size.height * 0.075,
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ...List.generate(
                                _data.length,
                                (index) => buildDots(index),
                              ),
                            ],
                          ),
                          Flexible(
                            child: FractionallySizedBox(
                              heightFactor: 0.16,
                            ),
                          ),
                          if (_screenNumber != 2)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    LoginScreen.routeName);
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size(
                                  size.width > 600
                                      ? size.width * 0.4
                                      : size.width * 0.9,
                                  size.height * 0.075,
                                ),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          /* FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.navigate_next,
                      ),
                      label: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ), */
                          if (_screenNumber == 2)
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacementNamed(
                                    LoginScreen.routeName);
                              },
                              style: TextButton.styleFrom(
                                minimumSize: Size(
                                  size.width > 600
                                      ? size.width * 0.4
                                      : size.width * 0.9,
                                  size.height * 0.075,
                                ),
                                backgroundColor: Colors.tealAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                textStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Get Started",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.navigate_next,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
