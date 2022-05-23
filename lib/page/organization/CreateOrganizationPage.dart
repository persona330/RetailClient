import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/model/Address.dart';
import '../../controller/OrganizationController.dart';
import '../../model/Communication.dart';
import '../../model/Organization.dart';

class CreateOrganizationPage extends StatefulWidget
{
  CreateOrganizationPage({Key? key}) : super(key: key);

  @override
  _CreateOrganizationPageState createState() => _CreateOrganizationPageState();
}

class _CreateOrganizationPageState extends StateMVC
{
  OrganizationController? _controller;

  _CreateOrganizationPageState() : super(OrganizationController()) {_controller = controller as OrganizationController;}

  final _nameController = TextEditingController();
  final _innController = TextEditingController();
  final _kppController = TextEditingController();
  AddressController _addressController = AddressController();

  Address address1 = Address(idAddress: 1, apartment: "5", entrance: 1, house: "107a", street: "Карла Маркса", region: "Курганский", city: "Курган", nation: "Россия");
  Address address2 = Address(idAddress: 2, apartment: "1", entrance: 0, house: "30", street: "Гоголя", region: "Курганский", city: "Юргамыш", nation: "Россия");
  Communication communication1 = Communication(idCommunication: 1, phone: "89128377496", email: "email@gmail.com");
  Communication communication2 = Communication(idCommunication: 2, phone: "89128377496", email: "email@ya.ru");
  //late List<Address> addressList = [address1, address2];
  late List<Address> addressList = (_addressController.state as AddressGetListResultSuccess).addressList;
  late List<Communication> communicationList = [communication1, communication2];
  late Address address = addressList[0];
  late Communication communication = communicationList[0];

  @override
  void initState()
  {
    //_addressController.getAddresses();
    super.initState();
  }

  @override
  void dispose()
  {
    _nameController.dispose();
    _innController.dispose();
    _kppController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {

    return Scaffold(
      appBar: AppBar(title: const Text('Создание организации')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Название"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Номер ИНН"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _innController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Номер КПП"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _kppController,
                  textInputAction: TextInputAction.next,
                ),
                DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(labelText: "Адрес",),
                      items: addressList.map((Address items){
                        return DropdownMenuItem(
                          child: Text(items.toString()),
                          value: items,
                        );
                      }).toList(),
                      onChanged: (Address? item)
                      {
                        setState(() {address = item!;});
                      }
                      ),
                  DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(labelText: "Средство связи",),
                      items: communicationList.map((Communication items){
                        return DropdownMenuItem(
                          child: Text(items.toString()),
                          value: items,
                        );
                      }).toList(),
                      onChanged: (Communication? item)
                      {
                        setState(() {communication = item!;});
                      }
                  ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    Organization organization = Organization(idOrganization: UniqueKey().hashCode, name: _nameController.text, address: address, communication: communication, inn: _innController.text, kpp: _kppController.text);
                    print(organization.toString());
                    _controller?.addOrganization(organization);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is OrganizationAddResultSuccess)
                    {
                      print("Все ок");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Добавлен")));
                    }
                    if (state is OrganizationResultLoading)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Загрузка")));
                    }
                    if (state is OrganizationResultFailure) {ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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