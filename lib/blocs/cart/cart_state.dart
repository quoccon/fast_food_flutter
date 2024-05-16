part of 'cart_cubit.dart';

@immutable
abstract class CartState extends Equatable{}

class CartInitial extends CartState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CartSuccess extends CartState{
  final List<Cart> cart;
  CartSuccess({required this.cart});
  @override
  List<Object?> get props => [cart];

}

class CartError extends CartState {
  final String error;

  CartError({required this.error});
  @override
  List<Object?> get props => [error];

}