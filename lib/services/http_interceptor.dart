import 'dart:developer';

import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends InterceptorContract {

  Logger logger = Logger();

  @override
  Future<BaseRequest> interceptRequest({
    required BaseRequest request,
  }) async {

    logger.i("------------REQUEST-----------");
    logger.i("REQUISITON FOR ${request.url}\nHEADERS: ${request.headers}\nBODY: ${request}");
    print(request.toString());
    print(request.headers.toString());
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    if(response.statusCode ~/ 100 == 2){
      logger.i("------------RESPONSE-----------");
      logger.i("RESPONSE FOR ${response.request?.url}\nHEADERS: ${response.headers}\nBODY: ${response.request}");
      log('Code: ${response.statusCode}');
      if (response is Response) {
        logger.w((response).body);
      }
    }
    else
      {
        logger.e("------------RESPONSE-----------");
      }
    return response;
  }
}