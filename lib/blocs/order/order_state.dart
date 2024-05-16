part of 'order_cubit.dart';

@immutable
abstract class OrderState extends Equatable{}

class OrderInitial extends OrderState {
  @override
  List<Object?> get props => [];
}

class OrderSuccess extends OrderState{
  final List<Order> order;
  OrderSuccess({required this.order});
  @override
  List<Object?> get props => [order];
}

class OrderError extends OrderState{
  final String? error;
  OrderError({required this.error});
  @override
  List<Object?> get props => [error];
}
