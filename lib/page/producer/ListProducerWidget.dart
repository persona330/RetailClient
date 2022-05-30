import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/controller/AddressController.dart';
import 'package:retail/page/nomenclature/CreateNomenclaturePage.dart';
import '../../controller/ProducerController.dart';
import '../../model/Producer.dart';

class ListProducerWidget extends StatefulWidget
{
  const ListProducerWidget({Key? key}) : super(key: key);

  @override
  _ListProducerWidgetState createState() => _ListProducerWidgetState();
}

class _ListProducerWidgetState extends StateMVC
{
  late ProducerController _controller;
  late Producer _producer;

  _ListProducerWidgetState() : super(AddressController()) {_controller = controller as ProducerController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getProducerList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is ProducerResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProducerResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _producerList = (state as ProducerGetListResultSuccess).producerList;
      _producer = _producerList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Производитель",),
          items: _producerList.map((Producer items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Producer? item) {
            setState(() {_producer = item!;});
            CreateNomenclaturePage.of(context)?.setProducer(_producer);
          }
      );
  }
  }

}