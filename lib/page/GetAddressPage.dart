import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:retail/model/Address.dart';
import 'package:retail/service/AddressService.dart';

class GetAddressPage extends StatefulWidget
{
  const GetAddressPage({Key? key}) : super(key: key);

  @override
  State<GetAddressPage> createState() => _GetAddressPageState();
}

class _GetAddressPageState extends State<GetAddressPage>
{
  final AddressService _addressService = AddressService();

  final _idAddressController = TextEditingController();

  late Future <Address> _futureAddress;

  String _idAddress = "1";

  _changeIdAddress() { setState(() => _idAddress = _idAddressController.text); }

  @override
  void initState()
  {
    super.initState();
    _idAddressController.addListener(_changeIdAddress);
    _futureAddress = _addressService.getAddress(1);
  }

  @override
  void dispose()
  {
    _idAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(title: const Text('Поиск адреса')),
        body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
            padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                Text("Адрес: ", style: TextStyle(fontSize: 14)),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "ID адреса"),
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _idAddressController,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    _futureAddress = _addressService.getAddress(int.parse(_idAddress)));
                  },
                  child: const Text('Найти'),
                ),
                Expanded(
                  child:
                  Center(
                    child: FutureBuilder<Address>(
                      future: _futureAddress,
                      builder: (context, snapshot)
                      {
                        if(snapshot.hasData)
                        {
                          return Text('${snapshot.data!.getIdAddress} '
                              '${snapshot.data!.getApartment}  '
                              '${snapshot.data!.getEntrance} '
                              '${snapshot.data!.getHouse} '
                              '${snapshot.data!.getStreet} '
                              '${snapshot.data!.getRegion} '
                              '${snapshot.data!.getCity} '
                              '${snapshot.data!.getNation}');
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
                ),
              ],
            ),
          ),
        ),
    );
  }
}