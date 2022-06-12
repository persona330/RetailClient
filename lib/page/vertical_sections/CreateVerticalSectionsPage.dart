import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/vertical_sections/widget/CreateListStillageWidget.dart';
import '../../controller/VerticalSectionsController.dart';
import '../../model/Stillage.dart';
import '../../model/VerticalSections.dart';

class CreateVerticalSectionsPage extends StatefulWidget
{
  const CreateVerticalSectionsPage({Key? key}) : super(key: key);

  @override
  _CreateVerticalSectionsPageState createState() => _CreateVerticalSectionsPageState();

  static _CreateVerticalSectionsPageState? of(BuildContext context)
  {
    // Эта конструкция нужна, чтобы можно было обращаться к нашему виджету
    // через: TopScreen.of(context)
    assert(context != null);
    final _CreateVerticalSectionsPageState? result =
    context.findAncestorStateOfType<_CreateVerticalSectionsPageState>();
    return result;
  }
}

class _CreateVerticalSectionsPageState extends StateMVC
{
  VerticalSectionsController? _controller;

  _CreateVerticalSectionsPageState() : super(VerticalSectionsController()) {_controller = controller as VerticalSectionsController;}

  final _numberController = TextEditingController();
  final _sizeController = TextEditingController();

  late Stillage _stillage;

  Stillage getStillage(){return _stillage;}
  void setStillage(Stillage stillage){_stillage = stillage;}

    @override
  void initState()
  {
    super.initState();
  }

  @override
  void dispose()
  {
    _numberController.dispose();
    _sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: const Text('Создание вертикальной секции')),
      body:  Scrollbar(
          child: Container(
            // this.left, this.top, this.right, this.bottom
           padding: const EdgeInsets.fromLTRB(50, 30, 500, 0),
            child: Column (
              children: [
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Zа-яА-Я0-9]")),],
                  decoration: const InputDecoration(labelText: "Номер"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _numberController,
                  textInputAction: TextInputAction.next,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(labelText: "Вместимость"),
                  style: const TextStyle(fontSize: 14, color: Colors.blue),
                  controller: _sizeController,
                  textInputAction: TextInputAction.next,
                ),
                const Flexible(
                  flex: 1,
                  child: CreateListStillageWidget(),
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: ()
                  {
                    VerticalSections _verticalSections = VerticalSections(idVerticalSections: UniqueKey().hashCode, number: _numberController.text, size: double.parse(_sizeController.text), stillage: getStillage());
                    _controller?.addVerticalSections(_verticalSections);
                    Navigator.pop(context, true);
                    final state = _controller?.currentState;
                    if (state is VerticalSectionsAddResultSuccess) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Вертикальная секция создана")));}
                    if (state is VerticalSectionsResultLoading) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Загрузка")));}
                    if (state is VerticalSectionsResultFailure) {ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Произошла ошибка при добавлении поста")));}
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