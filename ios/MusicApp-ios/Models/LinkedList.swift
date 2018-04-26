//
//  LinkedList.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/15/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

class LinkedList<T> {

    public typealias Node = LinkedListNode<T>
    
    public var size = 0
    private var head: Node?
    
    // return true if list is empty
    public var isEmpty: Bool {
        return head == nil
    }
    
    // gets the first node in the list
    public var first: Node? {
        return head
    }
    
    // get the last node in the list
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    // adds node to end of list
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.prev = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
        size += 1
        
    }
    
    // insert a node at a specific index in the list
    public func insert(_ value: T, atIndex index: Int) {
        let node = LinkedListNode<T>(value: value)
        let index_ = index > size ? size : index
        if let next = self.nodeAt(atIndex: index_) {
            node.next = next
            if let prev = next.prev {
                node.prev = prev
                prev.next = node
            }
            next.prev = node
        }
        if (index_ == 0) {
            head = node
        }
        size += 1
    }

    // removes a specific node in the list
    public func remove(node: Node) -> T? {
        let next = node.next
        let prev = node.prev
        
        if next != nil {
            next!.prev = prev
        }
        
        if prev != nil {
            prev!.next = next
        } else {
            // probably the head? we should make sentinals...
            head = next
        }
        
        node.prev = nil
        node.next = nil
        size -= 1
        
        return node.value
    }
    
    // removes the last node in the list
    public func removeLast() -> T? {
        if isEmpty {
            return nil
        } else {
            return remove(node: last!)
        }
    }
    
    // removes node at specific index
    public func removeAt(_ index: Int) -> T? {
        if isEmpty || index > size-1 {
            return nil
        } else {
            let node = nodeAt(atIndex: index)!
            return remove(node: node)
        }
    }
    
    //removes all the nodes from the list
    public func removeAll() {
        head = nil
        size = 0
    }
    
    
    // returns the node at the given index
    public func nodeAt(atIndex index: Int) -> Node? {
        if (index > size) {
            return nil
        }
        var node = head
        for _ in 0..<index {
            if node == nil {
                break
            }
            node = node?.next
        }
        return node
    }
    
    // prints the list - helpful for debugging
    public var printList: String {
        var s = "[ "
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + " ]"
    }
    
}

// Node class for the Linked List
class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    var prev: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}
