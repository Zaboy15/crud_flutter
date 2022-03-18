import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:pembelian_kalbe/model/pembelian_model.dart';
import 'package:pembelian_kalbe/networking/api_repository.dart';

part 'pembelian_list_event.dart';
part 'pembelian_list_state.dart';

class PembelianListBloc extends Bloc<PembelianListEvent, PembelianListState> {
  PembelianListBloc() : super(PembelianListInitial());
  ApiRepository _apiRepository = ApiRepository();
  List<ModelPembelian> pembelianModel;

  @override
  Stream<PembelianListState> mapEventToState(PembelianListEvent event) async* {
    if (event is GetPembelianList) {
      try {
        yield PembelianListLoading();
        pembelianModel = await _apiRepository.fetchDataPembelian();
        print(pembelianModel);
        if(pembelianModel.isEmpty){
          yield PembelianListNull("Data Kosong");
        } else {
          yield PembelianListLoaded(pembelianModel);
        }
      } on PlatformException {
        yield PembelianListError("Gagal Fetch Data , Pastikan anda terkoneksi internet");
      }
    }
  }
}
