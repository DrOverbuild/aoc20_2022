//
//  tests.swift
//  aoc20
//
//  Created by Reddin, Jasper B on 12/21/22.
//

import Foundation

func test1() {
  var list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4])
  list[0].shift(delta: 1)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4])
  list[1].shift(delta: 1)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4]) // expect 0, 2, 3, 1, 4
  list[1].shift(delta: 6)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4])
  list[1].shift(delta: -1)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4])
  list[4].shift(delta: 1)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4])
  list[1].shift(delta: -1)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4])
  list[0].shift(delta: -1)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4])
  list[0].shift(delta: -3)
  print(list.toArray())
  
  list = CircularLinkedList(fromArray: [0, 1, 2, 3, 4]) // expect 0, 4, 1, 2, 3
  list[0].shift(delta: -13)
  print(list.toArray())
}
