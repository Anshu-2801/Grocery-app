import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  GroceryList({super.key});

  @override
  State<GroceryList> createState() {
    return _GroceryList();
  }
}

class _GroceryList extends State<GroceryList> {
  final List<GroceryItem> _groceryItem = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (cntx) => NewItem(),
      ),
    );
    if (newItem == null) return;
    setState(() {
      _groceryItem.add(newItem);
    });
  }

  void removeItem(GroceryItem item) {
    setState(() {
      _groceryItem.remove(item);
    });
  }


  @override
  Widget build(context) {
    Widget content = const Center(child: Text('No items added yet.'),);
    if (_groceryItem.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItem.length,
        itemBuilder: (cntx, index) =>
            Dismissible(
              onDismissed: (direction) {
                removeItem(_groceryItem[index]);
              },
              key: ValueKey(_groceryItem[index].id),
              child: ListTile(
                title: Text(
                  _groceryItem[index].name,
                ),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: _groceryItem[index].category.color,
                ),
                trailing: Text(
                  _groceryItem[index].quantity.toString(),
                ),
              ),
            ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .onPrimary,
      ),
      body: content,
    );
  }
}


