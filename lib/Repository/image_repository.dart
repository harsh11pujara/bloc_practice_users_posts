import 'dart:convert';

import 'package:bloc_practice/image_model.dart';
import 'package:http/http.dart' as http;

class ImageRepository{
  String url = 'https://jsonplaceholder.typicode.com/photos';

  Future<List<ImageModel>> getImgData() async{
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as List;
      final data = json.map((e) => ImageModel(title: e['title'], url: e['url'])).toList();
      return data;
    }else{
      throw 'Error ${response.reasonPhrase.toString()}';
    }

  }
}
