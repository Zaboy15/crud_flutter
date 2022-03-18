import 'dart:convert';

List<ModelCustomer> modelCustomerFromJson(String str) => List<ModelCustomer>.from(json.decode(str).map((x) => ModelCustomer.fromJson(x)));

String modelCustomerToJson(List<ModelCustomer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelCustomer {
    ModelCustomer({
        this.intCustomerId,
        this.txtCustomerName,
        this.txtCustomerAddress,
    });

    String intCustomerId;
    String txtCustomerName;
    String txtCustomerAddress;

    factory ModelCustomer.fromJson(Map<String, dynamic> json) => ModelCustomer(
        intCustomerId: json["intCustomerID"],
        txtCustomerName: json["txtCustomerName"],
        txtCustomerAddress: json["txtCustomerAddress"],
    );

    Map<String, dynamic> toJson() => {
        "intCustomerID": intCustomerId,
        "txtCustomerName": txtCustomerName,
        "txtCustomerAddress": txtCustomerAddress,
    };
}
