import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/config/app_route.dart';
import '../../../../components/util/helper.dart';
import '../../model/post_argument_model.dart';
import '../../model/post_data_model.dart';
import '../../state/post_data_state.dart';
import 'post_data_controller.dart';

class PostDataScreen extends GetView<PostDataController> {
  const PostDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(child: _body()),
      floatingActionButton: _floattingBtn(),
    );
  }

  Widget _floattingBtn() {
    return FloatingActionButton(
      onPressed: () => Get.toNamed(
        AppRoute.postForm,
        arguments: PostArgumentModel(
          titleAppBar: "Tambah Post",
          action: "add",
        ),
      ),
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(1000),
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Posts"),
    );
  }

  Widget _body() {
    return GetBuilder<PostDataController>(
      builder: (ctrl) {
        final state = controller.state;

        if (state is PostDataLoading) return _loading();

        if (state is PostDataLoadSuccess) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(0.5.seconds);
              ctrl.onRefresh();
            },
            color: Colors.red,
            child: _contentBody(
              state.listData,
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _contentBody(List<PostDataModel> listData) {
    List<Widget> output = [];

    for (var e in listData) {
      output.add(
        _contentItem(
          e,
          onTapCard: () {},
          onTapDelete: () {
            AlertModel.showDelete(onTapDelete: () {
              Get.back();
              controller.onDeletePost(e.id!);
            });
          },
          onTapEdit: () => Get.toNamed(
            AppRoute.postForm,
            arguments: PostArgumentModel(
              titleAppBar: "Edit Post",
              action: "edit",
              data: e,
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: output,
      ),
    );
  }

  Widget _contentItem(
    PostDataModel data, {
    void Function()? onTapCard,
    void Function()? onTapDelete,
    void Function()? onTapEdit,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(5),
              onTap: onTapCard,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${data.title}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${data.body}",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      children: [
                        _iconButton(
                          icon: Icons.edit,
                          onTap: onTapEdit,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        _iconButton(
                          icon: Icons.delete,
                          onTap: onTapDelete,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          height: 1,
          width: double.infinity,
          color: Colors.grey.withOpacity(0.3),
        )
      ],
    );
  }

  Widget _iconButton({
    required IconData icon,
    void Function()? onTap,
    Color color = Colors.red,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(1000),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Icon(
                icon,
                size: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
