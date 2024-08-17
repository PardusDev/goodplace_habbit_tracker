import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';

import '../../constants/image_constants.dart';
import '../../constants/string_constants.dart';
import '../../core/base/base_view_model.dart';

class OnBoardingPageViewModel extends ChangeNotifier with BaseViewModel {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final NavigationService _navigationService = NavigationService.instance;

  final List<Widget> _pages = [];

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;
  List<Widget> get pages => _pages;

  OnBoardingPageViewModel() {
    _initializePages();
  }

  void _initializePages() {
    _pages.addAll([
      _buildPage(
        ImageConstants.onboardingPage1,
        StringConstants.onboardingPage1Title,
        StringConstants.onboardingPage1Subtitle
      ),
      _buildPage(
        ImageConstants.onboardingPage2,
        StringConstants.onboardingPage2Title,
        StringConstants.onboardingPage2Subtitle,
      ),
      _buildPage(
        ImageConstants.onboardingPage3,
        StringConstants.onboardingPage3Title,
        StringConstants.onboardingPage3Subtitle,
      ),
      _buildPage(
        ImageConstants.onboardingPage4,
        StringConstants.onboardingPage4Title,
        StringConstants.onboardingPage4Subtitle,
      )
    ]);
  }

  Widget _buildPage(String imagePath, String title, String description) {
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

  void nextPage() async {
    if (_currentPage < _pages.length - 1) {
      _currentPage++;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    } else {
      _navigationService.navigateToPageClear("/home", null);
    }
  }

  void onPageChanged(int page) {
    _currentPage = page;
    notifyListeners();
  }
}