import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/ProductController.dart';
import '../../model/Product.dart';
import 'DeleteProductPage.dart';
import 'PutProductPage.dart';

class GetProductPage extends StatefulWidget
{
  final int id;
  const GetProductPage({Key? key, required this.id}) : super(key: key);

  @override
  GetProductPageState createState() => GetProductPageState(id);
}

class GetProductPageState extends StateMVC
{
  ProductController? _controller;
  final int _id;

  GetProductPageState(this._id) : super(ProductController()) {_controller = controller as ProductController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getProduct(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutProductPage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeleteProductPage(_id)));
        if (value == true)
        {
          _controller?.deleteProduct(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Продукт удален")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is ProductResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProductResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _product = (state as ProductGetItemResultSuccess).product;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о товаре №$_id"),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: _handleClick, // функция при нажатии
                itemBuilder: (BuildContext context)
                {
                  return {'Изменить', 'Удалить'}.map((String choice)
                  {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: Scrollbar(
            child: Container(
              // this.left, this.top, this.right, this.bottom
              padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
              child: Column (
                children: [
                  Text("Количество в наличии: ${_product.getMengeAufLager} \n"
                      "Цена: ${_product.getPrice}"
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}