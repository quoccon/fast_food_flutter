part of 'address_cubit.dart';

@immutable
abstract class AddressState extends Equatable{}

class AddressInitial extends AddressState {
  @override
  List<Object?> get props => [];
}

class AddressSuccess extends AddressState {
  final List<Address> address;
  AddressSuccess({required this.address});
  @override
  List<Object?> get props => [address];
}

class AddressError extends AddressState {
  final String error;
  AddressError({required this.error});
  @override
  List<Object?> get props => [error];

}
