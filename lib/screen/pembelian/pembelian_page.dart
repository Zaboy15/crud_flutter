import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pembelian_kalbe/bloc/pembelian_list/pembelian_list_bloc.dart';
import 'package:pembelian_kalbe/model/pembelian_model.dart';
import 'package:pembelian_kalbe/screen/pembelian/pembelian_form.dart';
import 'package:pembelian_kalbe/utils/constant.dart';
import 'package:pembelian_kalbe/utils/empty.dart';

class PembelianListPage extends StatefulWidget {
  const PembelianListPage({Key key}) : super(key: key);

  @override
  _PembelianListPageState createState() => _PembelianListPageState();
}

class _PembelianListPageState extends State<PembelianListPage>
    with TickerProviderStateMixin {
  final PembelianListBloc _pembelianListBloc = PembelianListBloc();
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    super.initState();
    _pembelianListBloc.add(GetPembelianList());

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _buttonColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));

    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
  }

  void animate() {
    if (!isOpened)
      _animationController.forward();
    else
      _animationController.reverse();
    isOpened = !isOpened;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pembelian List"),
        backgroundColor: kPrimaryColor,
      ),
      body: _buildList(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 3.0, 0.0),
            child: buttonAdd(),
          ),
          buttonToggle()
        ],
      ),
    );
  }

  Widget buttonAdd() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CreatePembelianForm()));
        },
        tooltip: "Tambah Pembelian",
        child: Icon(Icons.add),
      ),
    );
  }

  Widget buttonEdit() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          print("Button Edit Click");
        },
        tooltip: "Edit",
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget buttonDelete() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          print("Button Delete Click");
        },
        tooltip: "Delete",
        child: Icon(Icons.delete),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: "Toggle",
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildList() {
    return Container(
        margin: EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => _pembelianListBloc,
          child: BlocListener<PembelianListBloc, PembelianListState>(
            listener: (context, state) {
              if (state is PembelianListError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            child: BlocBuilder<PembelianListBloc, PembelianListState>(
                builder: (context, state) {
              if (state is PembelianListInitial) {
                return _buildLoading();
              } else if (state is PembelianListLoading) {
                return _buildLoading();
              } else if (state is PembelianListLoaded) {
                List<ModelPembelian> modelData = state.pembelian;
                return RefreshIndicator(
                    child: _buildCard(modelData),
                    onRefresh: () async {
                      BlocProvider.of<PembelianListBloc>(context)
                          .add(GetPembelianList());
                    });
              } else if (state is PembelianListNull) {
                return NoData();
              } else if (state is PembelianListError) {
                return Container();
              }
            }),
          ),
        ));
  }

  Widget _buildCard(List<ModelPembelian> modelPembelian) {
    return ListView.builder(
      itemCount: modelPembelian.length,
      itemBuilder: (context, index) {
        ModelPembelian modelData = modelPembelian[index];
        return Container(
          margin: EdgeInsets.all(8),
          child: Card(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Informasi Pembelian : ',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.black38),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'ID Pembelian',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              '${modelData.intSalesOrderId}' ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH4,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Nama Customer',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              '${modelData.customerName}' ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH4,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Product Pembelian',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              '${modelData.productName}' ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH4,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'QTY',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            Text(
                              '${modelData.intQty}' ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        sizedBoxH4,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
