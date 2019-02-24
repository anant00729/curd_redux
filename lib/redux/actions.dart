import 'package:curd_redux/models/Item.dart';

class AddItemAction{
  static int _id = 0;
  final String body;

  AddItemAction({this.body}){
    _id++;
  }

  int get id => _id;
}

class RemoveItemsAction{}

class RemoveItemAction{
  final Item item;

  RemoveItemAction({this.item});
}
