import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Price.dart';
import 'package:retail/page/product/widget/CreateListPriceWidget.dart';
import '../../controller/ProductController.dart';
import '../../model/Product.dart';

class CreateProductPage extends StatefulWidget
{
  const CreateProductPage({Key? key}) : super(key: key);

  @override
  _CreateProductPageState createState() => _CreateProductPageState();

  static _CreateProductPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateProductPageState? result =
    context.findAncestorStateOfType<_CreateProductPageState>();
    return result;
  }
}

class _CreateProductPageState extends StateMVC
{
  ProductController? _controller;

  _CreateProductPageState() : super(ProductController()) {_controller = controller as ProductController;}

  final _mengeAufLagerController = TextEditingController();

  late Price _price;

  Price getPrice(){ return _price;}
  void setPrice(Price price){ _price = price;}

    @override
  void initState()
  {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Создание товара')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
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
                  child: CreateListPriceWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Product _product = Product(idProduct: UniqueKey().hashCode, mengeAufLager: int.parse(_mengeAufLagerController.text), price: getPrice());
                    _controller?.addProduct(_product);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is ProductAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Товар создан")));}
                    if (state is ProductResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is ProductResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Создать'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}