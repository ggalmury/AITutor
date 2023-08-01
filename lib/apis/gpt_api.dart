import 'dart:convert';
import 'package:http/http.dart' as http;

class GPTApi {
  Future<String?> fetchAnswer(String questiion) async {
    var response = await http.post(
      Uri.parse(
          'https://api.openai.com/v1/chat/completions'), // OpenAI's GPT-3 API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization':
            'Bearer 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', // Replace with your actual OpenAI API key
      },
      body: jsonEncode(<String, dynamic>{
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "user", "content": questiion}
        ],
        "temperature": 0.7
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      String gptResponse = result['choices'][0]['message']
          ["content"]; // OpenAI's GPT-3 response key
      print(result);
      return gptResponse;
    } else {
      return null;
    }
  }
}
