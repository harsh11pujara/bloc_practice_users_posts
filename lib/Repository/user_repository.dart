import 'dart:convert';

import 'package:bloc_practice/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  String url = 'https://jsonplaceholder.typicode.com/users';

  Future<List<UserModel>> getUserData() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('data success');
      final decodeJson = jsonDecode(response.body) as List;
      final data = decodeJson.map((e) {
        return UserModel(
              id: e['id'].toString(),
              name: e['name'],
              email: e['email'],
              city: e['address']['city'],
              phone: e['phone'].toString());
      }).toList();
      return data;
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}
