import 'package:curd_redux/models/Item.dart';
import 'package:curd_redux/page_two.dart';
import 'package:curd_redux/redux/actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'redux/reducers.dart';


void main() => runApp(Main());



class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Store<AppState> store = Store<AppState>(
        appStateReducer,
        initialState: AppState.intializeState()
    );

    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'CURD with redux',
        theme: ThemeData.dark(),
        home:Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Home Page'),
          actions: <Widget>[
            RaisedButton(
              child: Text('Next Page'),
              onPressed: () => _goToNextPage(context),
            )
          ],
        ),
        body: StoreConnector<AppState,ViewModel>(
          converter: (Store<AppState> store) => ViewModel.create(store),
          builder: (BuildContext context , ViewModel vm) =>
          Column(
            children: <Widget>[
              AddItemWidget(vm : vm),
              Expanded(child: ItemListWidget(key: UniqueKey(),vm : vm),),
              RemoveItemButton(vm: vm),

            ],
          )
        )

          );
  }

  void _goToNextPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo()));
  }
}

class ViewModel {
  final List<Item> items;
  final Function(String) onAddItem;
  final Function(Item) onRemoveItem;
  final Function() onRemoveItems;

  ViewModel({
    this.items,
    this.onAddItem,
    this.onRemoveItem,
    this.onRemoveItems
  });


  factory ViewModel.create(Store<AppState> store){
    _onAddItem(String body){
      store.dispatch(AddItemAction(body: body));
    }

    _onRemoveItem(Item item){
      store.dispatch(RemoveItemAction(item: item));
    }

    _onRemoveItems(){
      store.dispatch(RemoveItemsAction());
    }


    return ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
      onRemoveItem: _onRemoveItem,
      onRemoveItems: _onRemoveItems
    );
  }

}

class AddItemWidget extends StatefulWidget {

  final ViewModel vm;

  AddItemWidget({Key key, this.vm}) : super(key : key);

  @override
  _AddItemWidgetState createState() => _AddItemWidgetState();
}

class _AddItemWidgetState extends State<AddItemWidget> {
  final TextEditingController _t_c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _t_c,
      decoration: InputDecoration(
        hintText : 'add item',
      ),
      onSubmitted: (String s) => _handleSubmit(s),
    );
  }

  _handleSubmit(String s) {
    widget.vm.onAddItem(s);
    _t_c.text = '';
  }
}



class ItemListWidget extends StatefulWidget {
  final ViewModel vm;

  ItemListWidget({Key key,this.vm}) : super(key : key);

  @override
  _ItemListWidgetState createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.vm.items.map((Item i) => ListTile(
        title: Text(i.body),
        leading: IconButton(icon: Icon(Icons.delete), onPressed: () => widget.vm.onRemoveItem(i)),
      )).toList(),
    );
  }
}




class RemoveItemButton extends StatelessWidget {
  final ViewModel vm;

  RemoveItemButton({this.vm});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('remove items'),
      onPressed: () => vm.onRemoveItems(),
    );
  }
}





