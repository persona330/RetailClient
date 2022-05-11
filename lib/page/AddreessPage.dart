import 'package:flutter/material.dart';
import 'package:retail/controller/PostController.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/page/CresteAddressPage.dart';
import 'package:retail/page/GetAddressPage.dart';
import 'package:retail/page/ShowAddressPage.dart';
import 'package:retail/service/AddressService.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/service/PostService.dart';

// StatefulWidget - для изменяемых виджетов
class AddressPage extends StatefulWidget
{
  const AddressPage({Key? key}) : super(key: key);

  //final String title;

  @override
  _AddressPageState createState() => _AddressPageState();
}

// Домашняя страница
class _AddressPageState extends State<AddressPage>
{

  final AddressService _addressService = AddressService();
  final PostService _postService = PostService();

  late Future <List<Address>> _futureAddresses;
  late Future <Address> _futureAddress;
  late Future <List<Post>> _futurePost;

  final _idAddressController = TextEditingController();
  final _idPostController = TextEditingController();

  late String _idAddress = "0";
  late String _idPost = "0";
  late int _idPost1 = 0;
  late String _bodyPost = "";
  var items = <int>[];

  //_changeIdAddress() { setState(() => _idAddress = _idAddressController.text); }
  _changeIdPost() { setState(() => _idPost = _idPostController.text); }

  @override
  void initState()
  {
    super.initState();
    items.add(_idPost1);
    //_futureAddress = _addressService.getAddress(int.parse(_idAddress));
    //_futureAddresses = _addressService.getAddresses();
    //_idAddressController.addListener(_changeIdAddress);
    _idPostController.addListener(_changeIdPost);
    _futurePost = _postService.getPosts();
  }

  @override
  void dispose()
  {
    //_idAddressController.dispose();
    _idPostController.dispose();
    super.dispose();
  }

  // Вызывает перестроение виджета при изменении состояния через функцию build() в классе состояния
  void _f1() {setState(() {});}

  void _handleClickAddress()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAddressPage(id: _idPost1, body: _bodyPost)));
  }

  void _searchItem(int id)
  {
    if(id != 0)
    {
      return;
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
        title: Text("Адреса"),
        leading: IconButton(icon:Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
                onPressed: () => {
                  print("Click on settings button")
                }
                ),
        ],
      ),
      // body - задает основное содержимое
      body:
          Column(
            children: [
              Container(
                // this.left, this.top, this.right, this.bottom
                padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  onChanged: (value) {_searchItem(int.parse(value));},
                  controller: _idPostController,
                  decoration: const InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))
                  ),
                ),
              ),
              Expanded(
                child:
                Center(
                  child: FutureBuilder<List<Post>>(
                    future: _futurePost,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            shrinkWrap: true, ///
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var id = snapshot.data![index].getid;
                              var userId = snapshot.data![index].getuserId;
                              var title = snapshot.data![index].gettitle;
                              var body = snapshot.data![index].getbody;
                              /*var apartment = snapshot.data![index].getApartment;
                              var entrance = snapshot.data![index].getEntrance;
                              var house = snapshot.data![index].getHouse;
                              var street = snapshot.data![index].getStreet;
                              var region = snapshot.data![index].getRegion;
                              var city = snapshot.data![index].getCity;
                              var nation = snapshot.data![index].getNation;
                              var id = snapshot.data![index].getIdAddress;*/
                              return GestureDetector(
                                  onTap: ()
                                  {
                                    _handleClickAddress();
                                    _idPost1 = id!;
                                    _bodyPost = body!;
                                  },
                                  child: Card(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.green.shade300),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    leading: Text(
                                      userId.toString(),
                                    ),
                                    title: Text('$title'),
                                    subtitle: Text(
                                      'Тело: $body\n'
                                    ),
                                    /*subtitle: Text(
                                      'Квартира: $apartment\n'
                                          ' Подъезд: $entrance\n'
                                          ' Дом: $house\n'
                                          ' Улица: $street\n'
                                          ' Регион: $region\n',
                                    ),*/
                                    trailing: Text('$id'),
                                  ),
                                ),);
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