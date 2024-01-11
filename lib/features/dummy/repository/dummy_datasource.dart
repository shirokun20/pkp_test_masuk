
import '../../../components/base/base_dio_datasource.dart';
import '../../../components/ext/dio_ext.dart';

class DummyDataSource extends BaseDioDataSource {
  DummyDataSource(super.client);

  Future<String> apiFoods() {
    String path = 'foods';
    return get<String>(path).load();
  }

}
