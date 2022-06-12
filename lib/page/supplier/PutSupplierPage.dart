import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/supplier/widget/PutListOrganizationWidget.dart';
import 'package:retail/page/supplier/widget/PutListPositionWidget.dart';
import '../../controller/SupplierController.dart';
import '../../model/Organization.dart';
import '../../model/Position.dart';
import '../../model/Supplier.dart';

class PutSupplierPage extends StatefulWidget
{
  final int id;
  const PutSupplierPage({Key? key, required this.id}) : super(key: key);

  @override
  PutSupplierPageState createState() => PutSupplierPageState(id);

  static PutSupplierPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final PutSupplierPageState? result =
    context.findAncestorStateOfType<PutSupplierPageState>();
    return result;
  }
}

class PutSupplierPageState extends StateMVC
{
  SupplierController? _controller;
  final int _id;

  PutSupplierPageState(this._id) : super(SupplierController()) {_controller = controller as SupplierController;}

  final _nameController = TextEditingController();
  late Position _position;
  late Organization _organization;

  Position getPosition(){return _position;}
  void setPosition(Position position){_position = position;}

  Organization getOrganization(){return _organization;}
  void setOrganization(Organization organization){_organization = organization;}

  @override
  void initState()
  {
    super.initState();
    _controller?.getSupplier(_id);
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
    if (state is SupplierResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SupplierResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _supplier = (state as SupplierGetItemResultSuccess).supplier;
      _nameController.text = _supplier.getName!;
      return Scaffold(
        appBar: AppBar(title: const Text('Изменение поставщика')),
        body: Scrollbar(
          child: Container(
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                    decoration: const InputDecoration(labelText: "Имя"),
                    style: const TextStyle(fontSize: 14, color: Colors.blue),
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                  ),
                  const Flexible(
                    flex: 1,
                    child: PutListPositionWidget(),
                  ),
                  const Flexible(
                    flex: 2,
                    child: PutListOrganizationWidget(),
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {
                      Supplier _supplier = Supplier(idSupplier: _id, name: _nameController.text, position: getPosition(), organization: getOrganization());
                      _controller?.putSupplier(_supplier, _id);
                      Navigator.pop(context, true);
                      final state = _controller?.currentState;
                      if (state is SupplierPutResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Поставщик изменен")));}
                      if (state is SupplierResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                      if (state is SupplierResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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