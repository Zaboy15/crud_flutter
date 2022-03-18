import 'dart:convert';

List<ModelPembelian> modelPembelianFromJson(String str) => List<ModelPembelian>.from(json.decode(str).map((x) => ModelPembelian.fromJson(x)));

String modelPembelianToJson(List<ModelPembelian> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelPembelian {
    ModelPembelian({
        this.intSalesOrderId,
        this.intCustomerId,
        this.intProductId,
        this.customerName,
        this.productName,
        this.dtSalesOrder,
        this.intQty,
    });

    String intSalesOrderId;
    String intCustomerId;
    String intProductId;
    String customerName;
    String productName;
    DateTime dtSalesOrder;
    String intQty;

    factory ModelPembelian.fromJson(Map<String, dynamic> json) => ModelPembelian(
        intSalesOrderId: json["intSalesOrderID"],
        intCustomerId: json["intCustomerID"],
        intProductId: json["intProductID"],
        customerName: json["CustomerName"],
        productName: json["ProductName"],
        dtSalesOrder: DateTime.parse(json["dtSalesOrder"]),
        intQty: json["intQty"],
    );

    Map<String, dynamic> toJson() => {
        "intSalesOrderID": intSalesOrderId,
        "intCustomerID": intCustomerId,
        "intProductID": intProductId,
        "CustomerName": customerName,
        "ProductName": productName,
        "dtSalesOrder": dtSalesOrder.toIso8601String(),
        "intQty": intQty,
    };
}
