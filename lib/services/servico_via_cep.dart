import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/resultado_cep.dart';

class ServicoViaCep {
  Future<ResultadoCep?> buscarCep(String cep) async {
    final url = Uri.parse('https://viacep.com.br/ws/$cep/json/');

    try {
      final resposta = await http.get(url);

      if (resposta.statusCode == 200) {
        final Map<String, dynamic> dados = json.decode(resposta.body);

        if (dados.containsKey('erro')) {
          return null;
        }

        return ResultadoCep.fromJson(dados);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
