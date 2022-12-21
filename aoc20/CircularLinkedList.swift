//
//  MixedList.swift
//  aoc20
//
//  Created by Reddin, Jasper B on 12/20/22.
//

import Foundation

class CircularLinkedListNode {
  var bit: Int64
  var next: CircularLinkedListNode!
  var prev: CircularLinkedListNode!
  var list: CircularLinkedList!
  
  init(_ bit: Int64) {
    self.bit = bit
  }
  
  func placeAfter(node: CircularLinkedListNode) {
    // close broken link between prev and next
    prev.next = self.next
    next.prev = self.prev
    
    // insert after node
    self.next = node.next
    self.prev = node
    node.next = self
    next.prev = self
  }
  
  func placeBefore(node: CircularLinkedListNode) {
    // close broken link between prev and next
    prev.next = self.next
    next.prev = self.prev
    
    // insert before node
    self.next = node
    self.prev = node.prev
    node.prev = self
    prev.next = self
  }
  
  func shift(delta: Int64) {
    if delta == 0 {
      return
    }
    
    let node = traverse(n: delta, reduceMod: -1)
    if delta < 0 {
      placeBefore(node: node)
    } else {
      placeAfter(node: node)
    }
  }
  
  func traverse(n: Int64, reduceMod mod: Int = 0) -> CircularLinkedListNode {
    let reduced = n % Int64(list.count + mod)
    var node = self
    if n < 0 {
      for _ in 0..<(-reduced) {
        node = node.prev
      }
    } else {
      for _ in 0..<reduced {
        node = node.next
      }
    }
    return node
  }
}

class CircularLinkedList {
  // maintains original order of nodes and allows for iteration of all nodes without checking if we've circled back
  private var allNodes: [CircularLinkedListNode] = []
  
  // being a circular list there is technically no beginning or end, but sometimes we need to check for the nth number
  // after 0, so after setting 0 as the head we can calculate the nth number
  private var head: CircularLinkedListNode
  
  private var _count: Int? = nil
  var count: Int {
    get {
      return allNodes.count
    }
  }
  
  subscript(idx: Int) -> CircularLinkedListNode {
    let reduced = idx % count
    var node = head
    for _ in 0..<reduced {
      node = node.next
    }
    
    return node
  }
  
  init(fromArray arr: [Int64]) {
    var node: CircularLinkedListNode? = nil
    for item in arr {
      let thisItem = CircularLinkedListNode(item)
      allNodes.append(thisItem)
      
      if let prev = node  {
        prev.next = thisItem
        thisItem.prev = prev
      }
      node = thisItem
    }
    
    head = allNodes[0]
    head.prev = node
    node!.next = head
    
    allNodes.forEach({ $0.list = self })
  }
  
  func toArray() -> [Int64] {
    var arr: [Int64] = []
    
    var thisNode = head
    for _ in 0..<count {
      arr.append(thisNode.bit)
      thisNode = thisNode.next
    }
    
    return arr
  }
  
  func printList() {
    var str = "{"
    var node = head
    for _ in 0..<count {
      str.append("\(node.bit), ")
      node = node.next
    }
    str.append("}")
    print(str)
  }
  
  func shiftAll(n: Int = 1) {
    for _ in 0..<n {
      for node in allNodes {
        node.shift(delta: node.bit)
      }
    }
  }
  
  func applyKey(_ key: Int64) {
    for node in allNodes {
      node.bit *= key
    }
  }
  
  func setZeroAsHead() {
    var items = 0
    var node = head
    while node.bit != 0 && items < count {
      node = node.next!
      items += 1
    }
    
    head = node
  }
}
