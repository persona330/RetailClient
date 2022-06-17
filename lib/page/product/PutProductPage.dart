import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/product/widget/PutListPriceWidget.dart';
import '../../controller/ProductController.dart';
import '../../model/Price.dart';
import '../../model/Product.dart';

class PutProductPage extends StatefulWidget
{
  final int id;
  const PutProductPage({Key? key, required this.id}) : super(key: key);

  @override
  PutProductPageState createState() => PutProductPageState(id);

  static PutProductPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutProductPageState? result =
    context.findAncestorStateOfType<PutProductPageState>();
    return result;
  }
}

class PutProductPageState extends StateMVC
{
  ProductController? _controller;
  final int _id;

  PutProductPageState(this._id) : super(ProductController()) {_controller = controller as ProductController;}

  final _mengeAufLagerController = TextEditingController();

  late Price _price;

  Price getPrice(){ return _price;}
  void setPrice(Price price){ _price = price;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getProduct(_id);
  }

  @override
  void dispose()
  {
    _mengeAufLagerController.dispose();
    super.dispose();
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
      _mengeAufLagerController.text = _product.getMengeAufLager!.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение товара')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),],
                    decoration: const InputDecoration(labelText: "Количетсво в наличии"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _mengeAufLagerController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListPriceWidget(),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: ()
                    {
                      Product _product1 = Product(idProduct: _id, mengeAufLager: int.parse(_mengeAufLagerController.text), price: getPrice());
                      _controller?.putProduct(_product1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is ProductPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Товар изменен")));}
                      if (state is ProductResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is ProductResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}

                    },
                    child: const Text('Изменить'),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  }

}