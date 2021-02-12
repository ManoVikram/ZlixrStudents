import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class AnimatedDropdown extends StatefulWidget {
  final List<dynamic> dataList;
  final bool isOpen;

  AnimatedDropdown({
    @required this.dataList,
    @required this.isOpen,
  });

  @override
  _AnimatedDropdownState createState() => _AnimatedDropdownState();
}

class _AnimatedDropdownState extends State<AnimatedDropdown>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Size> _heightAnimation;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _heightAnimation = Tween(
      begin: Size(double.infinity, 0),
      end: Size(double.infinity, 350),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.isOpen
          ? const EdgeInsets.all(8.0)
          : const EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
      child: Scrollbar(
        child: Neumorphic(
          style: NeumorphicStyle(
            shadowLightColorEmboss: Colors.white,
            shadowDarkColorEmboss: Colors.blueGrey[100],
            color: Colors.grey[100],
            depth: 10,
          ),
          child: AnimatedContainer(
            duration: Duration(
              milliseconds: 500,
            ),
            constraints: BoxConstraints(
              minHeight: widget.isOpen ? 50 : 0,
              maxHeight: widget.isOpen ? 200 : 0,
            ),
            curve: Curves.easeIn,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (contxt, index) => Column(
                children: [
                  NeumorphicButton(
                    onPressed: () {},
                    pressed: true,
                    minDistance: -10,
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      surfaceIntensity: 1.0,
                      depth: 0,
                      // boxShape: NeumorphicBoxShape.beveled(
                      //   BorderRadius.circular(20),
                      // ),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.arrow_right,
                        color: Colors.cyanAccent,
                      ),
                      title: Text(
                        widget.dataList[index].toString(),
                        style: TextStyle(
                          fontFamily: GoogleFonts.oxygen().fontFamily,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
              itemCount: widget.dataList.length,
            ),
          ),
        ),
      ),
    );
  }
}

// With Fade and Slide transition

/* Padding(
                  padding: _isMenuOpen1
                      ? const EdgeInsets.all(8.0)
                      : const EdgeInsets.all(0.0),
                  child: Neumorphic(
                    style: NeumorphicStyle(
                      shadowLightColorEmboss: Colors.white,
                      shadowDarkColorEmboss: Colors.blueGrey[100],
                      color: Colors.grey[100],
                      depth: 10,
                    ),
                    child: AnimatedContainer(
                      duration: Duration(
                        milliseconds: 500,
                      ),
                      constraints: BoxConstraints(
                        minHeight: _isMenuOpen1 ? 50 : 0,
                        maxHeight: _isMenuOpen1 ? 200 : 0,
                      ),
                      curve: Curves.easeIn,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (contxt, index) => Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.arrow_right,
                                    color: Colors.redAccent,
                                  ),
                                  title: Text(
                                    _department[index],
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.oxygen().fontFamily,
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                            itemCount: _department.length,
                          ),
                        ),
                      ),
                    ),
                  ),
                ), */
