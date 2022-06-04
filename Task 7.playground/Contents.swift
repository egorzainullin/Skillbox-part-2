// 2

import Foundation
class StringListNode {
    var value: String
    
    var next: StringListNode?
    
    init(value: String, next: StringListNode?){
        self.value = value
        self.next = next
    }
}

class StringList {
    private var head: StringListNode?

    init(values: [String]) {
        if values.count == 0 {
            self.head = nil
            
        }
        else {
            let arr = values.reversed()
            for i in arr {
                let current = head
                head = StringListNode(value: i, next: current)
            }
        }
    }
    
    func printList() {
        var current = head
        while (current != nil){
            print(current?.value ?? "")
            current = current?.next
        }
    }
    
    func contains(str: String) -> Bool {
        var current = head
        while (current != nil)
        {
            if let value = current?.value {
                if value == str {
                    return true
                }
                else {
                    current = current?.next
                }
            }
        }
        return false
    }
}

let strList = StringList(values: ["1", "2", "3"])
strList.printList()
strList.contains(str: "1")
strList.contains(str: "3")
strList.contains(str: "4")
                
// 3

class TreeElementNode {
    var value: String
    
    var left: TreeElementNode?
    var right: TreeElementNode?
    
    init(value: String, left: TreeElementNode?, right: TreeElementNode?) {
        self.value = value
        self.left = left
        self.right = right
    }
}

class BinTree {
    private var root: TreeElementNode?
    
    init(values: [String]) {
        for value in values {
            add(value: value)
        }
    }
    
    private func add(root: TreeElementNode, value: String) {
        if (root.value > value)
        {
            if let left = root.left
            {
                add(root: left, value: value)
            }
            else {
                root.left = TreeElementNode(value: value, left: nil, right: nil)
            }
        }
        else if (root.value < value)
        {
            if let right = root.right {
                add(root: right, value: value)
            }
            else {
                root.right = TreeElementNode(value: value, left: nil, right: nil)
            }
        }
        else {
            print("This element already exists")
        }
    }
    
    func add(value: String)
    {
        if let root = root {
            add(root: root, value: value)
        }
        else {
            root = TreeElementNode(value: value, left: nil, right: nil)
        }
        
    }
    
    private func printTree(root: TreeElementNode?) {
        if let root = root {
            printTree(root: root.left)
            print(root.value)
            printTree(root: root.right)
        }
    }
    
    func printTree()
    {
        printTree(root: root)
    }
    
    private func contains(root: TreeElementNode?, value: String) -> Bool {
        if let root = root {
            if root.value > value {
                return contains(root: root.left, value: value)
            }
            if root.value == value {
                return true
            }
            if root.value < value {
                return contains(root: root.right, value: value)
            }
        }
        return false
    }
    
    func contains(value: String) -> Bool {
        return contains(root: root, value: value)
    }
}

let tree = BinTree(values: ["2", "1", "3"])


tree.printTree()
tree.contains(value: "1")
tree.contains(value: "3")

tree.contains(value: "4")

// 4

class EdgeEnd {
    var time: Double
    
    var nodeName: String
    
    init(time: Double, nodeName: String) {
        self.time = time
        self.nodeName = nodeName
    }
}


class Node: CustomStringConvertible {
    var description: String { return ds() }
    
    func ds() -> String {
        var toDescription = ""
        for edge in edges {
            toDescription += "(\(edge.nodeName), \(edge.time))"
        }
        return toDescription
    }
    
    var edges: [EdgeEnd]
    
    var nodeName: String
    
    init(nodeName: String, edges: [EdgeEnd]) {
        self.nodeName = nodeName
        self.edges = edges
    }
}

class Graph {
    var nodesDic: Dictionary<String,Node> = [:]
    
    init(nodes: [Node]) {
        for node in nodes {
            nodesDic[node.nodeName] = node
        }
    }
    
    func printGraph(){
        for (name, node) in nodesDic {
            print("\(name): \(node)")
        }
    }
    
}


func findPath(graph: Graph, start: String, end: String) -> [String]? {
    var parents = [String : Node]()
    let nodesDic = graph.nodesDic
    var visited = [String : Bool]()
    for (name, _) in nodesDic {
        visited[name] = false
    }
    func preorder(root: Node) {
        visited[root.nodeName] = true
        for edge in root.edges {
            if let v = visited[edge.nodeName], !v {
                parents[edge.nodeName] = root
                if let newRoot = nodesDic[edge.nodeName]
                {
                    preorder(root: newRoot)
                }
            }
        }
    }
    if let node = nodesDic[start] {
        preorder(root: node)
    }
    func findReversedPath() -> [String]? {
        var nodeList = [String]()
        if var parent = parents[end]
        {
            nodeList.append(end)
            while (parent.nodeName != start) {
                nodeList.append(parent.nodeName)
                parent = parents[parent.nodeName]!
            }
            nodeList.append(start)
            return nodeList
        }
        return nil
        
    }
    return findReversedPath()?.reversed()
}

let node1 = Node(nodeName: "1", edges: [EdgeEnd(time: 1, nodeName: "2")])
let node2 = Node(nodeName: "2", edges: [EdgeEnd(time: 2, nodeName: "3"), EdgeEnd(time: 3, nodeName: "4")])
let node3 = Node(nodeName: "3", edges: [])
let node4 = Node(nodeName: "4", edges: [EdgeEnd(time: 5, nodeName: "5"), EdgeEnd(time: 2, nodeName: "6"), EdgeEnd(time: 3, nodeName: "7")])
let node5 = Node(nodeName: "5", edges: [])
let node6 = Node(nodeName: "6", edges: [])
let node7 = Node(nodeName: "7", edges: [])
let graph = Graph(nodes: [node1, node2, node3, node4, node5, node6, node7])

graph.printGraph()
print(findPath(graph: graph, start: "1", end: "7") ?? "")

// 5
extension Array where Element: Comparable {
    func insertSort() -> [Element] {
        var arr = self
        let n = arr.count
        for i in 1..<n {
            var j = i
            while (j > 0) && (arr[j-1] > arr[j]) {
                let temp = arr[j-1]
                arr[j-1] = arr[j]
                arr[j] = temp
                j -= 1
            }
        }
        return arr
    }
    
    func qsort() -> [Element] {
        let arr = self
        let n = arr.count
        if n == 0 || n == 1 {
            return arr
        }
        let h = arr[0]
        let arr1 = arr.filter({$0 < h}).qsort()
        let arr2 = arr.filter({$0 > h}).qsort()
        return arr1 + [h] + arr2
    }
}

print([3, 1, 4, 7, 5, 9].insertSort())
print([3, 1, 4, 7, 5, 9].qsort())
