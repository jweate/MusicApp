//
//  Queue.swift
//  MusicApp-ios
//
//  Created by Jacob Weate on 4/11/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

class Queue {
    
    public var list = LinkedList<Track>()
    static let instance = Queue()
    public var pointer = 0
    
    
    public func count() -> Int {
        return list.count
    }
    
    public func append(track: Track){
        list.append(value: track)
    }
    
    public func pop() -> Track{
        return list.removeAt(0)
    }
    
    public func nodeAt(atIndex index: Int) -> Track{
        return list.nodeAt(atIndex: index).value
    }
    
    public func insertAt(String value: Track, atIndex index: Int) {
        let newNode = LinkedListNode<Track>(value: value)
        list.insert(newNode, atIndex: index)
    }
    
    public func removeAt(atIndex index: Int) {
        list.removeAt(index)
    }
    
    public func skip(){
        if(pointer == count() - 1){
            print("fell in")
            pointer = 0
        }
        else{
            pointer = pointer + 1
        }
    }
    
    public func prev(){
        pointer = pointer - 1
    }
    
    public func getPoint() -> Int{
        return pointer
    }
    
    public func toArray() -> [Track]{
        var counter = 0
        let final = count()
        var array = [Track]()
        while (counter < final){
            array.insert(Queue.instance.pop(), at: counter)
            counter = counter + 1
        }
        return array
    }
    
}


public class LinkedList<T> {
    
    public typealias Node = LinkedListNode<T>
    
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
   
    // returns the size of the list
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    // adds node to end of list
    public func append(value: T) {
        let newNode = Node(value: value)
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    // insert a node at a specific index in the list
    public func insert(_ node: Node, atIndex index: Int) {
        let newNode = node
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let prev = self.nodeAt(atIndex: index-1)
            let next = prev.next
            
            newNode.previous = prev
            newNode.next = prev.next
            prev.next = newNode
            next?.previous = newNode
        }
    }
    
    //removes all the nodes from the list
    public func removeAll() {
        head = nil
    }
    
    // removes a specific node in the list
    public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    // removes the last node in the list
    public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    // removes node at specific index
    public func removeAt(_ index: Int) -> T {
            let node = nodeAt(atIndex: index)
            //assert(node != nil)
            return remove(node: node)
    }
    
    // returns the node at the given index
    public func nodeAt(atIndex index: Int) -> Node {
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil { //(*1)
                    break
                }
            }
            return node!
        }
    }
    
    // prints the list - helpful for debugging
    public var printList: String {
        var s = "["
        var node = head
        while node != nil {
            s += "\(node!.value)"
            node = node!.next
            if node != nil { s += ", " }
        }
        return s + "]"
    }
    
}

// Node class for the Linked List
public class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    public init(value: T) {
        self.value = value
    }
}
