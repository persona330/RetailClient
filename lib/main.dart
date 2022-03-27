import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/model/Post.dart';
import 'package:retail/service/AddressService.dart';
import 'package:retail/service/PostServiceTest.dart';

// Запускает главное окно приложения. Принимает виджет.
void main() => runApp(const MyApp());

// Главный класс
// StatelessWidget для неизменяетмых виджетов
class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  // build - для построения интерфейса
  @override
  Widget build(BuildContext context)
  {
    // MaterialApp - для создания графического интерфейса, навигации
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Приложение',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home - задает базовый виджет, отображаемый при загрузке
      home: const MyHomePage(title: 'Адреса'),
    );
  }
}

// StatefulWidget - для изменяемых виджетов
class MyHomePage extends StatefulWidget
{
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
  AddressService addressService = AddressService();
  PostServiceTest postServiceTest = PostServiceTest();

  late Future <List<Address>> _futureAddresses;
  late Future <Address> _futureAddress;
  late Future <Post> _post;
  late Future <List<Post>> _listPost;

  @override
  void initState() {
    super.initState();
    //_listPost = postServiceTest.fetchPost();
    //_post = postServiceTest.getPost();
    //_futureAddress = addressService.getAddress();
    _futureAddresses = addressService.fetchAddresses();
  }

  void _f1() {setState(() {});}

  @override
  Widget build(BuildContext context)
  {
    // Scaffold - заполняет все свободное пространство
    // Нужен для отображения основных виджетов
    return Scaffold(
      // AppBar - верхняя панель
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body - задает основное содержимое
      body: Center(
      child: FutureBuilder<List<Address>>(
        future: _futureAddresses,
        builder: (context, snapshot)
        {/*
          if (snapshot.hasData)
          {
            /*return Text('${snapshot.data!.id_Address} '
                '${snapshot.data!.apartment}  '
                '${snapshot.data!.entrance} '
                '${snapshot.data!.house} '
                '${snapshot.data!.street} '
                '${snapshot.data!.region} '
                '${snapshot.data!.city} '
                '${snapshot.data!.nation}');*/

          } else if(snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }*/
          if(snapshot.hasData) {
            return ListView(
              children: List.generate(snapshot.data!.length, (index) =>
                  Text('${snapshot.data![index].getApartment} '
                      '${snapshot.data![index].getEntrance} '
                      '${snapshot.data![index].getHouse} '
                      '${snapshot.data![index].getStreet} '
                      '${snapshot.data![index].getRegion} '
                      '${snapshot.data![index].getCity} '
                      '${snapshot.data![index].getNation} '
                      '${snapshot.data![index].getIdAddress}')
              ),
            );
          } else if(snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      ),
    );
  }
}
/* Text('${snapshot.data![index].userId} '
                    ' ${snapshot.data![index].id}  '
                    '${snapshot.data![index].title} '
                    '${snapshot.data![index].body} ')*/