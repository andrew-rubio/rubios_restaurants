import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return data;
    } else {
      print(response.statusCode);
    }
  }

  Future updateData(jsonBody) async {
    Map<String, String> headers = {"Content-Type": "application/json"};
//    String json = jsonBody;

    // make PATCH request
    http.Response response =
        await http.patch(url, headers: headers, body: jsonBody);
    print('url: $url');
    print('headers: $headers');
    print('body: $jsonBody');
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data);
      return data;
    } else {
      print(response.statusCode);
    }
  }
}
