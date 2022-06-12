import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../../controller/PositionController.dart';
import '../../model/Position.dart';

class PutPositionPage extends StatefulWidget
{
  final int id;
  const PutPositionPage({Key? key, required this.id}) : super(key: key);

  @override
  PutPositionPageState createState() => PutPositionPageState(id);
}

class PutPositionPageState extends StateMVC
{
  PositionController? _controller;
  final int _id;

  PutPositionPageState(this._id) : super(PositionController()) {_controller = controller as PositionController;}

  final _nameController = TextEditingController();

  @override
  void initState()
  {
    super.initState();
    _controller?.getPosition(_id);
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    final state = _controller?.currentState;
    if (state is PositionResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is PositionResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _position = (state as PositionGetItemResultSuccess).position;
      _nameController.text = _position.getName!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение должности')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я]")),],
                    decoration: const InputDecoration(labelText: "Название"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Position _position1 = Position(idPosition: _id, name:_nameController.text);
                      _controller?.putPosition(_position1, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is PositionAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Должность изменена")));}
                      if (state is PositionResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is PositionResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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