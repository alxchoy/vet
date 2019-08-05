import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import './api-service.dart';
import '../../utils/helpers.dart';
import '../../shared/constants.dart';

class BaseService {
  callService({BuildContext context, Function service}) async {
    Helpers.showLoader(context: context);
    try {
      final response = await service();
      Helpers.dismissLoader(context: context);

      return response;

    } catch(e) {
      Helpers.dismissLoader(context: context);
      print('Error Base Service $e');

      return 'Error pe!!';
    }
  }
}