import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';

import '../../controller/ConsignmentNoteController.dart';
import '../../model/ConsignmentNote.dart';
import '../../service/ConsignmentNoteService.dart';

class CreateConsignmentNotePage extends StatefulWidget
{
  CreateConsignmentNotePage({Key? key}) : super(key: key);

  @override
  _CreateConsignmentNotePageState createState() => _CreateConsignmentNotePageState();
}

class _CreateConsignmentNotePageState extends StateMVC
{
  ConsignmentNoteController? _controller;

  _CreateConsignmentNotePageState() : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

  final _numberController = TextEditingController();
  final _arrivalDateController = TextEditingController();
  late String? _arrivalDate = "Введите дату";
  late bool _forReturn = false;
  List<String> _supplerList = ["Поставщик 1", "Поставщик 2", "Поставщик 3"];
  List<String> _employeeStoreList = ["Сотрудник склада 1", "Сотрудник склада 2", "Сотрудник склада 3"];
  late String _suppler = _supplerList[0];
  late String _employeeStore = _employeeStoreList[0];

  Future<void> _selectDate(BuildContext context) async
  {
    final DateTime? _dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050),
    );
    if (_dateTime != null) setState(() {_arrivalDate = DateFormat("dd-MM-yyyy").format(_dateTime);});
  }

    @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _numberController.dispose();
    _arrivalDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание накладной')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Номер"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _numberController,
                  textInputAction: TextInputAction.next,
                ),
                Row(
                  children: [
                    Expanded(child:
                      TextFormField(
                            keyboardType: TextInputType.datetime,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9\-:]")),],
                            decoration: const InputDecoration(labelText: "Дата прибытия"),
                            style: TextStyle(fontSize: 14, color: Colors.blue),
                            controller: _arrivalDateController,
                            textInputAction: TextInputAction.next,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                          _arrivalDateController.text = _arrivalDate!;
                          },
                        icon: Icon(Icons.calendar_today)
                    ),
                  ],
                ),
                //const SizedBox(height: 20),
                Row(
                  children: [
                    Text("На возврат", style: TextStyle(fontSize: 14, color: Colors.blue)),
                    Checkbox(
                        value: _forReturn,
                        onChanged: (value) async { setState(() {_forReturn = value!;});}
                        ),
                  ],
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Поставщик",),
                    items: _supplerList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {_suppler = item!;});
                    }
                ),
                DropdownButtonFormField(
                    isExpanded: true,
                    decoration: InputDecoration(labelText: "Сотрудник склада",),
                    items: _employeeStoreList.map((String items){
                      return DropdownMenuItem(
                        child: Text(items.toString()),
                        value: items,
                      );
                    }).toList(),
                    onChanged: (String? item)
                    {
                      setState(() {_employeeStore = item!;});
                    }
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    //ConsignmentNote _consignmentNote = ConsignmentNote(idConsignmentNote: 1, number: "2", arrivalDate: DateTime.parse(arrivalDate!), );
                    //_controller?.addConsignmentNote(_address);
                    //Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is ConsignmentNoteAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is ConsignmentNoteResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is ConsignmentNoteResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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