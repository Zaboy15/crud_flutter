import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:pembelian_kalbe/model/customer_model.dart';
import 'package:pembelian_kalbe/model/product_model.dart';
import 'package:pembelian_kalbe/networking/api_repository.dart';

part 'pembelian_form_event.dart';
part 'pembelian_form_state.dart';

class PembelianFormBloc extends Bloc<PembelianFormEvent, PembelianFormState> {
  PembelianFormBloc() : super(FormPembelianInitial());
  List<ModelCustomer> modelCustomer;
  List<ModelProduct> modelProduct;

  ApiRepository _apiRepository = ApiRepository();

  

  @override
  Stream<PembelianFormState> mapEventToState(
    PembelianFormEvent event,
  ) async* {
    if (event is GetFormPembelian) {
      yield FormPembelianInitial();
      try {
        modelCustomer = await _apiRepository.fetchDataCustomer();
        modelProduct = await _apiRepository.fetchDataProduct();


        yield FormPembelianLoaded(
            modelCustomer,modelProduct);

        Future.delayed(Duration(seconds: 2), () {});
      } on PlatformException {
        yield FormPembelianError("Koneksi Erorr");
      }
    } else if (event is CreatePressed) {
      yield FormPembelianLoading();
      Future.delayed(Duration(seconds: 2), () {});

      try {
        await _apiRepository.submitPembelian(event.data);
        yield CreateInitial();
      } catch (error) {
        yield CreateFailure(error: error.toString());
      }
    } 
    // TODO: implement mapEventToState
  }
}
