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
    
    public func append(track: Track) {
        list.append(value: track)
    }
    
    public func pop() -> Track {
        return list.removeAt(0)
    }
    
    public func nodeAt(atIndex index: Int) -> Track {
        return list.nodeAt(atIndex: index).value
    }
    
    public func insertAt(String value: Track, atIndex index: Int) {
        let newNode = LinkedListNode<Track>(value: value)
        list.insert(newNode, atIndex: index)
    }
    
    public func removeAt(atIndex index: Int) {
        list.removeAt(index)
    }
    
    public func skip() {
        if (pointer == count() - 1) {
            print("fell in")
            pointer = 0
        }
        else{
            pointer = pointer + 1
        }
    }
    
    public func prev() {
        pointer = pointer - 1
    }
    
    public func getPoint() -> Int {
        return pointer
    }
    
    public func toArray() -> [Track] {
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
