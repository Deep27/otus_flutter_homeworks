import 'package:cocktaildbhttpusing/src/repository/query_status.dart';

class Response<T> {
  Response({this.status, this.response});

  QueryStatus status;
  T response;
}
