

import 'package:curd_redux/models/Item.dart';
import 'package:curd_redux/redux/actions.dart';

AppState appStateReducer(AppState state, action ){
  return AppState(
    items: itemReducer(state.items, action)
  );
}


List<Item> itemReducer(List<Item> state, action){

  if(action is AddItemAction){
     return []
       ..addAll(state)
       ..add(Item(id: action.id, body: action.body));
  }

  if (action is RemoveItemAction){
    return List.from(state)..remove(action.item);
  }

  if (action is RemoveItemsAction){
    return List.unmodifiable([]);
  }
  
  return state;

}