//import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dio/dio.dart';


class ErgoHttpApi {

  late Dio dio;



  ErgoHttpApi({ required String baseUrl, required int connectTimeout, required int receiveTimeout })
  {
    var options = BaseOptions(
      baseUrl: baseUrl, //'https://cloudmatic.one/shadow_tests/api.php/',
      connectTimeout: connectTimeout, //5000,
      receiveTimeout: receiveTimeout, //3000,
    );

    dio = Dio(options);

    dio.interceptors.add(CustomInterceptors());


  }

  Future<Response> request({required String path, required dynamic data, required String method}) async {

    var response = await dio.request(
      path,
      data: data,
      options: Options(method: method),
    );
    print(response);
    return response;
  }
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}




// OLD API begor dio implementation

/*

//Future<String>
Future<http.Response> getRequest({required String uri}) async {
  //replace your restFull API here.

  String _response = "no";

  //String uri = 'https://cloudmatic.one/shadow_tests/api.php/records/test/1';
  var response = await http.get(Uri.parse(uri));


  if (response.statusCode == 200) {
    _response = response.body;
    //print(response.body);

    var responseData = json.decode(response.body);

    //setState(() {});

    Map<String, dynamic> jsonresponse = jsonDecode(response.body.toString());

    //return response.body.toString();

   // return _response; //jsonresponse;
  }
  // else {
  //   var result = {'Error':response.statusCode};
  //   return response.statusCode.toString(); //result;
  // }
  //
  return response;

  //Creating a list to store input data;
  // List<User> users = [];
  // for (var singleUser in responseData) {
  //   User user = User(
  //       id: singleUser["id"],
  //       userId: singleUser["userId"],
  //       title: singleUser["title"],
  //       body: singleUser["body"]);
  //
  //   //Adding user to the list.
  //   users.add(user);
  // }
  // return users;

}

Future<Map> putRequest({required String uri, required String jsonString}) async {

  var response = await http.put(Uri.parse(uri), headers: { "Content-Type" : "application/json"}, body: jsonString);
  if (response.statusCode == 200) {
    var result = {'Ok':response.statusCode};
    return result;
  }
  else {
    var result = {'Error':response.statusCode};
    return result;
  }


}
*/