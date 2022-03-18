

import 'package:pembelian_kalbe/model/customer_model.dart';
import 'package:pembelian_kalbe/model/pembelian_model.dart';
import 'package:pembelian_kalbe/model/product_model.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<List<ModelPembelian>> fetchDataPembelian() {
    return _provider.fetchDataPembelian();
  }

  Future<List<ModelCustomer>> fetchDataCustomer() {
    return _provider.fetchDataCustomer();
  }

  Future<List<ModelProduct>> fetchDataProduct() {
    return _provider.fetchDataProduct();
  }

  Future submitPembelian(Map data) {
    return _provider.submitPembelian(data);
  }
}
