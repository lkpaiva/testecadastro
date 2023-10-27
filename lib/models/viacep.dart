import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ViaCepApi {
  static Future<Map> makeRequest( String cep ) async {
    final url = Uri.parse("https://viacep.com.br/ws/$cep/json");

    final Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    late http.Response response;

    try {
          response = await http.get(url, headers: headers);
      return json.decode(response.body);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return {
        "error": {"description": "Erro de exceção ao obter dados."}
      };
    }
  }
}