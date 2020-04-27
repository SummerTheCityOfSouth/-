//
//  BanryTree.swift
//  BanryTree
//
//  Created by 王孝飞 on 2020/4/17.
//  Copyright © 2020 王孝飞. All rights reserved.
//

import Foundation

class BanrySearchTree<T: Comparable>: TreeProtocol {
    
    typealias E = T
    var root: Node<T>?
    private (set) var size: Int
    private var cmpHandle: ((T,T)->ComparisonResult)?
    
    init(root: Node<T>?, cmpHandle: ((T,T)->ComparisonResult)? = nil) {
        self.root = root
        self.size = 0
        self.cmpHandle = cmpHandle
    }
}

///public
extension BanrySearchTree{
    func clear() {
        root = nil
        size = 0
    }
    
    func remove(_ element: T) -> T {
        if contains(element) == false {
            return element
        }
        _ = remove(Node.init(element))
        return element
    }
    
    func add(_ element: T) -> T {
        
        var parent = root
        var node = root
        while let parentNode = node {
            let result = compare(parentNode.element, element)
            parent = node
            switch result {
            case .orderedSame:
                node?.element = element
                return element
            case .orderedAscending:
                node = node?.right
            case .orderedDescending:
                node = node?.left
            }
        }
        
        let newNode = Node.init(element, parent)
        guard let parentNode = parent else {
            root = newNode
            size = 1
            return element
        }
        
        let result = compare(parentNode.element, element)
        if result == .orderedAscending{
            parentNode.right = newNode
        }else{
            parentNode.left = newNode
        }
        size += 1
        return element
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func contains(_ element: T) -> Bool {
        return node(element) != nil
    }
    
    ///前序遍历
    final func preOrder(elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }
        preOrderTraversal(root, elementHandle: elementHandle)
    }

    ///中序遍历
    final func inOrder(elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }
        inOrderTraversal(root, elementHandle: elementHandle)
    }

    ///后序遍历
    final func postOrder(elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }
        postOrderTraversal(root, elementHandle: elementHandle)
    }

    ///层序遍历
    final func levelOrder(elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }
        levelOrderTraversal(root, elementHandle: elementHandle)
    }

}

///tool
extension BanrySearchTree{
    
    final private func remove(_ deleteNode: Node<T>) -> Node<T>?{
        var node = root
        var lastNode: Node<T>? = nil
        
        while let current = node {
            let result = compare(current.element, deleteNode.element)
            if result == .orderedAscending{
                lastNode = current
                node = current.right
            }else if result == .orderedDescending{
                lastNode = current
                node = current.left
            }else{
                delete(node!,lastNode)
                ///删除节点
                return node
            }
        }
        return nil
    }
    
    final private func delete(_ deleteNode: Node<T>, _ parentNode: Node<T>?){
        
        size -= 1
        var dNode = deleteNode
        ///有两个节点 ，找到后继节点，或者找到前驱节点
        if deleteNode.haveTwoChild{
            let succNode = successor(deleteNode)
            deleteNode.element = succNode.element
            dNode = succNode
        }
        
        ///删除度为0 或者为1的节点
        if let left = dNode.left{
            left.parent = dNode.parent
            if dNode.parent == nil {
                root = left
            }
            dNode.parent = nil
            dNode.left = nil
        }else if let right = dNode.right{
            right.parent = dNode.parent
            if dNode.parent == nil {
                root = right
            }
            dNode.parent = nil
            dNode.right = nil
        }else if dNode.parent == nil{
            root = nil
        }else {
            if let lNode = dNode.parent?.left, dNode.element == lNode.element {
                dNode.parent?.left = nil
            }else{
                dNode.parent?.right = nil
            }
        }
    }
    
    final private func successor(_ node: Node<T>) -> Node<T>{
        var leftNode = node.left
        while let rightNode = leftNode?.right {
            leftNode = rightNode
        }
        return leftNode!
    }
    
    final private func node(_ element: T) -> Node<T>? {
        var node = root
        while let root = node {
            let result = compare(root.element, element)
            if result == .orderedSame {
                return root
            }else if result == .orderedAscending{
                node = root.right
            }else{
                node = root.left
            }
        }
        return nil
    }
    
    final private func compare(_ left: T, _ right: T) -> ComparisonResult {
        if let comp = cmpHandle{
            return comp(left, right)
        }
        
        if left > right{
            return .orderedDescending
        }else if left < right{
            return .orderedAscending
        }else{
            return .orderedSame
        }
    }
    
    ///前序遍历
    final private func preOrderTraversal(_ root: Node<T>?, elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }
        elementHandle?(root.element)
        preOrderTraversal(root.left, elementHandle: elementHandle)
        preOrderTraversal(root.right, elementHandle: elementHandle)
    }
    
    ///中序遍历
    final private func inOrderTraversal(_ root: Node<T>?, elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }
        inOrderTraversal(root.left, elementHandle: elementHandle)
        elementHandle?(root.element)
        inOrderTraversal(root.right, elementHandle: elementHandle)
    }

    ///后序遍历
    final private func postOrderTraversal(_ root: Node<T>?, elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }
        postOrderTraversal(root.left, elementHandle: elementHandle)
        postOrderTraversal(root.right, elementHandle: elementHandle)
        elementHandle?(root.element)
    }

    ///层序遍历
    final private func levelOrderTraversal(_ root: Node<T>?, elementHandle: ((T)->())?) {
        guard let root = root  else {
            return
        }

        var list = [root]
        while let node = list.first {
            elementHandle?(node.element)
            if let left = node.left{
                list.append(left)
            }
            if let right = node.right{
                list.append(right)
            }
            list.removeFirst()
        }
    }
}

