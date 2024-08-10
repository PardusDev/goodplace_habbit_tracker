abstract class INavigationService {
  void navigateToBack();
  Future<void> navigateToPage(String path, Object object);
  Future<void> navigateToPageClear(String path, Object object);
}