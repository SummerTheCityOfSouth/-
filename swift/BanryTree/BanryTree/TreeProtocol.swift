//
//  TreeProtocol.swift
//  BanryTree
//
//  Created by 王孝飞 on 2020/4/27.
//  Copyright © 2020 王孝飞. All rights reserved.
//

import Foundation

protocol TreeProtocol {
    associatedtype E
    var root: Node<E>? {get}
    ///元素的数量
    var size: Int {get}
    ///是否为空
    func isEmpty() -> Bool
    ///清空所有元素
    func clear()
    ///添加元素
    func add(_ element: E) -> E
    ///元素的数量
    func remove(_ element: E) -> E
}

extension TreeProtocol{
    func description() {
        inorderTraversal(root)
    }
    
    func inorderTraversal(_  node: Node<E>?) {
        guard let root = node else {
            return
        }
        inorderTraversal(node?.left)
        print(root.element)
        inorderTraversal(node?.right)
    }
}

protocol NodeProtocol {
    associatedtype E
    var element: E {get set}
    var left: Node<E>? {get set}
    var right: Node<E>? {get set}
    var parent: Node<E>? {get set}
}

class Node<T>: NodeProtocol {
    typealias E = T
    var left: Node<T>?
    var right: Node<T>?
    var parent: Node<T>?
    var element: T
    
    init(_ element: T, _ parent: Node<T>? = nil) {
        self.parent = parent
        self.element = element
    }
    
    var isLeaf: Bool{
        return isHaveLeft || isHaveRight
    }
    
    var haveTwoChild: Bool{
        return isHaveLeft && isHaveRight
    }

    var isHaveLeft: Bool{
        guard let _ = left else{
            return false
        }
        return true
    }
    
    var isHaveRight: Bool{
        guard let _ = right else{
            return false
        }
        return true
    }
    
//    func isLeftChild(_ node: Node<T>) -> Bool {
//        guard let left = left else { return false }
//        return node.element == left.element
//    }
//
//    func isRightChild(_ node: Node<T>) -> Bool {
//        guard let right = right else { return false }
//        return comp
//    }

}
