import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/colors.dart';
import '../widgets/news_card.dart';

String searchQuery = '';

final searchBarFocusedProvider = StateProvider<bool>((ref) => false);
final FocusNode _searchFocusNode = FocusNode();

class NewsPage extends ConsumerWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchBarFocused = ref.watch(searchBarFocusedProvider);
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.grey,
        backgroundColor: hexStringToColor("#1858d2"),
        centerTitle: true,
        title: const Text('News Feed'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.09),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 20),
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: isSearchBarFocused ? screenWidth * 0.65 : screenWidth * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[300],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _searchFocusNode,
                            onTap: () {
                              _searchFocusNode.requestFocus();
                              ref.read(searchBarFocusedProvider.notifier).state = true;
                            },
                            onChanged: (value) {
                              // Handle onChanged
                            },
                            decoration: const InputDecoration.collapsed(
                              hintStyle: TextStyle(color: Colors.grey),
                              hintText: 'Search',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isSearchBarFocused)
                  GestureDetector(
                    onTap: () {
                      ref.read(searchBarFocusedProvider.notifier).state = false;
                      _searchFocusNode.unfocus();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
        shrinkWrap: true,
        
        itemCount:4,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: (){
              // Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => InfoPage()));
            },
            child: NewsCard(
              
              title:"title",
              description:"title",
              image: "title",
              date: "title",
            ),
          );
        },
      ), 
      ),
    );
  }
}
