import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/model/Supplier.dart';
import 'package:retail/page/consignment_note/widget/CreateListEmployeeStoreWidget.dart';
import 'package:retail/page/consignment_note/widget/CreateListSupplierWidget.dart';
import '../../controller/ConsignmentNoteController.dart';
import '../../model/ConsignmentNote.dart';
import '../../model/EmployeeStore.dart';

class CreateConsignmentNotePage extends StatefulWidget
{
  const CreateConsignmentNotePage({Key? key}) : super(key: key);

  @override
  _CreateConsignmentNotePageState createState() => _CreateConsignmentNotePageState();

  static _CreateConsignmentNotePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateConsignmentNotePageState? result =
    context.findAncestorStateOfType<_CreateConsignmentNotePageState>();
    return result;
  }
}

class _CreateConsignmentNotePageState extends StateMVC
{
  ConsignmentNoteController? _controller;

  _CreateConsignmentNotePageState() : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

  final _numberController = TextEditingController();
  final _arrivalDateController = TextEditingController();
  late String? _arrivalDate = "Введите дату";
  late bool _forReturn = false;
  late Supplier _supplier;
  late EmployeeStore _employeeStore;

  Supplier getSupplier(){return _supplier;}
  void setSupplier(Supplier supplier){_supplier = supplier;}

  EmployeeStore getEmployeeStore(){return _employeeStore;}
  void setEmployeeStore(EmployeeStore employeeStore){_employeeStore = employeeStore;}

  Future<void> _selectDate(BuildContext context) async
  {
    final DateTime? _dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2022),
        lastDate: DateTime(2050),
    );
    if (_dateTime != null) setState(() {_arrivalDate = DateFormat("yyyy-MM-dd").format(_dateTime);});
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
    return Scaffold(
      appBar: AppBar(title: const Text('Создание накладной')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9\-]")),],
                  decoration: const InputDecoration(labelText: "Номер"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
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
                            style: const TextStyle(fontSize: 14, color: Colors.blue),
                            controller: _arrivalDateController,
                            textInputAction: TextInputAction.next,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          _selectDate(context);
                          _arrivalDateController.text = _arrivalDate!;
                          },
                        icon: const Icon(Icons.calendar_today)
                    ),
                  ],
                ),
                //const SizedBox(height: 20),
                Row(
                  children: [
                    const Text("На возврат", style: TextStyle(fontSize: 14, color: Colors.blue)),
                    Checkbox(
                        value: _forReturn,
                        onChanged: (value) async { setState(() {_forReturn = value!;});}
                        ),
                  ],
                ),
                const Flexible(
                  flex: 1,
                  child: CreateListSupplierWidget(),
                ),
                const Flexible(
                  flex: 1,
                  child: CreateListEmployeeStoreWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    ConsignmentNote _consignmentNote = ConsignmentNote(idConsignmentNote: UniqueKey().hashCode, number: _numberController.text, arrivalDate: DateTime.parse(_arrivalDate!), supplier: getSupplier(), employeeStore: getEmployeeStore(), forReturn: _forReturn);
                    _controller?.addConsignmentNote(_consignmentNote);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is ConsignmentNoteAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Накладная создана")));}
                    if (state is ConsignmentNoteResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is ConsignmentNoteResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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