// 2
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
    
    func contains(value: String) {
        
    }
}

let tree = BinTree(values: ["1", "2", "3"])

print("-----------")

tree.printTree()
