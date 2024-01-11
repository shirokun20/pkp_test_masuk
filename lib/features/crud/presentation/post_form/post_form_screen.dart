import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../state/post_form_state.dart';
import 'post_form_controller.dart';

class PostFormScreen extends GetView<PostFormController> {
  const PostFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostFormController>(builder: (ctrl) {
      return Scaffold(
        appBar: _appBar(title: ctrl.titleAppBar),
        body: _body(),
        floatingActionButton: _floattingBtn(
          onTap: () => ctrl.onSaveClicked(),
          isReady: ctrl.isReady,
        ),
      );
    });
  }

  Widget _floattingBtn({
    void Function()? onTap,
    bool isReady = false,
  }) {
    return FloatingActionButton(
      onPressed: isReady ? onTap : () {},
      elevation: 0,
      backgroundColor: isReady ? Colors.red : Colors.red.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1000),
      ),
      child: const Icon(
        Icons.save,
        color: Colors.white,
      ),
    );
  }

  PreferredSizeWidget _appBar({
    String title = "",
  }) {
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.white,
    );
  }

  Widget _body() {
    return GetBuilder<PostFormController>(builder: (ctrl) {
      final state = ctrl.state;
      if (state is PostFormLoading) return _loading();

      return _contentBody();
    });
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _contentBody() {
    return GetBuilder<PostFormController>(builder: (ctrl) {
      return Column(
        children: [
          _inputCustom(
            label: "User ID",
            controller: ctrl.inputUser,
            keyboardType: TextInputType.number,
            listFormat: [
              FilteringTextInputFormatter.allow(RegExp("^[0-9]*")),
            ],
            errorText: ctrl.errorUser,
          ),
          _inputCustom(
            label: "Title",
            controller: ctrl.inputTitle,
            errorText: ctrl.errorTitle,
          ),
          _inputCustom(
            label: "Body",
            isMultiLine: true,
            controller: ctrl.inputBody,
            keyboardType: TextInputType.multiline,
            errorText: ctrl.errorBody,
          ),
        ],
      );
    });
  }

  Widget _inputCustom({
    String label = "",
    bool isMultiLine = false,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? listFormat,
    TextEditingController? controller,
    String? errorText,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        left: 16,
        right: 16,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        autocorrect: false,
        inputFormatters: listFormat,
        controller: controller,
        maxLines: isMultiLine ? null : 1,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 12,
          ),
          errorText: errorText,
        ),
      ),
    );
  }
}
