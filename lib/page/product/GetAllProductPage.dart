import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:retail/page/product/CreateProductPage.dart';
import 'package:retail/page/product/widget/ItemProductWidget.dart';
import '../../controller/ProductController.dart';
import '../../model/Product.dart';
import 'GetProductPage.dart';

class GetAllProductPage extends StatefulWidget
{
  const GetAllProductPage({Key? key}) : super(key: key);

  @override
  _GetAllProductPageState createState() => _GetAllProductPageState();
}

class _GetAllProductPageState extends StateMVC
{
  late ProductController _controller;

  _GetAllProductPageState() : super(ProductController()) {_controller = controller as ProductController;}

  Widget appBarTitle = const Text("Товары");
  Icon actionIcon = const Icon(Icons.search, color: Colors.white,);

  @override
  void initState()
  {
    super.initState();
    _controller.getProductList();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        leading: IconButton(icon:const Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          IconButton(icon: actionIcon,onPressed:()
          {
            setState(() {
              if ( actionIcon.icon == Icons.search)
              {
                actionIcon = const Icon(Icons.close);
                appBarTitle = const TextField(
                  style: TextStyle(color: Colors.white,),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Поиск...",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                );}
              else {
                actionIcon = const Icon(Icons.search);
                appBarTitle = const Text("Товары");
              }
            });
          } ,),]
      ),
      body: _buildContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateProductPage())); },
        tooltip: 'Добавить товар',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildContent()
  {
    final state = _controller.currentState;
    if (state is ProductResultLoading)
    {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProductResultFailure)
    {
      return Center(
        child: Text(
            state.error,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline4?.copyWith(color: Colors.red)
        ),
      );
    } else {
      final _productList = (state as ProductGetListResultSuccess).productList;
      return Column(
        children: [
          Expanded(
            child:
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: _productList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => GetProductPage(id: _productList[index].getIdProduct!)));
                      },
                      child: ItemProductWidget(_productList[index]),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
  }
  }
}


