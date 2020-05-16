import 'package:http/http.dart' as http;

class Requests 
{
  static Future<dynamic> sendRequest(String mood, String text, int counter) async
  {
    if(counter >= 3)
      return;

    print({'mood': mood, 'inputText': text});

    var client = http.Client();
    try {
      var response = await client.post(
          'https://enqewmoj7qt7e.x.pipedream.net',
          body: {'mood': mood, 'inputText': text});

      if(response.statusCode != 200)
        return await sendRequest(mood, text, counter+1); // try again 2 three times

      print('Response Status: ${response.statusCode}');
      return response.body;
    } finally {
      client.close();
    }
  }
}