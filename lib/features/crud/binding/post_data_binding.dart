import 'package:get/get.dart';

import '../../../components/util/network.dart';
import '../presentation/post_data/post_data_controller.dart';
import '../repository/post_datasource.dart';
import '../repository/post_repository.dart';

class PostDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostDataSource(Network.dioClient()));
    Get.lazyPut(() => PostRepository(Get.find()));
    Get.lazyPut(() => PostDataController(Get.find()), fenix: true);
  }
}
