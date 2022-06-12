import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/storage_conditions/CreateStorageConditionsPage.dart';
import '../../../controller/MeasurementController.dart';
import '../../../model/Measurement.dart';

class CreateListMeasurementIlluminationWidget extends StatefulWidget
{
  const CreateListMeasurementIlluminationWidget({Key? key}) : super(key: key);

  @override
  _CreateListMeasurementIlluminationWidgetState createState() => _CreateListMeasurementIlluminationWidgetState();
}

class _CreateListMeasurementIlluminationWidgetState extends StateMVC
{
  late MeasurementController _controller;
  late Measurement _measurement;

  _CreateListMeasurementIlluminationWidgetState() : super(MeasurementController()) {_controller = controller as MeasurementController;}

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
          decoration: const InputDecoration(labelText: "Единиа измерения",),
          items: _measurementList.map((Measurement items) {
            return DropdownMenuItem(
              child: Text(items.toString()),
              value: items,
            );
          }).toList(),
          onChanged: (Measurement? item) {
            setState(() {
              _measurement = item!;
            });
            CreateStorageConditionsPage.of(context)?.setMeasurementIllumination(_measurement);
          }
      );
  }
  }

}