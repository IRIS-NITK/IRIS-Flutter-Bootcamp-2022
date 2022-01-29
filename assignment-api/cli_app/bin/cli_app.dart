
import 'dart:math';
import 'package:http/http.dart' as http;
// import 'dart:convert';

Future<void> main(List<String> arguments) async {
  // String resp= await getresp(num);
  // print(resp);
   int i=randomnum();
   String j=i.toString();
   print("input number is :$i");
   String resp= await getresp(j);
  print(resp);
}

int randomnum()
{
   int num=Random().nextInt(100) ;
   return num;
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
