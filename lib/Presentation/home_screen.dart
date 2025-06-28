import 'package:flutter/material.dart';
import 'package:money_transaction/model/transaction_model.dart';

ValueNotifier<List<TransactionModel>> myList = ValueNotifier([]);

class HomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController narrationController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text(
          'Money Tracker',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: myList,
        builder: (context, list, _) {
          return ListView(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    title: Text(
                      list[index].transactionNarration,
                      style: const TextStyle(fontSize: 25),
                    ),
                    subtitle:
                        Text('Amount: ${list[index].transactionAmount}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            TextEditingController editNarrationController = TextEditingController(text: list[index].transactionNarration);
                            String? selectedType = list[index].transactionType == '+1' ? 'Income' : 'Expense';
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Edit this Transaction',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                  content: StatefulBuilder(
                                    builder: (context, setState) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: editNarrationController,
                                            decoration: const InputDecoration(
                                              hintText: 'Narration',
                                            ),
                                          ),
                                          DropdownButton<String>(
                                            isExpanded: true,
                                            value: selectedType,
                                            items: ['Income', 'Expense']
                                                .map((type) => DropdownMenuItem(
                                                      value: type,
                                                      child: Text(type),
                                                    ))
                                                .toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedType = value;
                                              });
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        list[index].transactionNarration = editNarrationController.text;
                                        list[index].transactionType = selectedType == 'Income' ? '+1' : '-1';
                                        myList.value = List.from(list);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Save'),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Are you sure about this?',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('No', style: TextStyle(color: Colors.purple)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        list.removeAt(index);
                                        myList.value = List.from(list);
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Yes Proceed', style: TextStyle(color: Colors.purple)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: list.length,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String? selectedType;
          List<String> transType = ['Income', 'Expense'];

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    title: const Text('Add a Transaction'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: narrationController,
                            decoration: InputDecoration(
                              hintText: 'Narration',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a narration';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: amountController,
                            decoration: InputDecoration(
                              hintText: 'Amount',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter an amount';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Enter a valid number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            hint: const Text('Transaction Type'),
                            value: selectedType,
                            items: transType.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedType = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a transaction type';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final newTransaction = TransactionModel(
                              transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
                              transactionNarration: narrationController.text,
                              transactionAmount: amountController.text,
                              transactionType:
                                  selectedType == 'Income' ? '+1' : '-1',
                            );
                            myList.value = [...myList.value, newTransaction];
                            narrationController.clear();
                            amountController.clear();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
        backgroundColor: const Color.fromARGB(255, 169, 178, 224),
        child: const Icon(Icons.add),
      ),
    );
  }
}
