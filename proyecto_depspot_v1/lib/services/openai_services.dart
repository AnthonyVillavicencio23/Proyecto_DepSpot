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
