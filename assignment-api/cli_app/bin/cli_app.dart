
import 'package:http/http.dart' as http;

Future<void> main(List<String> arguments) async {
  String num='12';
  print("input number is :$num");
  String resp= await getresp(num);
  print(resp);
}

Future<String> getresp(String i) async
 {
  print("fetching responce from url");
try{
var mod="http://numbersapi.com/"+i;
var url = Uri.parse(mod);
var response = await http.get(url);
print('Response status: ${response.statusCode}');
// print('Response body: ${response.body}');
String body=response.body;

  return body;}
  catch(e)
  {
    return "lost connection 🙄";
  }
}
