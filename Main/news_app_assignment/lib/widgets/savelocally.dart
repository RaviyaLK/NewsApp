
import 'package:shared_preferences/shared_preferences.dart';


class Savelocally {

writeData(List<String>searchHistory,String listname) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setStringList(listname, searchHistory);
}
 Future<List<String>> readData(String listname) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   
    return prefs.getStringList(listname) ?? []; // Return an empty list if the data is null
    
  }
  // return searchHist;




}