import '../model/dummy_model.dart';

abstract class DummyState {}
class DummyFoodLoadSuccess extends DummyState {
  final List<SampleModel> listFood;

  DummyFoodLoadSuccess(this.listFood);
}

class DummyFoodLoading extends DummyState {}

class DummyFoodIdle extends DummyState {}

class DummyFoodError extends DummyState {}
