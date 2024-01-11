import 'package:logger/logger.dart';

import '../../../components/base/base_repository.dart';
import '../../../components/util/state.dart';
import '../model/post_data_model.dart';
import '../model/post_data_send_model.dart';
import 'post_datasource.dart';

class PostRepository extends BaseRepository {
  final PostDataSource _dataSource;
  final _logger = Logger();
  PostRepository(this._dataSource);

  void loadPosts({
    required ResponseHandler<List<PostDataModel>> response,
  }) async {
    try {
      final data = await _dataSource.apiGetPosts().then(mapToData).then(
        (value) {
          List<PostDataModel> items = [];
          value.forEach((v) => items.add(PostDataModel.fromJson(v)));
          return items;
        },
      );
      response.onSuccess.call(data);
      response.onDone.call();
    } catch (e) {
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }

  void sendPost({
    required ResponseHandler<PostDataModel> response,
    required PostDataSendModel request,
  }) async {
    try {
      final data = await _dataSource.apiSendPost(request).then(mapToData).then(
        (value) {
          return PostDataModel.fromJson(value);
        },
      );
      response.onSuccess.call(data);
      response.onDone.call();
    } catch (e) {
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }

  void updatePost({
    required ResponseHandler<PostDataModel> response,
    required PostDataSendModel request,
    required int id,
  }) async {
    try {
      final data = await _dataSource.apiUpdatePost(request, id).then(mapToData).then(
        (value) {
          return PostDataModel.fromJson(value);
        },
      );
      response.onSuccess.call(data);
      response.onDone.call();
    } catch (e) {
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }

  void deletePost({
    required ResponseHandler<String> response,
    required int id,
  }) async {
    try {
      final data = await _dataSource.apiDelPost(id);
      _logger.i('Delete $data');
      response.onSuccess.call("Sukses hapus salah satu data 😁");
      response.onDone.call();
    } catch (e) {
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }
}
