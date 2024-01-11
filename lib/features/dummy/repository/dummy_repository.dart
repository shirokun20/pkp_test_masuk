
import 'package:logger/logger.dart';

import '../../../components/base/base_repository.dart';
import '../../../components/util/state.dart';
import '../model/dummy_model.dart';
import 'dummy_datasource.dart';

class DummyRepository extends BaseRepository {
  final DummyDataSource _dataSource;
  final _logger = Logger();
  DummyRepository(this._dataSource);


  void loadFoods({
    required ResponseHandler<List<SampleModel>> response
  }) async {
    try {
      final data = await _dataSource.apiFoods().then(mapToData).then((value) {
        List<SampleModel> items = [];
        value.forEach((v) => items.add(SampleModel.fromJson(v)));
        return items;
      });
      response.onSuccess.call(data);
      response.onDone.call();
    } catch (e) {
      _logger.e(e);
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }

}