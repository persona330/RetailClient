import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';

import '../../controller/CommunicationController.dart';
import '../../model/Communication.dart';

class PutCommunicationPage extends StatefulWidget
{
  final int id;
  const PutCommunicationPage({Key? key, required this.id}) : super(key: key);

  @override
  PutCommunicationPageState createState() => PutCommunicationPageState(id);
}

class PutCommunicationPageState extends StateMVC
{
  CommunicationController? _controller;
  final int _id;

  PutCommunicationPageState(this._id) : super(CommunicationController()) {_controller = controller as CommunicationController;}

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();


  @override
  void initState()
  {
    super.initState();
    _controller?.getCommunication(_id);
  }

  @override
  void dispose()
  {
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is CommunicationResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is CommunicationResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _communication = (state as CommunicationGetItemResultSuccess).communication;
      _phoneController.text = _communication.getPhone!;
      _emailController.text = _communication.getEmail!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение адреса')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r"[a-zA-Zа-яА-Я0-9]")),
                    ],
                    decoration: const InputDecoration(
                        labelText: "Номер телефона"),
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        labelText: "Электронный адрес"),
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Communication _communication1 = Communication(idCommunication: 1, phone: _phoneController.text, email: _emailController.text);
                      _controller?.putCommunication(_communication1, _id);
                      Navigator.pop(context, true);
                      if (state is CommunicationAddResultSuccess) {
                        print("Все ок");
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Добавлен")));
                      }
                      if (state is CommunicationResultLoading) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Загрузка")));
                      }
                      if (state is CommunicationResultFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(
                                "Произошла ошибка при добавлении поста")));
                      }
                    },
                    child: const Text('Отправить'),
                  ),
                ]
            ),
          ),
        ),
      );
    }
  }

}