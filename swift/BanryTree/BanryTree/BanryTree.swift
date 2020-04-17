//
//  BanryTree.swift
//  BanryTree
//
//  Created by 王孝飞 on 2020/4/17.
//  Copyright © 2020 王孝飞. All rights reserved.
//

import Foundation

struct BanryTree<T: Comparable> {
    var root: Node?
    var left: Node?
    var right: Node?
    var list: [Node] = []
    public struct Node: Comparable {
        static func < (lhs: BanryTree<T>.Node, rhs: BanryTree<T>.Node) -> Bool {
            return lhs.data == rhs.data
        }
        var data: T
    }
}

extension BanryTree{
    var isEmpty: Bool{
        return list.isEmpty
    }
    
    var size: Int{
        return list.count
    }
    
    mutating func clear() {
        list.removeAll()
    }
    
    mutating func add(_ node: Node) {
        list.append(node)
    }
    
    mutating func remove(_ node: Node) -> Node?{
        guard let index = list.firstIndex(of: node) else { return nil }
        return list.remove(at: index)
    }
    
    func content(_ node: Node) -> Bool{
        return list.contains(where: {$0.data == node.data})
    }
}


