
import 'package:shared_preferences/shared_preferences.dart';


class Savelocally {

writeData(List<String>searchHistory,String listname) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setStringList(listname, searchHistory);
}
readData(String listname)async{
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.getStringList(listname) ?? [];
   return prefs.getStringList(listname) ?? [];
  // return searchHist;
}



}