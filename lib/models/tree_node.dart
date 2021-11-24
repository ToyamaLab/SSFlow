// Project imports:
import 'package:ssflow/models/_models.dart';

/// ref: [https://pub.dev/packages/tree]
class TreeNode<T extends WithUuid> {
  T? data;
  Map<String, TreeNode<T>> children;
  TreeNode<T>? parent;

  TreeNode(this.data) : children = <String, TreeNode<T>>{};

  void clear() {
    children.clear();
  }

  TreeNode<T>? add(T newData) {
    //first search for the newData in tree, might already be added
    TreeNode<T>? found = findByUuid(newData.uuid);
    if (found != null) {
      // print('already in tree: ${newData.uuid}, parent is ${found.toString()}');
      return found;
    }

    //if newData not in tree
    // and parent should be the root node, add to this node
    if (newData.parentUuid == null) {
      // print('adding to root ${data?.uuid}');
      return addDirectDescendant(newData);
    }

    //if newData not in tree,
    // and parent should not be the root,
    // search for specified parent for newData
    TreeNode<T>? foundParent = findByUuid(newData.parentUuid);
    if (foundParent != null) {
      // print('add direct to other node $foundParent');
      return foundParent.addDirectDescendant(newData);
    }

    //if the desired parent is not part of the tree, return null;
    return null;
  }

  TreeNode<T> addDirectDescendant(T newData) {
    TreeNode<T> child = TreeNode<T>(newData);
    child.parent = this;
    children[newData.uuid] = child;
    // if (newData != null) this.children[newData.uuid] = child;
    // print('addDirectDescendant: added ${child.data} = {$newData} with uuid: ${child.data.uuid} to $this');
    // print('children: $children');

    return child;
  }

  TreeNode<T>? findByUuid(String? uuid) {
    // print('looking for uuid: $uuid in $this');
    if (uuid == null) {
      return null;
    }

    if (data?.uuid == uuid) {
      return this;
    }

    for (var k in children.keys) {
      var found = children[k]?.findByUuid(uuid);
      if (found != null) {
        // print('found in child $k');
        return found;
      }
    }
    // print('not found');
    return null;
  }

  List<String> toStringList() {
    List<String> result = <String>[];

    final String nodeStr = data != null ? 'node: $data' : 'root';
    final String parentStr = ' parent: ' +
        (parent == null
            ? 'null'
            : (parent!.parent == null ? 'root' : parent!.data!.uuid));
    final String childrenStr = ' has ${children.length.toString()} children';

    result.add(nodeStr + parentStr + childrenStr);

    children.forEach((String uuid, TreeNode t) {
      t.toStringList().forEach((String str) {
        result.add('    ' + str);
      });
    });

    return result;
  }

  factory TreeNode.fromList(List<T>? list) {
    TreeNode<T> rootNode = TreeNode<T>(null);
    if (list == null) {
      return rootNode;
    }

    List<T> unassigned = List<T>.from(list);

    int iterations = 0;
    while (unassigned.isNotEmpty && iterations < list.length) {
      iterations++;

      for (T category in list) {
        if (!unassigned.contains(category)) {
          continue;
        }

        // print('unassigned: $category');
        TreeNode<T>? newNode = rootNode.add(category);

        if (newNode == null) {
          // print ('could NOT add $category');
        } else {
          // print ('added $category');
          // print ('Tree is: \n$this');
          unassigned.remove(category);
        }
      }
    }

    // print('ROOT: ' + rootNode.toString() + '\n');
    return rootNode;
  }

  @override
  String toString() => toStringList().join('\n');
}
