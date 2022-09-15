import 'package:flutter/material.dart';
import 'package:librazza/functions/alert_dialog.dart';
import 'package:librazza/models/employe.dart';
import 'package:librazza/widgets/sideBar/nav_bar.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.employe})
      : super(key: key);

  final Employe employe;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<bool> _onWillPop(BuildContext context) async {
    bool? exitResult = await showDialog(
      context: context,
      //builder: (context) => _buildExitDialog(context),
      builder: (context) => ExitApp().buildExitDialog(context),
    );
    return exitResult ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          drawer: NavBar(employe: widget.employe),
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[Text("adicionar Empréstimos em aberto")],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
