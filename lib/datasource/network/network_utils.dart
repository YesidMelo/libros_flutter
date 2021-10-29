import 'dart:convert';
import "dart:core";
import "dart:async";
import 'package:http/http.dart' as http;

const String kQueryOperator = "?";
const String kPathKey = "{param}";
const String kBasePath = "https://43861afc-9289-4b49-8efe-101ff222d415.mock.pstmn.io/api/v1/";

String addParams({
  required Map<String,dynamic> parameters,
  required String url,
}) {
  String modifiedUrl = url;
  parameters.forEach((String key, dynamic value) {
    if(!modifiedUrl.contains(kQueryOperator)) {
      /// No query param has been added before so it appends the "?"
      modifiedUrl += kQueryOperator;
    } else {
    modifiedUrl += "&";
    }
    modifiedUrl += "$key=$value";
  });
  return modifiedUrl;
}

String addPath({
  required dynamic parameter,
  required String url
}) {
  try {
    if(!url.contains(kPathKey)) {
      return url;
    }

    String modifiedUrl = url;
    if(parameter is List<dynamic>) {

      parameter.forEach((dynamic element) {
        modifiedUrl = modifiedUrl.replaceFirst(kPathKey, "$element");
      });
      return modifiedUrl;

    }

    modifiedUrl = modifiedUrl.replaceAll(kPathKey, parameter.toString());
    return modifiedUrl;

  } on Exception catch (e) {
    print("Error : $e");
    return url;
  }
}

Future<Map<dynamic, dynamic>> callDelete({
  required String serviceUrl,
  Map<String,String>? headers,
}) async{
  print("url $serviceUrl");
  final Map<dynamic,dynamic> result = await safeApiCall(
    http.delete(
        Uri.parse(serviceUrl),
        headers: headers
    )
  );
  
  return result;
}

Future<Map<dynamic, dynamic>> callGet({
  required String serviceUrl,
  Map<String,String>? headers,
}) async{
  print("url $serviceUrl");
  final Map<dynamic,dynamic> result = await safeApiCall(
    http.get(
        Uri.parse(serviceUrl),
        headers: headers
    )
  );

  return result;
}

Future<Map<dynamic,dynamic>> callPost({
  required String serviceUrl,
  Map<String, String>? headers,
  dynamic body
}) async {
  print("url $serviceUrl");
  final Map<dynamic, dynamic> response = await safeApiCall(
        http.post(
        Uri.parse(serviceUrl),
        headers: headers,
          body: body
    )
  );
  return response;
}

Future<Map<dynamic,dynamic>> safeApiCall (Future<http.Response> serviceCall)  async {

  final http.Response call = await serviceCall;
  final decode = jsonDecode(call.body);
  print("json response : $decode");
  return decode;
}

void responsManage(Function error, Function success, int code) {
  if(code == 200) {

    success();
  } else {
    error();
  }
}