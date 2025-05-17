import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/result_cep.dart';

class ViaCepService {
  Future<ResultCep?> buscarCep(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data.containsKey('erro')) {
          return null;
        }

        return ResultCep.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
