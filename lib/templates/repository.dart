repositoryTemplate() {
  return """
import '../../../helpers/api.dart';
import '../../../models/response_data.dart';
import '../../../helpers/rb_helpers.dart';
import '@filename.dart';

class @classNameRepository {
  final api = Api();

  getData(
      {Map<String, dynamic>? params,
      required Function(ResponseData result) onSuccess,
      Function(dynamic error)? onError}) {
    api.get(
      '@api',
      params: params,
      onError: (e) {
        if (onError != null) onError(e);
      },
      onSuccess: (result) {
        try {
          final responseData = ResponseData();
          responseData.message = result['message'];

          var data = [];
          if (params != null &&
              params.containsKey("paginate") &&
              params['paginate'] == 'no') {
            data = result['data'];
          } else {
            data = result['data']['data'];
          }

          final list = <@modelName>[];
          for (var d in data) {
            list.add(@modelName.fromMap(d));
          }
          responseData.listData = list;

          onSuccess(responseData);
        } catch (e, track) {
          if (onError != null) {
            onError(trace(e, track));
          }
        }
      },
    );
  }

  getDetail(int id,
      {required Function(ResponseData result) onSuccess,
      Function(dynamic error)? onError}) {
    api.get(
      '@api/\$id',
      onError: (e) {
        if (onError != null) onError(e);
      },
      onSuccess: (result) {
        try {
          final responseData = ResponseData();
          responseData.message = result['message'];
          final data = @modelName.fromMap(result['data']);
          responseData.data = data;

          onSuccess(responseData);
        } catch (e, track) {
          if (onError != null) {
            onError(trace(e, track));
          }
        }
      },
    );
  }

  save(String url, dynamic params,
      {required Function(ResponseData result) onSuccess,
      Function(dynamic error)? onError}) {
    api.post(
      url,
      params,
      onError: (e) => {if (onError != null) onError(e)},
      onSuccess: (result) {
        final responseData = ResponseData();
        responseData.message = result['message'];
        onSuccess(responseData);
      },
    );
  }

  delete(int id,
      {required Function(ResponseData result) onSuccess,
      Function(dynamic error)? onError}) {
    api.delete(
      '@api/\$id',
      onError: (e) => {if (onError != null) onError(e)},
      onSuccess: (result) {
        final responseData = ResponseData();
        responseData.message = result['message'];
        onSuccess(responseData);
      },
    );
  }
}


""";
}
