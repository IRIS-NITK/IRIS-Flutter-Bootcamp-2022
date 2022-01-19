import 'package:cli_app/cli_app.dart' as cli_app;
import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  String num='12';
  print('Hello world: ${cli_app.calculate()}!');
  String resp= await getresp(num);
  print(resp);
}

Future<String> getresp(String i) async {
  print("fetching responce from url");
  var mod="http://numbersapi.com/"+i;
var url = Uri.parse(mod);
var response = await http.get(url);
print('Response status: ${response.statusCode}');
// print('Response body: ${response.body}');
String body=response.body;
 
  return body;
}
