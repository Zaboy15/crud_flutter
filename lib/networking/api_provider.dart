import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pembelian_kalbe/model/customer_model.dart';
import 'package:pembelian_kalbe/model/pembelian_model.dart';
import 'package:pembelian_kalbe/model/product_model.dart';

class ApiProvider {
  Dio _dio = Dio();

  static String mainurl = "https://anak-it.com/backend_kalbe/api/api";
  static const String _GET_PEMBELIAN = '/getPembelian.php';
  static const String _GET_CUSTOMER = '/getCustomer.php';
  static const String _GET_PRODUCT = '/getProduct.php';
  static const String _ADD_PEMBELIAN = '/addPembelian.php';


  Future<List<ModelPembelian>> fetchDataPembelian() async {
    try {
      // var token = await storage.FlutterSecureStorage().read(key: 'token');
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      Uri uri = Uri.parse(mainurl + _GET_PEMBELIAN);
      http.Response response = await http.get(uri);
      print(response);

      List<ModelPembelian> data = modelPembelianFromJson(response.body);
      return data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<ModelCustomer>> fetchDataCustomer() async {
    try {
      // var token = await storage.FlutterSecureStorage().read(key: 'token');
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      Uri uri = Uri.parse(mainurl + _GET_CUSTOMER);
      http.Response response = await http.get(uri);
      print(response);

      List<ModelCustomer> data = modelCustomerFromJson(response.body);
      return data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  Future<List<ModelProduct>> fetchDataProduct() async {
    try {
      // var token = await storage.FlutterSecureStorage().read(key: 'token');
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      Uri uri = Uri.parse(mainurl + _GET_PRODUCT);
      http.Response response = await http.get(uri);
      print(response);

      List<ModelProduct> data = modelProductFromJson(response.body);
      return data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  submitPembelian(Map data) async {
    try {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };

      Uri uri = Uri.parse(mainurl + _ADD_PEMBELIAN);

      var body = json.encode(data);
      // http.Response response = await http.post(uri,
      //     body: body);
      // print(response.body);

      final response = await http.post(uri, body: {
      "intCustomerID": data['intCustomerID'],
        "intProductID":  data['intProductID'],
        "intQty":  data['intQty'],
    });
      print(response.body);

      return data;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
