import UIKit
import Darwin

// 4. Для того, чтобы не писать один и тот же код для разных типов.

// 5. Ассоцииророванные типы используюся в протоколах.

// 6
func printIfEqual<T: Equatable>(firstValue:T, secondValue: T) {
    if firstValue == secondValue {
        print("They are equal!")
    }
    else {
        print("they are not equal")
    }
}

func printMax<T: Comparable>(firstValue: T, secondValue: T) {
    if firstValue >= secondValue {
        print(firstValue)
    }
    else {
        print(secondValue)
    }
}

func minInFirstMaxInSecond<T: Comparable>(firstValue: inout T, secondValue: inout T) {
    
    if firstValue >= secondValue {
        let temp = firstValue
        firstValue = secondValue
        secondValue = temp
    }
}

var a = 2
var b = 1
minInFirstMaxInSecond(firstValue: &a, secondValue: &b)
print(a, b)

func comfg<T>(f: @escaping (T) -> Void, g: @escaping (T) -> Void) -> ((T) -> Void) {
    return {
        a in
        f(a)
        g(a)
    }
}

let f = { a in print(a)}
let g = f

comfg(f: f, g: g)(5)

// 7
extension Array where Element: Comparable {
    func max() -> Element {
        var max = self[0]
        for i in 1..<self.count {
            if max < self[i] {
                max = self[i]
            }
        }
        return max
    }
}

extension Array where Element: Equatable {
    mutating func distinct(){
        var i = 0
        while (i < self.count) {
            var j = i + 1
            while (j < self.count) {
                if self[j] == self[i] {
                    self.remove(at: j)
                }
                else {
                    j += 1
                }
            }
            i += 1
        }
    }
}

var arr = [1, 2, 1, 3, 2]
arr.distinct()

// 8
infix operator ^^

func ^^(x: Int, n: Int) -> Int {
    var degree = 1
    for _ in 0..<n {
        degree *= x
    }
    return x
}

infix operator ~>

func ~> (a: Int, to: inout Int) {
    to = 2 * a
}

infix operator <*

extension UIViewController: UITableViewDelegate {
    
}

func <*(controller: UIViewController, table: UITableView) {
    table.delegate = controller
}

func +(a: CustomStringConvertible, b: CustomStringConvertible) -> CustomStringConvertible {
    return "\(a)\(b)"
}

protocol Animator {
    associatedtype Value
    associatedtype Target
    
    init(_ value: Value)
    
    func animate(target: Target)
}

class BackgroundAnimator: Animator {
    typealias Value = UIColor
    
    typealias Target = UIView
    
    let newColor: UIColor
    
    required init(_ value: UIColor) {
        newColor = value
    }
    
    func animate(target: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            target.backgroundColor = self.newColor
        })
    }
}

class CenterAnimator: Animator {
    typealias Value = CGPoint
    
    typealias Target = UIView
    
    let newCenter: CGPoint
    
    required init(_ value: CGPoint) {
        newCenter = value
    }
    
    func animate(target: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            target.center = self.newCenter
        })
    }
}

class ScaleAnimator: Animator {
    typealias Value = CGPoint
    
    typealias Target = UIView
    
    let newScale: CGPoint
    
    required init(_ value: CGPoint) {
        newScale = value
    }
    
    func animate(target: UIView) {
        UIView.animate(withDuration: 0.3) {
            target.transform.scaledBy(x: self.newScale.x, y: self.newScale.y)
        }
    }
}
