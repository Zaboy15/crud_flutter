part of 'pembelian_form_bloc.dart';

abstract class PembelianFormState extends Equatable {
  const PembelianFormState();
  
  @override
  List<Object> get props => [];
}

class FormPembelianInitial extends PembelianFormState {}


class FormPembelianError extends PembelianFormState {
  final String message;
  const FormPembelianError(this.message);
  @override 
  List<Object> get props => [message];
}

class FormPembelianLoaded extends PembelianFormState {
  final List<ModelCustomer> modelCustomer;
  final List<ModelProduct> modelProduct;

  const FormPembelianLoaded(this.modelCustomer,this.modelProduct);
  @override 
  List<Object> get props => [modelCustomer];
}


class FormPembelianLoading extends PembelianFormState {
const FormPembelianLoading();
  @override
  List<Object> get props => null;
}


class CreatePembelianError extends PembelianFormState {
  final String message;
  const CreatePembelianError(this.message);
  @override 
  List<Object> get props => [message];
}



class CreateInitial extends PembelianFormState {
const CreateInitial();
  @override
  List<Object> get props => null;
}

class CreateLoading extends PembelianFormState {
const CreateLoading();
  @override
  List<Object> get props => null;
}

class CreateFailure extends PembelianFormState {
  final String error;

  const CreateFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'Data Create Failure { error: $error }';
}
