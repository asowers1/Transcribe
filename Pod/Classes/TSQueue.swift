//
//  TSQueue.swift
//  Pods
//
//  Created by Andrew Sowers on 2/29/16.
//
//

typealias b = String
typealias e = String
typealias i = String
typealias small = String
typealias s = String
typealias u = String
typealias color = String

enum Element: String {
    case b = "b"
    case e = "e"
    case i = "i"
    case small = "small"
    case s = "s"
    case u = "u"
    case color = "color"
}

class QNode<T> {
  var value: T
  var next: QNode?
  
  init(item:T) {
    value = item
  }
}


public struct TSQueue<T> {
  private var top: QNode<T>!
  private var bottom: QNode<T>!
  
  public init() {
    top = nil
    bottom = nil
  }
  
  public mutating func enQueue(item: T) {
    
    let newNode:QNode<T> = QNode(item: item)
    
    if top == nil {
      top = newNode
      bottom = top
      return
    }
    
    bottom.next = newNode
    bottom = newNode
  }
  
  public mutating func deQueue() -> T? {
    
    let topItem: T? = top?.value
    if topItem == nil {
      return nil
    }
    
    if let nextItem = top.next {
      top = nextItem
    } else {
      top = nil
      bottom = nil
    }
    
    return topItem
  }
  
  public func isEmpty() -> Bool {
    
    return top == nil ? true : false
  }
  
  public func peek() -> T? {
    return top?.value
  }
  
}
