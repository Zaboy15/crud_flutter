part of 'pembelian_list_bloc.dart';

abstract class PembelianListState extends Equatable {
  const PembelianListState();
  
  @override
  List<Object> get props => [];
}

class PembelianListInitial extends PembelianListState {}


class PembelianListLoading extends PembelianListState {
  const PembelianListLoading();
  @override
  List<Object> get props => null;
}

class PembelianListLoaded extends PembelianListState {
  final List<ModelPembelian> pembelian;
  PembelianListLoaded(this.pembelian);
}

class PembelianListNull extends PembelianListState {
  final String message;
  const PembelianListNull(this.message);
  @override
  List<Object> get props => null;
}

class PembelianListError extends PembelianListState {
  final String message;
  const PembelianListError(this.message);
  @override
  List<Object> get props => null;
}
