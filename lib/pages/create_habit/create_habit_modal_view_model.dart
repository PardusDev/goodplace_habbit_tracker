import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/managers/HabitManager.dart';
import 'package:goodplace_habbit_tracker/services/api_service.dart';
import 'package:goodplace_habbit_tracker/services/image_service.dart';
import 'package:goodplace_habbit_tracker/services/notification_service.dart';
import 'package:goodplace_habbit_tracker/widgets/Snackbars.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants/string_constants.dart';
import '../../init/navigation/navigation_service.dart';
import '../../models/ImageModel.dart';
import '../../models/UserHabit.dart';
import '../../services/auth_service.dart';

class CreateHabitModalViewModel extends ChangeNotifier with BaseViewModel {
  final _authService = AuthService();
  final _imageService = ImageService();
  final _habitManager = HabitManager();
  final _navigationService = NavigationService.instance;
  final _apiService = ApiService();
  final _notificationService = NotificationService();

  List<ImageModel> _images = [];
  bool _imagesIsLoading = false;
  int _selectedImageIndex = -1;

  String _errorText = '';
  bool _titleValid = false;
  bool _remindMeCheckbox = false;
  TimeOfDay? _selectedTime = TimeOfDay.now();

  final ScrollController _scrollController = ScrollController();
  final _titleController = TextEditingController();
  final _subjectController = TextEditingController();

  String get errorText => _errorText;
  bool get titleValid => _titleValid;
  bool get remindMeCheckbox => _remindMeCheckbox;
  TimeOfDay? get selectedTime => _selectedTime;
  List<ImageModel> get images => _images;
  bool get imagesIsLoading => _imagesIsLoading;
  int get selectedImageIndex => _selectedImageIndex;

  ScrollController get scrollController => _scrollController;
  TextEditingController get titleController => _titleController;
  TextEditingController get subjectController => _subjectController;

  bool descLoading = false;

  set selectedImageIndex(int value) {
    _selectedImageIndex = value;
    notifyListeners();
  }

  CreateHabitModalViewModel() {
    fetchImages();
  }

  // region Remind Me
  void toggleRemindMeCheckbox(bool value) {
    requestAlarmPermission();
    _remindMeCheckbox = value;
    notifyListeners();
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (time != null && time != selectedTime) {
      _selectedTime = time;
      notifyListeners();
    }
  }
  // endregion

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
    scrollToBottom();
    notifyListeners();
  }

  // Fetch images
  Future<void> fetchImages() async {
    try {
      _imagesIsLoading = true;
      notifyListeners();
      _images = (await _imageService.fetchImages())!;
      _imagesIsLoading = false;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!)
          .showSnackBar(
        errorSnackBar(StringConstants.fetchImagesError),
      );
      throw e;
    }
  }

  // Upload image
  Future<void> uploadImage() async {
    try {
      requestPermissionForImageUpload();
      XFile? selectedImage = await ImagePicker.platform
          .getImageFromSource(source: ImageSource.gallery);
      if (selectedImage == null) {
        return;
      }
      File imageFile = File(selectedImage.path);
      final uploadedImageModel = await _imageService.uploadImage(imageFile);
      _images.add(uploadedImageModel);
      _selectedImageIndex = _images.length - 1;
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!)
          .showSnackBar(
        errorSnackBar(StringConstants.uploadImageError),
      );
      throw e;
    }
  }

  Future<void> createHabit() async {
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
          habitId: '',
          title: titleController.text,
          subject: subjectController.text,
          imagePath: images[selectedImageIndex].url,
          createdAt: DateTime.now(),
          doneHabits: [],
          maxStreak: 0,
          currentStreakLastDate: null,
          currentStreak: 0,
          reminderTime: remindMeCheckbox ? selectedTime : null);

      // Set remind me notification
      if (remindMeCheckbox) {
         await _notificationService.scheduleDailyNotification(newHabit);
      }

      await _habitManager.addHabit(user!, newHabit);

      notifyListeners();

      // Close the modal
      _navigationService.navigateToBack();
    } catch (e) {
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!)
          .showSnackBar(
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
      String response =
          await _apiService.autoFillDescription(_titleController.text);
      _subjectController.text = response;
    } catch (e) {
      _subjectController.text = "";
      ScaffoldMessenger.of(_navigationService.navigatorKey.currentContext!)
          .showSnackBar(
        errorSnackBar(StringConstants.autoFillError),
      );
    } finally {
      descLoading = false;
      notifyListeners();
    }
  }

  Future<void> requestAlarmPermission() async {
    // Request permission for alarm
    if (await Permission.scheduleExactAlarm.isGranted) return;
    await [
       Permission.scheduleExactAlarm,
    ].request();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
