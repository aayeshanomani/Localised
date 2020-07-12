import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'styles.dart';
import 'wrapper.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'choice.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFFEF9A9A),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.5, 1.0],
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0xFFEF9A9A)
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper() ),),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Color(0xFFEF9A9A),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 600.0,
                      child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/ill1.jpg',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'Order from shops around you',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 26.0,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  'Get delivered from shops nearby. Search for shops of your requirement and connect with them.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 18.0,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/ill2.jpg',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'Fast and Secure Delivery',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 26.0,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  'Get hassle free delivery at your doorstep readily of your products ordered.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 18.0,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(40.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/ill3.jpg',
                                    ),
                                    height: 300.0,
                                    width: 300.0,
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  'Shop in your Comfort Zone',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 26.0,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  'Shop for the best available products near you without the need to step out of your comfort zone.',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'CM Sans Serif',
                                    fontSize: 18.0,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != _numPages - 1
                        ? Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                        : Text(''),
                  ],
                ),
              ),
            ),
          ),
        bottomSheet: _currentPage == _numPages - 1
            ? Container(
          height: 80.0,
          width: double.infinity,
          color: Colors.white,
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper() ),),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Get started',
                  style: TextStyle(
                    color: Colors.deepOrange[800],
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        )
            : Text(''),
    );
  }

  Future<int> getIntFromSP() async
  {
    final pref = await SharedPreferences.getInstance();
    final openNumber = pref.getInt('openNumber');

    if(openNumber == null)
      {
        return 0;
      }
    return openNumber;
  }

  Future<void> incrementOpen() async
  {
    final pref = await SharedPreferences.getInstance();
    int lastOpen = await getIntFromSP();
    int curropen = ++lastOpen;

    await pref.setInt('openNumber', curropen);
    print(curropen);

    if(curropen != 1)
      {
        Navigator.pushReplacement(context, MaterialPageRoute
          (
            builder: (context) => Wrapper()
        ));
      }
  }

  @override
  void initState() {
    incrementOpen();
    super.initState();
  }
}