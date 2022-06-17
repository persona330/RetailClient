import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/area/CreateAreaPage.dart';
import 'package:retail/page/price/CreatePricePage.dart';
import '../../../controller/MeasurementController.dart';
import '../../../controller/StorageConditionsController.dart';
import '../../../model/Measurement.dart';
import '../../../model/StorageConditions.dart';

class CreateListMeasurementWidget extends StatefulWidget
{
  const CreateListMeasurementWidget({Key? key}) : super(key: key);

  @override
  _CreateListMeasurementWidgetState createState() => _CreateListMeasurementWidgetState();
}

class _CreateListMeasurementWidgetState extends StateMVC
{
  late MeasurementController _controller;
  late Measurement _measurement;

  _CreateListMeasurementWidgetState() : super(MeasurementController()) {_controller = controller as MeasurementController;}

  @override
  void initState()
  {
    super.initState();
    _controller.getMeasurementList();
  }

  @override
  Widget build(BuildContext context) {
    final state = _controller.currentState;
    if (state is MeasurementResultLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is MeasurementResultFailure) {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _measurementList = (state as MeasurementGetListResultSuccess).measurementList;
      _measurement = _measurementList[0];
      return DropdownButtonFormField(
          isExpanded: true,
          decoration: const InputDecoration(labelText: "Единица измерения",),
          items: _measurementList.map((Measurement items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Measurement? item) {
            setState(() {_measurement = item!;});
            CreatePricePage.of(context)?.setMeasurement(_measurement);
          }
      );
  }
  }

}