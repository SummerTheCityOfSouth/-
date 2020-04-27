//
//  BanryTree.swift
//  BanryTree
//
//  Created by 王孝飞 on 2020/4/17.
//  Copyright © 2020 王孝飞. All rights reserved.
//

import Foundation

struct BanrySearchTree<T: Comparable>: TreeProtocol {
    
    typealias E = T
    var root: Node<T>?
    private (set) var size: Int = 0
    
}

extension BanrySearchTree{
   func clear() {
       
   }
   
   func remove(_ element: T) -> T {
       return element
   }
   
   func add(_ element: T) -> T {
       return element
   }
   
   func isEmpty() -> Bool {
       return size == 0
   }

}


