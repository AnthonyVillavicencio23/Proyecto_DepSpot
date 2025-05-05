import 'dart:convert';

import 'package:http/http.dart' as http;

String apiKey =
    "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";

Future sendTextCompletionRequest(String message) async {
  const String baseUrl = "https://api.openai.com/v1/chat/completions";

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Authorization": "Bearer $apiKey",
  };

  try {
    var res = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: json.encode({
        "model": "gpt-4o-mini",
        "messages": [
          {"role": "user", "content": message},
        ],
        "temperature": 0.7,
      }),
    );

    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    } else {
      print("⚠️ Error de OpenAI: ${res.statusCode}");
      print("📩 Cuerpo de la respuesta: ${res.body}");
      return {
        "error": true,
        "message": "Error ${res.statusCode}: ${res.reasonPhrase}",
      };
    }
  } catch (e) {
    print("❌ Excepción al hacer request: $e");
    return {"error": true, "message": "Excepción: $e"};
  }
}
