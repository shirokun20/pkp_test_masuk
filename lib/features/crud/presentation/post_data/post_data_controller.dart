import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../components/util/state.dart';
import '../../model/post_data_model.dart';
import '../../repository/post_repository.dart';
import '../../state/post_data_state.dart';

class PostDataController extends GetxController {
  final PostRepository _repository;
  final _logger = Logger();
  PostDataController(this._repository);
  //
  PostDataState state = PostDataIdle();
  List<PostDataModel> list = [];

  @override
  void onInit() {
    _loadAllPost();
    super.onInit();
  }

  void onRefresh() => _loadAllPost();

  void _loadAllPost() {
    state = PostDataLoading();
    update();
    _repository.loadPosts(
      response: ResponseHandler(
        onSuccess: (res) {
          state = PostDataLoadSuccess(res);
        },
        onFailed: (e) {
          _logger.e(e);
          state = PostDataError();
        },
        onDone: () => update(),
      ),
    );
  }

  void onDeletePost(int id) {
    _repository.deletePost(
      response: ResponseHandler(
        onSuccess: (res) {
          _logger.i("Response Delete: $res");
          Get.snackbar(
            "Sukses",
            res,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            animationDuration: 0.5.seconds
          );
        },
        onFailed: (e) {
          _logger.e(e);
        },
        onDone: () => Future.delayed(1.seconds, () => _loadAllPost()),
      ),
      id: id,
    );
  }
}
