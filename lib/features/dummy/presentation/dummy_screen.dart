import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/dummy_model.dart';
import 'dummy_controller.dart';
import 'dummy_state.dart';

class DummyScreen extends GetView<DummyController> {
  const DummyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      title: const Text("Food Recipes"),
    );
  }

  Widget _body() {
    return GetBuilder<DummyController>(
      builder: (ctrl) {
        final state = controller.foodState;

        if(state is DummyFoodLoading){
          return _loading();
        }

        if(state is DummyFoodLoadSuccess){
          return _contentBody(state.listFood);
        }

        return Container();
      },
    );
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _contentBody(List<SampleModel> listData) {
    return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        padding: const EdgeInsets.all(8.0),
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: listData.map((food) => _itemFood(food)).toList());
  }

  Widget _itemFood(SampleModel food) {
    return GestureDetector(
      onTap: () {},
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black45,
          title: Text(food.name!),
        ),
        child: Hero(
          tag: food.name!,
          child: Image.network(
            food.image!,
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }
}
