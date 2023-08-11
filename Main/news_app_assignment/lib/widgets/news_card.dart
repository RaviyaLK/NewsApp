import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
  }) : super(key: key);

  final String title;
  final String description;
  final String image;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 20, 0, 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage("https://th.bing.com/th/id/R.dabb052406b98ad53abf976db0679e31?rik=Es5Oobx0kFRC%2bg&riu=http%3a%2f%2f4.bp.blogspot.com%2f-cQ4XnoW4Ysc%2fTzbg3Jh25VI%2fAAAAAAAAA74%2fxFjSDny2SqU%2fs1600%2f21.Jpg&ehk=Q88y%2b7a98mHBLzs3%2fXLC4iuSw8LOmnic8Q%2bqgUPUcpg%3d&risl=&pid=ImgRaw&r=0"),
                      alignment: Alignment.center,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(description),
                  const SizedBox(height: 8.0),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Text(date),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
