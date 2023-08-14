import 'package:flutter/material.dart';
import 'package:news_app_assignment/widgets/colors.dart';

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
    return GestureDetector(
      onTap: onpress,
      child: Card(
        elevation: 2,
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
                        image: NetworkImage(image),
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
                padding: const EdgeInsets.fromLTRB(4, 18,8,8),
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
                    const SizedBox(height: 8.0),
                    Text(description,maxLines: 2,overflow:TextOverflow.ellipsis   ,style:const  TextStyle(color:Colors.blueGrey,fontSize: 13,),),
                    const SizedBox(height: 8.0),
                    const SizedBox(height: 5.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 130),
                      child: Text(date, style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10)),
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
