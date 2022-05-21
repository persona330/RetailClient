import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Communication.dart';
import 'package:retail/service/AddressService.dart';

import '../../controller/CommunicationController.dart';

class CreateCommunicationPage extends StatefulWidget
{
  CreateCommunicationPage({Key? key}) : super(key: key);

  @override
  _CreateCommunicationPageState createState() => _CreateCommunicationPageState();
}

class _CreateCommunicationPageState extends StateMVC
{
  CommunicationController? _controller;

  _CreateCommunicationPageState() : super(CommunicationController()) {_controller = controller as CommunicationController;}

  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

    @override
  void initState()
  {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(title: const Text('Создание средства связи')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.phone,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9+]")),],
                  decoration: const InputDecoration(labelText: "Номер телефона"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _phoneController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9@]"))],
                  decoration: const InputDecoration(labelText: "Электронный адрес"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Communication _communication = Communication(idCommunication: 1, phone: _phoneController.text, email: _emailController.text);
                    _controller?.addCommunication(_communication);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is CommunicationAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is CommunicationResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is CommunicationResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
                  },
                  child: const Text('Отправить'),
                ),
              ],
            ),
          ),
      ),
    );
  }
}