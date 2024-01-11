import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../components/config/app_route.dart';
import '../../../../components/util/state.dart';
import '../../model/post_argument_model.dart';
import '../../model/post_data_send_model.dart';
import '../../repository/post_repository.dart';
import '../../state/post_form_state.dart';

class PostFormController extends GetxController {
  //
  final PostRepository _repository;
  final _logger = Logger();
  //
  PostFormController(this._repository);

  TextEditingController inputBody = TextEditingController();
  TextEditingController inputUser = TextEditingController();
  TextEditingController inputTitle = TextEditingController();
  //
  PostFormState state = PostFormIdle();
  String titleAppBar = "";
  String action = "";
  int id = 0;
  //
  String? errorUser;
  String? errorTitle;
  String? errorBody;
  //
  bool isReady = false;

  @override
  void onInit() {
    _initArgument();
    _checkInputs();
    super.onInit();
  }

  void _initArgument() {
    PostArgumentModel output = Get.arguments;
    titleAppBar = "${output.titleAppBar}";
    action = "${output.action}";
    if (output.data != null) {
      var data = output.data;
      id = data!.id!;
      inputUser.text = "${data.userId}";
      inputBody.text = "${data.body}";
      inputTitle.text = "${data.title}";
    }
    update();
  }

  void _checkInputs() {
    inputUser.addListener(() {
      errorUser = null;
      if (inputUser.text.isEmpty) {
        errorUser = "User ID tidak boleh kosong";
      }
      _validation();
    });

    inputTitle.addListener(() {
      errorTitle = null;
      if (inputTitle.text.isEmpty) {
        errorTitle = "Title tidak boleh kosong";
      }
      _validation();
    });

    inputBody.addListener(() {
      errorBody = null;
      if (inputBody.text.isEmpty) {
        errorBody = "Body tidak boleh kosong";
      }
      _validation();
    });
  }

  void _validation() {
    if (inputUser.text.isNotEmpty &&
        inputTitle.text.isNotEmpty &&
        inputBody.text.isNotEmpty) {
      isReady = true;
    } else {
      isReady = false;
    }
    update();
  }

  void onSaveClicked() {
    if (action == "add") {
      _onAdd();
    } else {
      _onEdit();
    }
  }

  void _onAdd() {
    state = PostFormLoading();
    update();
    var userId = int.parse(inputUser.text);
    _repository.sendPost(
      request: PostDataSendModel(
        userId: userId,
        body: inputBody.text,
        title: inputTitle.text,
      ),
      response: ResponseHandler(
        onSuccess: (res) {
          _logger.i("response add: ${res.toJson().toString()}");
          _snackBar(
            backgroundColor: Colors.green,
            title: "Sukses",
            message: "Sukses menambah data.",
            onStatus: (status) {
              if (status == SnackbarStatus.CLOSED) {
                Get.offNamedUntil(AppRoute.postData, (route) => false);
              }
            },
          );
        },
        onFailed: (e) {
          _snackBar(
            backgroundColor: Colors.red,
            title: "Error",
            message: "Gagal menambah data.",
          );
        },
        onDone: () {
          state = PostFormIdle();
          update();
        },
      ),
    );
  }

  _snackBar({
    String title = "",
    String message = "",
    Color backgroundColor = Colors.green,
    void Function(SnackbarStatus?)? onStatus,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      animationDuration: 0.5.seconds,
      snackbarStatus: onStatus,
    );
  }

  void _onEdit() {
    state = PostFormLoading();
    update();
    var userId = int.parse(inputUser.text);
    _repository.updatePost(
      request: PostDataSendModel(
        userId: userId,
        body: inputBody.text,
        title: inputTitle.text,
      ),
      id: id,
      response: ResponseHandler(
        onSuccess: (res) {
          _logger.i("response update: ${res.toJson().toString()}");
          _snackBar(
            backgroundColor: Colors.green,
            title: "Sukses",
            message: "Sukses mengubah data.",
            onStatus: (status) {
              if (status == SnackbarStatus.CLOSED) {
                Get.offNamedUntil(AppRoute.postData, (route) => false);
              }
            },
          );
        },
        onFailed: (e) {
          _logger.i(e);
          _snackBar(
            backgroundColor: Colors.red,
            title: "Error",
            message: "Gagal mengubah data.",
          );
        },
        onDone: () {
          state = PostFormIdle();
          update();
        },
      ),
    );
  }
}
