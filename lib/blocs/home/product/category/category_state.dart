part of 'category_cubit.dart';

@immutable
abstract class CategoryState extends Equatable{}

class CategoryInitial extends CategoryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CatLoading extends CategoryState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CatSuccess extends CategoryState {
  final List<Category> category;
  CatSuccess({required this.category});

  @override
  List<Object?> get props => [category];
}

class CatError extends CategoryState {
  final String error;
  CatError({required this.error});
  @override
  List<Object?> get props => [error];
}
