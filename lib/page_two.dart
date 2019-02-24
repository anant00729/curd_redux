import 'package:curd_redux/main.dart';
import 'package:curd_redux/models/Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';


class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home Page'),),
        body: StoreConnector<AppState,ViewModel>(
            converter: (Store<AppState> store) => ViewModel.create(store),
            builder: (BuildContext context , ViewModel vm) =>
                Column(
                  children: <Widget>[
                    AddItemWidget(vm : vm),
                    Expanded(child: ItemListWidget(key: UniqueKey(),vm : vm)),
                    RaisedButton(
                      child: Text('remove items'),
                      onPressed: () => vm.onRemoveItems(),
                    )
                  ],
                )
        )

    );
  }
}
