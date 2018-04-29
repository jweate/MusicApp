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
    
    
    public func size() -> Int {
        return list.size
    }
    
    public func append(track: Track) {
        list.append(value: track)
    }
    
    public func pop() -> Track? {
        return list.removeAt(0)
    }
    
    public func getAt(atIndex index: Int) -> Track? {
        return list.nodeAt(atIndex: index)?.value
    }
    
    public func putAt(track value: Track, atIndex index: Int) {
        list.insert(value, atIndex: index)
    }
    
    public func removeAt(atIndex index: Int) -> Track? {
        return list.removeAt(index)
    }
    
    public func skipNext() {
        if (pointer == size() - 1) {
            pointer = 0
        } else {
            pointer = pointer + 1
        }
    }
    
    public func skipPrev() {
        if (pointer == 0) {
            pointer = size() - 1
        } else {
            pointer = pointer - 1
        }
    }
    
    public func getPointer() -> Int {
        return pointer
    }
    
    public func toArray() -> [Track] {
        var array = [Track]()
        for i in 0..<size() {
            array.append(getAt(atIndex: i)!)
        }
        return array
    }
    
    public func isEmpty() -> Bool {
        return list.isEmpty
    }
    
}
