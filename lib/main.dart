import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "treeview",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [treeBlock],
        ),
      ),
    );
  }
}

Widget treeBlock(TreeRoot treeRootInstance) {
  return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("TreeName1"), Icon(Icons.keyboard_arrow_down)],
          ),
        ],
      ));
}

class TreeRoot {
  List<Tree> trees;
  TreeRoot({this.trees});
}

class Tree {
  final String name;
  final String value;
  final List<Tree> children;
  final bool isLeaf;
  final bool isSingleSelection;
  Tree(
      {this.name,
      this.value,
      this.children,
      this.isLeaf,
      this.isSingleSelection});
}
