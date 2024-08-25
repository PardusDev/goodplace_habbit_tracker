import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/string_constants.dart';
import '../../init/navigation/navigation_service.dart';
import '../../managers/HabitManager.dart';
import '../../models/ImageModel.dart';
import '../../models/UserHabit.dart';
import '../../services/api_service.dart';
import '../../services/auth_service.dart';
import '../../services/image_service.dart';
import '../../widgets/ConfirmAlertDialog.dart';
import '../../widgets/Snackbars.dart';

class EditHabitPageViewModel with ChangeNotifier, BaseViewModel {
  final _authService = AuthService();
  final _imageService = ImageService();
  final _habitManager = HabitManager();
  final _navigationService = NavigationService.instance;
  final _apiService = ApiService();

  List<ImageModel> _images = [];
  bool _imagesIsLoading = false;
  int _selectedImageIndex = -1;

  String _errorText = '';
  bool _titleValid = false;

  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();

  String get errorText => _errorText;
  bool get titleValid => _titleValid;
  List<ImageModel> get images => _images;
  bool get imagesIsLoading => _imagesIsLoading;
  int get selectedImageIndex => _selectedImageIndex;

  TextEditingController get titleController => _titleController;
  TextEditingController get subjectController => _subjectController;

  bool descLoading=false;

  late final _currentHabit;
  get currentHabit => _currentHabit;

  set selectedImageIndex(int value) {
    _selectedImageIndex = value;
    notifyListeners();
  }

  EditHabitPageViewModel(UserHabit userHabit) {
    _currentHabit = userHabit;
    fillCurrentHabit();
    fetchImages();
  }

  void onTitleChanged(String title) {
    if (title.isNotEmpty) {
      _titleValid = true;
    } else {
      _titleValid = false;
    }
    notifyListeners();
  }

  void setErrorText(String errorText) {
    _errorText = errorText;
    notifyListeners();
  }

  void fillCurrentHabit() {
    _titleController.text = _currentHabit.title;
    onTitleChanged(_titleController.text);

    _subjectController.text = _currentHabit.subject;
  }

  // Fetch images
  Future<void> fetchImages() async {
    try {
      _imagesIsLoading = true;
      notifyListeners();
      _images = (await _imageService.fetchImages())!;
      fetchCurrentImage();
      _imagesIsLoading = false;
      selectCurrentImage();
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!).showSnackBar(
        errorSnackBar(StringConstants.fetchImagesError),
      );
      throw e;
    }
  }

  void fetchCurrentImage() {
    // Check _images list does not contain the current habit image
    if (_images.indexWhere((element) => element.url == _currentHabit.imagePath) == -1) {
      _images.add(
        ImageModel(
          id: _currentHabit.habitId,
          url: _currentHabit.imagePath,
        ),
      );
    }
  }

  void selectCurrentImage() {
    // Select the current habit image
    _selectedImageIndex = _images.indexWhere((element) => element.url == _currentHabit.imagePath);
  }

  // Upload image
  Future<void> uploadImage() async {
    try {
      requestPermissionForImageUpload();
      XFile? selectedImage = await ImagePicker.platform.getImageFromSource(source: ImageSource.gallery);
      if (selectedImage == null) {
        return;
      }
      File imageFile = File(selectedImage.path);
      final uploadedImageModel = await _imageService.uploadImage(imageFile);
      _images.add(uploadedImageModel);
      _selectedImageIndex = _images.length - 1;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!).showSnackBar(
        errorSnackBar(StringConstants.uploadImageError),
      );
      throw e;
    }
  }

  Future<void> saveHabit() async {
    if (!_titleValid) {
      setErrorText(StringConstants.createHabitScreenNameEmptyError);
      return;
    }

    if (_selectedImageIndex == -1) {
      setErrorText(StringConstants.createHabitScreenImageNotSelectedError);
      return;
    }

    try {
      // Get the current user
      final user = _authService.getCurrentUser();

      // Get the text from the text controllers
      UserHabit newHabit = UserHabit(
          habitId: _currentHabit.habitId,
          title: titleController.text,
          subject: subjectController.text,
          imagePath: images[selectedImageIndex].url,
          createdAt: _currentHabit.createdAt,
          doneHabits: _currentHabit.doneHabits,
          maxStreak: _currentHabit.maxStreak,
          currentStreakLastDate: _currentHabit.currentStreakLastDate,
          currentStreak: _currentHabit.currentStreak
      );

      await _habitManager.updateHabit(user!, newHabit);

      notifyListeners();

      // Close the modal
      _navigationService.navigateToBack();
    } catch (e) {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!).showSnackBar(
        errorSnackBar(StringConstants.createHabitError),
      );
      throw e;
    }
  }

  Future<void> requestPermissionForImageUpload() async {
    // Request permission for image upload
    await [
      Permission.storage,
    ].request();
  }

  Future<void> autoFillDescription() async {
    if (!_titleValid) {
      setErrorText(StringConstants.createHabitScreenNameEmptyError);
      return;
    }
    try {
      descLoading = true;
      notifyListeners();
      _subjectController.text = "";
      String response = await _apiService.autoFillDescription(_titleController.text);
      _subjectController.text = response;
    } catch (e) {
      _subjectController.text = "";
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!).showSnackBar(
        errorSnackBar(StringConstants.autoFillError),
      );
    } finally {
      descLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteHabit(BuildContext buildContext) async {
    try {
      User firebaseUser = FirebaseAuth.instance.currentUser!;
      bool confirm = await showDialog(
          context: buildContext,
          builder: (BuildContext context) {
            return const ConfirmAlertDialog(
                title: "Are you sure?",
                body: "Do you want to delete this habit? This action can't be undone."
            );
          }
      ) ?? false;
      if (confirm) {
        await _habitManager.deleteHabit(firebaseUser, currentHabit);
        _navigationService.navigateToPageClear("/home", null);
      }
    } catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    }
  }
}