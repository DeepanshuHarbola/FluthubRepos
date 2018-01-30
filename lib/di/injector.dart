import 'package:fluthubrepos/data/services/api_client.dart';

class Injector {

  static final Injector injector = new Injector._injector();
  ApiClient _client;

  Injector._injector(){
    _client = new ApiClient();
  }

  factory Injector() {
    return injector;
  }

  ApiClient get client => _client;

}