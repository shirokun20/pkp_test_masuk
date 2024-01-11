import 'package:get/get.dart';

import '../../../components/util/network.dart';
import '../presentation/dummy_controller.dart';
import '../repository/dummy_datasource.dart';
import '../repository/dummy_repository.dart';

class DummyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DummyDataSource(Network.dioClient()));
    Get.lazyPut(() => DummyRepository(Get.find()));
    Get.lazyPut(() => DummyController(Get.find()));
  }
}