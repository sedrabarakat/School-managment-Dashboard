part of 'articles_cubit.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}


class PickImage extends ArticlesState {}

class Loading extends ArticlesState {}

class Success extends ArticlesState {}

class Error extends ArticlesState {}
