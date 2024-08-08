import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      _buildPage(
        'assets/onboarding/page1.png',
        'Track Your Habit',
        "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
      ),
      _buildPage(
        'assets/onboarding/page2.png',
        'Get Burn',
        "Let's keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
      ),
      _buildPage(
        'assets/onboarding/page3.png',
        'Eat Well',
        "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
      ),
      _buildPage(
        'assets/onboarding/page4.png',
        'Morning Yoga',
        "Let's start a healthy lifestyle with us, we can determine your diet every day, healthy eating is fun",
      ),
    ]);
  }

  static Widget _buildPage(String imagePath, String title, String description) {
  return Builder(
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            width: double.infinity,
            fit: BoxFit.cover, // Ensures the image covers the entire width
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.22,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 35),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 123, 111, 114),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

  void _nextPage() async {
    if (_currentPage < _pages.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding', true);
      Navigator.pushReplacementNamed(context, '/home'); // Assuming you have a route named '/home'
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      floatingActionButton: GestureDetector(
        onTap: _nextPage,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
          ),
          child: Image.asset('assets/onboarding/Button.png'),
        ),
      ),
    );
  }
}
