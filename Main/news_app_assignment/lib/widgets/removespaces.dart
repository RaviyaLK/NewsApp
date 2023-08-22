import 'package:flutter/material.dart';

class Removespaces{
 removeExtraSpaces(TextEditingController searchController) {
    String originalText = searchController.text;
    String modifiedText = originalText.replaceAll(RegExp(r'\s+'), ' ');
    searchController.text = modifiedText;
    searchController.selection = TextSelection.fromPosition(
      TextPosition(offset: searchController.text.length),
    );
  }
}