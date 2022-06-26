import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/consignment_note/widget/PutListEmployeeStoreWidget.dart';
import 'package:retail/page/consignment_note/widget/PutListSupplierWidget.dart';
import '../../controller/ConsignmentNoteController.dart';
import '../../model/ConsignmentNote.dart';
import '../../model/EmployeeStore.dart';
import '../../model/Supplier.dart';

class PutConsignmentNotePage extends StatefulWidget
{
  final int id;
  const PutConsignmentNotePage({Key? key, required this.id}) : super(key: key);

  @override
  PutConsignmentNotePageState createState() => PutConsignmentNotePageState(id);

  static PutConsignmentNotePageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutConsignmentNotePageState? result =
    context.findAncestorStateOfType<PutConsignmentNotePageState>();
    return result;
  }
}

class PutConsignmentNotePageState extends StateMVC
{
  ConsignmentNoteController? _controller;
  final int _id;

  PutConsignmentNotePageState(this._id) : super(ConsignmentNoteController()) {_controller = controller as ConsignmentNoteController;}

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
    _controller?.getConsignmentNote(_id);
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
    final state = _controller?.currentState;
    if (state is ConsignmentNoteResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ConsignmentNoteResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _consignmentNote = (state as ConsignmentNoteGetItemResultSuccess).consignmentNote;
      _numberController.text = _consignmentNote.getNumber!;
      _arrivalDateController.text = _consignmentNote.getArrivalDate.toString();
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение накладной')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
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
                    child: PutListSupplierWidget(),
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListEmployeeStoreWidget(),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      ConsignmentNote _consignmentNote = ConsignmentNote(idConsignmentNote: _id, number: _numberController.text, arrivalDate: DateTime.parse(_arrivalDate!), supplier: getSupplier(), employeeStore: getEmployeeStore(), forReturn: _forReturn);
                      _controller?.putConsignmentNote(_consignmentNote, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is ConsignmentNotePutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Накладная изменена")));}
                      if (state is ConsignmentNoteResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is ConsignmentNoteResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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