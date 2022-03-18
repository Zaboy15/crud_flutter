import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pembelian_kalbe/bloc/bloc/pembelian_form_bloc.dart';
import 'package:pembelian_kalbe/model/customer_model.dart';
import 'package:pembelian_kalbe/model/product_model.dart';
import 'package:pembelian_kalbe/networking/api_repository.dart';
import 'package:pembelian_kalbe/utils/constant.dart';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';



class CreatePembelianForm extends StatefulWidget {
  const CreatePembelianForm({Key key}) : super(key: key);

  @override
  _CreatePembelianFormState createState() => _CreatePembelianFormState();
}

class _CreatePembelianFormState extends State<CreatePembelianForm> {
  ApiRepository _apiRepository = ApiRepository();
  final _key = new GlobalKey<FormState>();
  final PembelianFormBloc _formPembelian = PembelianFormBloc();
  String qty;
  String intCustomerID,intProductId;
  

  TextEditingController txtQty = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _formPembelian.add(GetFormPembelian());
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Form Pembelian",
              style: new TextStyle(
                color: Colors.white,
              )),
          backgroundColor: kPrimaryColor,
          centerTitle: true),
      body: _form(),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _formPembelian,
        child: BlocListener<PembelianFormBloc, PembelianFormState>(
          listener: (context, state) {
            if (state is CreateFailure) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state is CreateInitial) {
              Navigator.pop(context);
            } else if (state is FormPembelianLoaded) {}
          },
          child: BlocBuilder<PembelianFormBloc, PembelianFormState>(
            builder: (context, state) {
              if (state is FormPembelianInitial) {
                return _buildLoading();
              } else if (state is CreateLoading) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is CreateInitial) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is FormPembelianLoaded) {
                return _buildForm(context,state.modelCustomer,state.modelProduct);
              } else if (state is CreatePembelianError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context, List<ModelCustomer> modelCustomer, List<ModelProduct> modelProduct) {
    _onSavePressed() async {

      Map<String, dynamic> data = {
        "intCustomerID": intCustomerID,
        "intProductID": intProductId,
        "intQty": qty,

      };
      print(data);
      BlocProvider.of<PembelianFormBloc>(context).add(CreatePressed(data: data));
    }

    return Form(
      key: _key,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomSearchableDropDown(
              menuMode: false,
              items: modelCustomer,
              label: 'Nama Customer',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text("Nama Customer   : "),
              ),
              dropDownMenuItems: modelCustomer.map((item) {
                    return item.txtCustomerName;
                  })?.toList() ??
                  [],
              onChanged: (value) {
                if (value != null) {
                  print(value.intCustomerId);
                  setState(() {
                    intCustomerID = value.intCustomerId.toString();
                  });
                } else {
                  print(value);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomSearchableDropDown(
              menuMode: false,
              items: modelProduct,
              label: 'Nama Product',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text("Nama Product   : "),
              ),
              dropDownMenuItems: modelProduct.map((item) {
                    return item.txtProductName;
                  })?.toList() ??
                  [],
              onChanged: (value) {
                if (value != null) {
                  print(value);
                  setState(() {
                    intProductId = value.intProductId.toString();
                  });
                } else {
                  print(value);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextFormField(
              maxLines: 1,
              controller: txtQty,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: const Icon(Icons.announcement),
                hintText: 'Qty',
                labelText: 'Qty',
              ),
              validator: (val) =>
                  val.isEmpty ? 'Qty is required' : null,
              onSaved: (val) => qty = val,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                    height: 45,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: kPrimaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          final form = _key.currentState;
                          if (form.validate()) {
                            form.save();
                            _onSavePressed();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Data Belum Lengkap')),
                            );
                          }
                        },
                        child: Text("Simpan",
                            style: new TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
