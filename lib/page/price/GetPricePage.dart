import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'DeletePricePage.dart';
import '../../controller/PriceController.dart';
import '../../model/Price.dart';
import 'PutPricePage.dart';

class GetPricePage extends StatefulWidget
{
  final int id;
  const GetPricePage({Key? key, required this.id}) : super(key: key);

  @override
  GetPricePageState createState() => GetPricePageState(id);
}

class GetPricePageState extends StateMVC
{
  PriceController? _controller;
  final int _id;

  GetPricePageState(this._id) : super(PriceController()) {_controller = controller as PriceController;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getPrice(_id);
  }

  void _handleClick(String value) async
  {
    switch (value)
    {
      case 'Изменить':
        Navigator.push(context, MaterialPageRoute(builder: (context) => PutPricePage(id: _id)));
        break;
      case 'Удалить':
        bool value = await Navigator.push(context, PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, _, __)=> DeletePricePage(_id)));
        if (value == true)
        {
          _controller?.deletePrice(_id);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Цена удалена")));
          Navigator.of(context).pop();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is PriceResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PriceResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _price = (state as PriceGetItemResultSuccess).price;
      return Scaffold(
          appBar: AppBar(
            title: Text("Информация о цене №$_id"),
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
                  Text("Количество: ${_price.getQuantity} \n"
                      "Единица измерения: ${_price.getMeasurement.toString()}"
                      , style: const TextStyle(fontSize: 22)),
                ],
              ),
            ),
          ),
      );
    }
  }
}