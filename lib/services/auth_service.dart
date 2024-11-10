import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Function to save user login status
  Future<void> saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userId);
  }

  // Function to check user login status
  Future<int> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }
}
