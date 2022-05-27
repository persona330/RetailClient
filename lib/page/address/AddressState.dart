import 'package:flutter/material.dart';
import 'package:retail/model/Address.dart';

class AddressState extends InheritedWidget {
  final Address address;
  const AddressState({
    required this.address,
    required Widget child,
  }) :  super(child: child);

  @override
  bool updateShouldNotify(covariant AddressState oldWidget) =>
      oldWidget.address != address;

  static Address? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AddressState>()?.address;
}