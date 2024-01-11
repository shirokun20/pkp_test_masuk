import 'package:get/get.dart';

import '../../../components/util/network.dart';
import '../presentation/post_form/post_form_controller.dart';
import '../repository/post_datasource.dart';
import '../repository/post_repository.dart';

class PostFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostDataSource(Network.dioClient()));
    Get.lazyPut(() => PostRepository(Get.find()));
    Get.lazyPut(() => PostFormController(Get.find()), fenix: true);
  }
}
