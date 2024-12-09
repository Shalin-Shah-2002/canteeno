import 'package:canteeno/models/ItemsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Itemsmodel>> apifuntion(String query, int page) async {
  final String baseUrl = "https://myfitnesspal2.p.rapidapi.com";
  final Map<String, String> headers = {
    'x-rapidapi-key': '770c5217aamsh4036dfd7808321dp197313jsnaf3d0399a3b3',
    'x-rapidapi-host': 'myfitnesspal2.p.rapidapi.com',
  };

  final Uri url = Uri.parse('$baseUrl/searchByKeyword?keyword=$query&page=$page');

  try {
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Directly decode as a list
      List<dynamic> data = json.decode(response.body);
      print('API Response: $data');  // Log the response for debugging

      // Map the list to your model
      return data.map((item) => Itemsmodel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load data. Status code: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
    throw Exception('Failed to load data: $error');
  }
}
