part of 'product_cubit.dart';

@immutable
abstract class ProductState extends Equatable{}

class ProductInitial extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductLoading extends ProductState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProductSuccess extends ProductState {
  final List<Product> product;
  ProductSuccess({required this.product});
  @override
  List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String error;
  ProductError ({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
