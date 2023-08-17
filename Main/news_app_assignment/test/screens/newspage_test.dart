import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news_app_assignment/screens/infopage.dart';
import 'package:news_app_assignment/screens/newspage.dart';



void main() {
 

  group('Debouncer tests', () {
    test('Debouncer should execute action after delay', () async {
      final debouncer = Debouncer(milliseconds: 100);
      var executed = false;

      debouncer.run(() {
        executed = true;
      });

      await Future.delayed(const Duration(milliseconds: 150));

      expect(executed, true);
    });
  });

  group('PageRouteBuilder tests', () {
    Route _createRoute(
  String image,
  String content,
  String description,
  String title,
  String date,
  String author,
  String webURL,
) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => InfoPage(
      title: title,
      content: content,
      description: description,
      author: author,
      date: date,
      webURL: webURL,
      image: image,
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

    test('PageRouteBuilder should return a valid route', () {
      final route = _createRoute(
        'image',
        'content',
        'description',
        'title',
        'date',
        'author',
        'webURL',
      );

      expect(route, isA<PageRouteBuilder>());
    });
  });

 
}
