import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItem();
  }
}

class _NewItem extends State<NewItem> {

  final _formkey=GlobalKey<FormState>();
  var _enterName='';
  var _selectCategory=categories[ Categories.vegetables]!;
  var _enterQuantity=1;
  void _saveItem()
  {
     if( _formkey.currentState!.validate())

       {
         _formkey.currentState!.save();
         Navigator.of(context).pop(
             GroceryItem(
                 id: DateTime.now().toString(),
                 name: _enterName,
                 quantity: _enterQuantity,
                 category: _selectCategory),);

       }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  if(value==null || 
                      value.trim().length==1 ||
                      value.trim().length>50 ||
                      value.isEmpty)
                    {
                      return 'Must be between 1 and 50 characters.' ;
                    }
                  else
                    {
                      return null;
                    }
                  
                },
                onSaved: (value)
                {
                  _enterName=value!;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(


                     child:TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      initialValue: _enterQuantity.toString(),
                      validator: (value)
                      {
                        if(value==null ||
                        value.isEmpty ||
                        int.tryParse(value)!<=0
                        )
                          {
                            return 'Must be a valid ,positive number.';
                          }
                        else
                          {
                            return null;
                          }
                      },
                      onSaved: (value)
                      {
                         _enterQuantity=int.parse(value!);
                      },
                    ),
                    ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectCategory,
                        items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(category.value.title),
                            ],
                          ),
                        )
                    ], onChanged: (value)
                    {
                      setState(() {
                        _selectCategory=value!;
                      });

                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      _formkey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text('Add Item'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
