import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/page/CresteAddressPage.dart';
import 'package:retail/page/GetAddressPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';

// StatefulWidget - для изменяемых виджетов
class HomePage extends StatefulWidget
{
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

// Домашняя страница
class _HomePageState extends State<HomePage>
{
  final AddressService _addressService = AddressService();

  late Future <List<Address>> _futureAddresses;
  late Future <Address> _futureAddress;

  final _idAddressController = TextEditingController();

  late String _idAddress = "0";

  _changeIdAddress() { setState(() => _idAddress = _idAddressController.text); }

  @override
  void initState()
  {
    super.initState();
    //_futureAddress = _addressService.getAddress(int.parse(_idAddress));
    _futureAddresses = _addressService.getAddresses();
    _idAddressController.addListener(_changeIdAddress);
  }

  @override
  void dispose()
  {
    _idAddressController.dispose();
    super.dispose();
  }

  // Вызывает перестроение виджета при изменении состояния через функцию build() в классе состояния
  void _f1() {setState(() {});}

  void _handleClick(String value)
  {
    switch (value)
    {
      case 'Создать':
        Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAddressPage()));
        break;
      case 'Изменить':
        break;
      case 'Найти':
        Navigator.push(context, MaterialPageRoute(builder: (context) => GetAddressPage()));
        break;
      case 'Удалить':
        break;
    }
  }

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _handleClick, // функция при нажатии
            itemBuilder: (BuildContext context)
            {
              return {'Создать', 'Изменить', 'Найти', 'Удалить'}.map((String choice)
              {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
      // body - задает основное содержимое
      body:
          Column(
            children: [
              Container(
                // this.left, this.top, this.right, this.bottom
                padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
                child: Row(
                  children: [
                    Expanded(
                      child:
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            labelText: "Введите ID адреса"),
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                        controller: _idAddressController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {
                        //var _idInt = int.parse(_idAddress);
                        //assert(_idInt is int);
                        //_addressService.getAddress(_idInt);
                      },
                      child: const Text('Найти'),
                    ),
                  ],
                ),
              ),
              Expanded(
                child:
                Center(
                  child: FutureBuilder<List<Address>>(
                    future: _futureAddresses,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var apartment = snapshot.data![index].getApartment;
                              var entrance = snapshot.data![index].getEntrance;
                              var house = snapshot.data![index].getHouse;
                              var street = snapshot.data![index].getStreet;
                              var region = snapshot.data![index].getRegion;
                              var city = snapshot.data![index].getCity;
                              var nation = snapshot.data![index].getNation;
                              var id = snapshot.data![index].getIdAddress;
                              return Card(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.green.shade300),
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: ListTile(
                                  leading: Text(
                                    nation.toString(),
                                  ),
                                  title: Text('$city'),
                                  subtitle: Text(
                                    'Квартира: $apartment\n'
                                        ' Подъезд: $entrance\n'
                                        ' Дом: $house\n'
                                        ' Улица: $street\n'
                                        ' Регион: $region\n',
                                  ),
                                  trailing: Text('$id'),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          )
        ,
        floatingActionButton: FloatingActionButton(
        onPressed: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAddressPage()));
      },
      tooltip: 'Создать адрес',
      child: const Icon(Icons.add),
      ),
    );
  }
}