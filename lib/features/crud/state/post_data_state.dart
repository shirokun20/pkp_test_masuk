import '../model/post_data_model.dart';

abstract class PostDataState {}
class PostDataLoadSuccess extends PostDataState {
  final List<PostDataModel> listData;

  PostDataLoadSuccess(this.listData);
}

class PostDataLoading extends PostDataState {}

class PostDataIdle extends PostDataState {}

class PostDataError extends PostDataState {}
