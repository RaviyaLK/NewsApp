import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, required this.onTap, required this.onChanged, required this.onEditingComplete, required this.isSearchBarFocused, required this.searchFocusNode, required this.searchController});
 final  TextEditingController searchController;
 final  FocusNode searchFocusNode;
 final Function onTap;
 final Function onChanged;
  final Function onEditingComplete;
  final bool isSearchBarFocused;

  @override
  Widget build(BuildContext context) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search, color: Colors.grey),
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.words,
              autofocus: false,
              autocorrect: true,
              controller: searchController,
              focusNode: searchFocusNode,
              onTap: () async {
                onTap();
                }, //sets the search history to the provider
              
              onChanged: (value) {
               onChanged(value);
                },
                
              
              onEditingComplete: () async {
                onEditingComplete();                            
              },
              decoration: const InputDecoration.collapsed(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Search',
              ),
            ),
          ),
          if (isSearchBarFocused)
          IconButton(
            icon:const Icon(Icons.close, color: Colors.grey,size: 20,),
            onPressed:(){ 
              searchController.clear();
              searchFocusNode.unfocus();
            },
           ),
        ],
      );
  }
}