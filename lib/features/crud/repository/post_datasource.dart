import '../../../components/base/base_dio_datasource.dart';
import '../../../components/ext/dio_ext.dart';
import '../model/post_data_send_model.dart';

class PostDataSource extends BaseDioDataSource {
  PostDataSource(super.client);

  Future<String> apiGetPosts() {
    String path = 'posts';
    return get<String>(path).load();
  }

  Future<String> apiSendPost(PostDataSendModel req) {
    String path = 'posts';
    return post<String>(path, data: req.toJson()).load();
  }

  Future<String> apiUpdatePost(PostDataSendModel req, int id) {
    String path = 'posts/$id';
    return put<String>(path, data: req.toJson()).load();
  }

  Future apiDelPost(int id) {
    String path = 'posts/$id';
    return delete<String>(path).loadOrNull();
  }
}
