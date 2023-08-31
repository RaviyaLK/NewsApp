import 'package:flutter/material.dart';
import 'package:news_app_assignment/screens/webview.dart';
import '../Constants/string_const.dart';
import '../widgets/colors.dart';


class InfoPage extends StatelessWidget {
   const InfoPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.content,
    required this.webURL,
    required this.author,
  });

  final String image;
  final String content;
  final String description;
  final String title;
  final String date;
  final String author;
  final String webURL;
  
String shorten(){
   if(author.length >40) {
   return author.substring(0,40);
     }else {
    return author;
     }   

}

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: appBackground,//Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey,
        backgroundColor: appbarBackground,//Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      //changes position of shadow
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {//if image not found
                      return const Icon(Icons.image_not_supported_outlined,size: 250,);
                    },
                    image,
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left:15,right: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(   
                            
                    shorten(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    date,
                    style:  Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Text(
                    title,
                    style:  Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    content,
                    maxLines: 9,
                    style:Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(createRoute(webURL));
             
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) {       //changing the color of button when pressed
                          if (states.contains(MaterialState.pressed)) {
                            return Colors.blue;
                          }
                          return buttonColor;
                        }),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(//changing the shape of button
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      child: const Text(
                       buttonName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

 

Route createRoute(
 
  String webURL,
) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => WebViewScreen(
      
      
      webURL: webURL,
     
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) { //creates a transition animation
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.elasticInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
}