import 'package:network_inspector/domain/entities/activity.dart';
import 'package:network_inspector/domain/entities/http_response.dart';
import 'package:network_inspector/domain/entities/http_request.dart';
import 'package:network_inspector/domain/repositories/log_repository.dart';
import 'package:network_inspector/infrastructure/datasources/log_datasource.dart';
import 'package:network_inspector/infrastructure/mappers/http_request_mapper.dart';
import 'package:network_inspector/infrastructure/mappers/http_response_mapper.dart';

class LogRepositoryImpl implements LogRepository {
  final LogDatasource logDatasource;
  LogRepositoryImpl({
    required this.logDatasource,
  });

  @override
  Future<List<HttpRequest>?> httpRequests({
    int? id,
    int? startDate,
    int? endDate,
    String? url,
  }) async {
    var models = await logDatasource.httpRequests(
      id: id,
      url: url,
      startDate: startDate,
      endDate: endDate,
    );
    var entities = (models != null)
        ? List<HttpRequest>.from(
            models.map(
              (model) => HttpRequestMapper.toEntity(
                model,
              ),
            ),
          )
        : null;
    return entities;
  }

  @override
  Future<List<HttpResponse>?> httpResponses({
    int? requestHashCode,
  }) async {
    var models = await logDatasource.httpResponses(
      requestHashCode: requestHashCode,
    );
    var entities = (models != null)
        ? List<HttpResponse>.from(
            models.map(
              (model) => HttpResponseMapper.toEntity(
                model,
              ),
            ),
          )
        : null;
    return entities;
  }

  @override
  Future<bool> logHttpRequest({
    required HttpRequest httpRequestModel,
  }) async {
    var model = HttpRequestMapper.toModel(httpRequestModel);
    var result = await logDatasource.logHttpRequest(
      httpRequestModel: model,
    );
    return result;
  }

  @override
  Future<bool> logHttpResponse({
    required HttpResponse httpResponseModel,
  }) async {
    var model = HttpResponseMapper.toModel(httpResponseModel);
    var result = await logDatasource.logHttpResponse(
      httpResponseModel: model,
    );
    return result;
  }
}
