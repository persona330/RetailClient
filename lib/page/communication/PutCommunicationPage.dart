import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
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
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9+]")),],
                    decoration: const InputDecoration(labelText: "Номер телефона"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _phoneController,
                    textInputAction: TextInputAction.next,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9@._\-]"))],
                    decoration: const InputDecoration(labelText: "Электронный адрес"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Communication _communication1 = Communication(idCommunication: _id, phone: _phoneController.text, email: _emailController.text);
                      _controller?.putCommunication(_communication1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is CommunicationPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Средство связи изменено")));}
                      if (state is CommunicationResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is CommunicationResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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