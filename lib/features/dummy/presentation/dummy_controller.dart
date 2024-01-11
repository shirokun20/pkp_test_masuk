import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../components/util/helper.dart';
import '../../../components/util/state.dart';
import '../repository/dummy_repository.dart';
import 'dummy_state.dart';

class DummyController extends GetxController {
  final DummyRepository _repository;
  DummyState foodState = DummyFoodIdle();
  final _logger = Logger();
  DummyController(this._repository);

  @override
  void onInit() {
    _loadAllFood();
    super.onInit();
  }

  void _loadAllFood() {
    foodState = DummyFoodLoading();
    update();
    _repository.loadFoods(
        response: ResponseHandler(
            onSuccess: (listFood) {
              foodState = DummyFoodLoadSuccess(listFood);
            },
            onFailed: (e, message){
              _logger.e(e);
              AlertModel.showBasic("Error", message);
              foodState = DummyFoodError();

            },
            onDone: () {
              update();
            })
    );
  }
}