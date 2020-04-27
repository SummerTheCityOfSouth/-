//
//  main.swift
//  BanryTree
//
//  Created by 王孝飞 on 2020/4/17.
//  Copyright © 2020 王孝飞. All rights reserved.
//

import Foundation

let tree = BanrySearchTree<Int>.init(root: nil)
tree.add(2)
tree.add(5)
tree.add(8)
tree.add(7)
tree.add(3)
tree.add(100)
tree.add(88)
tree.description()

print("pre----")
tree.preOrder { (element) in
    print(element)
}
print("in----")
tree.inOrder { (element) in
    print(element)
}

print("post----")
tree.postOrder { (element) in
    print(element)
}

print("level----")
tree.levelOrder { (element) in
    print(element)
}
print("delete----")
tree.remove(5)
tree.description()
print("delete----")
tree.remove(5)
tree.description()
