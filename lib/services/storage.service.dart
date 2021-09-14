import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  static final StorageService _instance = new StorageService._();

  factory StorageService() => _instance;

  StorageService._();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }


  set token(String val) => _prefs.setString('token', val);

  String get token => _prefs.getString('token') ?? '';

  Future<bool> onClearStorage() async {
    return await _prefs.remove('token');
  }
  
  Future<String> onLoadToken() async{
    return  _prefs.getString('token') ?? '';
  }

}