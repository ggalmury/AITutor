import 'dart:convert';
import 'package:ai_tutor/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GPTApi {
  Future<String?> fetchAnswer(String question) async {
    loggerNoStack.i("GPT request: $question");

    var response = await http.post(
      Uri.parse(
          'https://api.openai.com/v1/chat/completions'), // OpenAI's GPT-3 API URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${dotenv.get("GPT_API_KEY")}',
      },
      body: jsonEncode(<String, dynamic>{
        // TODO: fix prompt
        "model": "gpt-3.5-turbo",
        "messages": [
          {
            "role": "user",
            "content":
                "You are an AI trained to provide empathetic and supportive responses like a professional counselor. $question"
          }
        ],
        "temperature": 0.7
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(utf8.decode(response.bodyBytes));
      String gptResponse = result['choices'][0]['message']
          ["content"]; // OpenAI's GPT-3 response key

      loggerNoStack.i("GPT response: $gptResponse");
      return gptResponse;
    } else {
      loggerNoStack.e("GPT response error ${response.body}");
      return null;
    }
  }
}
