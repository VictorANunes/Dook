import 'dart:convert';
import 'package:dook/models/book_models.dart';
import 'package:http/http.dart' as http;

class GetBook {
  Future<Book> getData(String isbn) async {
    final jsonResponse = await http.get(
        Uri.parse('https://www.googleapis.com/books/v1/volumes?q=isbn:$isbn'));

    var jsonBody = json.decode(jsonResponse.body);
    //print(json.encode(jsonBody));
    if (jsonBody['items'][0] != null) {
      Book book = new Book.fromJson(jsonBody);
      return book;
    } else {
      Book book = new Book();
      return book;
    }
  }
}
