import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/supplier/widget/CreateListOrganizationWidget.dart';
import 'package:retail/page/supplier/widget/CreateListPositionWidget.dart';
import '../../controller/SupplierController.dart';
import '../../model/Organization.dart';
import '../../model/Position.dart';
import '../../model/Supplier.dart';

class CreateSupplierPage extends StatefulWidget
{
  const CreateSupplierPage({Key? key}) : super(key: key);

  @override
  _CreateSupplierPageState createState() => _CreateSupplierPageState();

  static _CreateSupplierPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateSupplierPageState? result =
    context.findAncestorStateOfType<_CreateSupplierPageState>();
    return result;
  }
}

class _CreateSupplierPageState extends StateMVC
{
  SupplierController? _controller;

  _CreateSupplierPageState() : super(SupplierController()) {_controller = controller as SupplierController;}

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
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      appBar: AppBar(title: const Text('Создание поставщика')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
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
                  child: CreateListPositionWidget(),
                ),
                const Flexible(
                  flex: 2,
                  child: CreateListOrganizationWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Supplier _supplier = Supplier(idSupplier: UniqueKey().hashCode, name: _nameController.text, position: getPosition(), organization: getOrganization());
                    _controller?.addSupplier(_supplier);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is SupplierAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Поставщик создан")));}
                    if (state is SupplierResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is SupplierResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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