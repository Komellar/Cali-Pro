import 'package:http/http.dart';
import 'dart:convert';

class MotivationQuote {
  late String quote;

  Future<void> getQuote() async {
    try {
      Response response = await get(Uri.parse('https://www.affirmations.dev/'));
      Map data = jsonDecode(response.body);

      // get property from data
      this.quote = data['affirmation'];
      print(this.quote);
    } catch (e) {
      print('caught error: $e');
    }
  }

}
