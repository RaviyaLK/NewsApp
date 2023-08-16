import 'package:flutter/material.dart';


class NewsCard extends StatelessWidget {
  
  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.onpress,
  }) : super(key: key);

  final String title;
  final String description;
  final String image;
  final String date;
  final Function() onpress;

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenHeight =MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onpress,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      image: DecorationImage(
                        onError: (exception, stackTrace) => const Icon(Icons.error),
                        scale: 1,
                        image: NetworkImage(image,
                        ),
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding:  EdgeInsets.fromLTRB(screenwidth*0.01, screenHeight*0.02,screenwidth*0.02,screenHeight*0.01),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height:screenHeight*0.02),
                    Text(
                      description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: screenHeight*0.02),                   
                    Padding(                      
                      padding: EdgeInsets.only(left: screenwidth*0.3),
                      child: Text(
                        date,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
