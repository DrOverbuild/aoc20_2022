//
//  main.swift
//  aoc20
//
//  Created by Reddin, Jasper B on 12/20/22.
//

import Foundation

enum IntParsingError: Error {
  case invalidInput(any StringProtocol, Int)
}

func measureperf(_ printDesc: String, action: () throws -> Void) {
  print(printDesc)
  let start = DispatchTime.now()
  do {
    try action()
  } catch {
    print("Failed")
    exit(1)
  }
  
  let end = DispatchTime.now()
  let elapsedSecs = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
  print("Done. Elapsed: \(elapsedSecs)s\n")
}


var input: String = ""
measureperf("Loading file...") {
  do {
    input = try String(contentsOfFile: "input.txt")
  } catch {
    print("File could not be found at \(FileManager.default.currentDirectoryPath)/input.txt")
    exit(1)
  }
}

var inputNumbers: [Int64] = []
measureperf("Parsing integers...") {
  do {
    inputNumbers = try input.split(separator: "\n").enumerated().map { (idx, strItem) in
      let numOpt = Int64(strItem)
      guard let num = numOpt else {
        throw IntParsingError.invalidInput(strItem, idx + 1)
      }
      
      return num
    }
  } catch IntParsingError.invalidInput (let problematicStr, let linenumber) {
    print("Unable to convert '\(problematicStr)' to int at line \(linenumber)")
    exit(1)
  }
}


var list: CircularLinkedList! = nil
measureperf("\nBuilding array...") {
  list = CircularLinkedList(fromArray: inputNumbers)
}

//print(list.toArray())

measureperf("\nApplying key...") {
  list.applyKey(811589153)
}

//print(list.toArray())

measureperf("\nShifting all numbers 10 times") {
  list.shiftAll(n: 10)
}

//print(list.toArray())


measureperf("\nSetting zero as head..."){
  list.setZeroAsHead()
}

//print(list.toArray())
//print(list[1000].bit)
//print(list[2000].bit)
//print(list[3000].bit)
let n1000 = list[1000].bit
let n2000 = list[2000].bit
let n3000 = list[3000].bit
let total = n1000 + n2000 + n3000
print("\nAnswer: \(total)")

//test1()
