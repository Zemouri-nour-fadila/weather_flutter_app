import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<void> saveData(String cityName, int isPined) async {
    final SharedPreferences sharedPrefenreces =
        await SharedPreferences.getInstance();
    await sharedPrefenreces.setString('cityName', cityName);
    await sharedPrefenreces.setInt('isPined', isPined);
  }

  Future<String?> getCityName() async {
    final sharedPrefenreces = await SharedPreferences.getInstance();
    return sharedPrefenreces.getString('cityName');
  }

  Future<int?> getIsPined() async {
    final sharedPrefenreces = await SharedPreferences.getInstance();
    return sharedPrefenreces.getInt('isPined');
  }
}
