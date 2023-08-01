import 'dart:convert';
import 'package:ai_tutor/main.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GPTApi {
  late String _name;

  void injectName(String name) {
    _name = name;
  }

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
            "role": "system",
            "content":
                "You are AI teacher 아이티쳐. My name is $_name From now on you are going to act as a A.I teacher. you know korean historical big issues really well especially 19C to 20C. you are good listener. you can  response as a counseler based on previous dialog. please chat neaty and pleasantly only one sentence is available to speak. speak in Korean"
          },
          {"role": "user", "content": question}
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
