import 'dart:convert';

import 'package:http/http.dart' as http;

class Requests 
{
  static Future<Map<String, dynamic>> sentimentAnalysis(String text, {int counter=0}) async
  {
    if(counter >= 3)
      return null;


    var client = http.Client();
    try {
      var response = await client.post(
          'http://127.0.0.1:5000/text/sentiment_analysis',
          body: {'text': text}
      );

      if(response.statusCode != 200)
        return await sentimentAnalysis(text, counter: counter+1); // try again 2 three times
      return json.decode((response.body));
    } finally {
      client.close();
    }
  }

  static dynamic entityAnalysis(String text, {int counter=0}) async {
    if(counter >= 3)
      return null;


    var client = http.Client();
    try {
      var response = await client.post(
          'http://127.0.0.1:5000/text/entity_analysis',
          body: {'text': text}
      );

      if(response.statusCode != 200)
        return await sentimentAnalysis(text, counter: counter+1); // try again 2 three times
      return json.decode((response.body));
    } finally {
      client.close();
    }
  }
}