part of 'pembelian_form_bloc.dart';

abstract class PembelianFormEvent extends Equatable {
  const PembelianFormEvent();

  @override
  List<Object> get props => [];
}



class GetFormPembelian extends PembelianFormEvent {
  @override
  List<Object> get props => null;
}
class CreatePressed extends PembelianFormEvent {
  final Map data;

  const CreatePressed({
     this.data,
  });

  @override
  List<Object> get props => [data];

  @override
  String toString() =>
      'CreateData { $data}';
}