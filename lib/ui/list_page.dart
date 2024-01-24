import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqress_app/api/api_service.dart';
import 'package:reqress_app/model/list_model.dart';
import 'package:reqress_app/provider/list_provider.dart';
import 'package:reqress_app/widget/list_card_widget.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  showModal(Datum? data, index) {
    AlertDialog alertDialog = AlertDialog(
      content: SizedBox(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'example@gmail.com'),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () async {
              await ApiService()
                  .createUser(_nameController.text, _emailController.text);
              await Provider.of<ListProvider>(context, listen: false)
                  .getUserList();
              Navigator.pop(context);
            },
            child: const Text('save')),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('cancel'),
        ),
      ],
    );
    return showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ReqressApp'),
      ),
      body: _buildList(),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModal(null, null);
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ]),
    );
  }

  Consumer<ListProvider> _buildList() {
    return Consumer<ListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (state.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: state.reqresListResult.data.length,
              itemBuilder: (context, index) {
                var userList = state.reqresListResult.data[index];
                return ListCardWidget(userList: userList);
              },
            );
          } else if (state.state == ResultState.noData) {
            Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultState.error) {
            Center(
              child: Text(state.message),
            );
          }
          return const Scaffold();
        }
      },
    );
  }
}
