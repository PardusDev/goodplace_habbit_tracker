class VersionManager {
  final String appValue;
  final String databaseValue;

  VersionManager({required this.appValue, required this.databaseValue});

  bool isNeedUpdate() {
    // 1.0.0 => 100
    final deviceNumberSplitted = appValue.split(".").join();
    final databaseNumberSplitted = databaseValue.split(".").join();

    final deviceNumber = int.tryParse(deviceNumberSplitted);
    final databaseNumber = int.tryParse(databaseNumberSplitted);

    if (deviceNumber == null || databaseNumber == null) {
      throw ('$deviceNumberSplitted or $databaseNumberSplitted is not valid or parse');
    }

    return deviceNumber < databaseNumber;
  }
}