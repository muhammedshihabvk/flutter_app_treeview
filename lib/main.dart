import 'package:flutter/cupertino.dart';
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
  bool showItemsFlag = false;
  Map<String, bool> booleanBank = {};

  _setBankValue(String key, bool status) {
    booleanBank[key] = status;
  }

  Widget treeBlock(TreeRoot treeRootInstance) {
    return Column(
      children: [
        ...treeRootInstance.trees.map((tree) => getTree(tree, 20)).toList()
      ],
    );
  }

  Widget getTree(Tree tree, double paddingValue) {
    if (tree.children == null) {
      print("tree child is null");
    }
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      // color: Colors.grey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(left: paddingValue),
                child: tree.isLeaf == false
                    ? GestureDetector(
                        onTap: () {
                          print("clicked on ${tree.name}");
                          setState(() {
                            tree.showChildren = !tree.showChildren;
                          });
                        },
                        child: Text(tree.name,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      )
                    : Text(
                        tree.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
              ),
              tree.isLeaf == false
                  ? Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              tree.parent.children
                                  .map((e) => e.isSelected = false);
                              tree.isSelected = true;
                              tree.showChildren = !tree.showChildren;
                            });
                          },
                          child: Icon(Icons.add)),
                    )
                  : Checkbox(
                      value: tree.isSelected,
                      onChanged: (value) {
                        setState(() {
                          // tree.isSelected = !tree.isSelected;
                          tree.parent.children.forEach((element) {
                            element.isSelected = false;
                          });
                          tree.isSelected = true;
                          _setBankValue(tree.name, value);
                        });

                        print(value);
                      },
                    ),
            ],
          ),
          if ((tree.children.length > 0) && (tree.showChildren == true))
            ...tree.children.map((e) => getTree(e, paddingValue + 30)).toList()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TreeRoot treeRoot = TreeRoot(trees: [
      Tree(
          name: "Brand",
          children: [],
          value: "",
          isLeaf: false,
          showChildren: true),
      Tree(
          name: "Brand2",
          children: [
            Tree(name: "adidas2", value: "adidas2", children: [], isLeaf: true),
            Tree(
                name: "nike2",
                value: "nike2",
                children: [Tree(name: "shihab", children: [], isLeaf: true)],
                isLeaf: false,
                showChildren: true)
          ],
          value: "",
          isLeaf: false,
          showChildren: true)
    ]);

    var testVar = Tree(
      name: "adidas",
      value: "adidas",
      children: [],
      isLeaf: true,
      parent: treeRoot.trees[0],
    );

    var testVar2 = Tree(
      name: "nike",
      value: "nike",
      children: [],
      isLeaf: true,
      parent: treeRoot.trees[0],
    );

    treeRoot.trees[0].children.add(testVar);
    treeRoot.trees[0].children.add(testVar2);

    return Scaffold(
      appBar: AppBar(
        title: Text("Tree Sample"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [treeBlock(treeRoot)],
        ),
      ),
    );
  }
}

class TreeRoot {
  List<Tree> trees;
  TreeRoot({this.trees});
}

class Tree {
  final String name;
  final String value;
  List<Tree> children;
  final bool isLeaf;
  final bool isSingleSelection;
  bool showChildren;
  bool isSelected;
  Tree parent;
  Tree(
      {this.name,
      this.value,
      this.children,
      this.isLeaf,
      this.isSingleSelection,
      this.showChildren = true,
      this.isSelected = false,
      this.parent});
}
