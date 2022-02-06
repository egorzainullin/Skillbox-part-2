import UIKit

// 4
// Протокол - это лишь контракт, который обязуются реализовать классы / структуры / перчисления, класс же должен иметь реализацию. Протоколов может быть множество, суперкласс всегда один.

// 5 Как я понимаю, все, кроме кортежей, могут иметь множество протоколов

// 6 a
struct Cell {
    var x: Int
    var y: Int
}

protocol ComputerMoveDelegate {
    func computerMove(from: Cell, to: Cell)
}

protocol ComputerEngine {
    func playerMove(from: Cell, to: Cell)
    
    var delegate: ComputerMoveDelegate? { get set }
    
    var estimation: Double { get }
}

// 6 b
protocol Flyable
{
    func fly()
}

protocol Drawable {
    func draw()
}

class flyableAndDrawableClass: Flyable, Drawable {
    func fly() {
        print("I am flying")
    }
    
    func draw() {
        print("I can draw")
    }
}

// 8. Используются небольшие протоколы и структуры заместо классов. Можно из расширений протоколов как конструктор собирать другие.

// 7
extension CGRect {
    func center() -> CGPoint {
        let centerX = self.origin.x + self.width / 2
        let centerY = self.origin.y + self.height / 2
        return CGPoint(x: centerX, y: centerY)
    }
    
    func square() -> CGFloat {
        return self.width * self.height
    }
}

let rect = CGRect(x: 0, y: 10, width: 30, height: 40)
print(rect.center())
print(rect.square())

extension UIView {
    func hideAnimated() {
        UIView.animate(withDuration: 1.0, animations: {
            self.alpha = 0.0
        })
    }
}


// Не знаю, как написать, как в примере
extension Comparable {
    func bound<T: Comparable>(self: T, minValue: T, maxValue: T) -> T {
        if minValue <= self && self <= maxValue {
            return self
        }
        else if self < minValue {
            return minValue
        }
        else {
            return maxValue
        }
    }
}

extension Array where Element == Int {
    func sum() -> Int {
        var sum = 0
        let n = self.count
        for i in 0..<n {
            sum += self[i]
        }
        return sum
    }
}

print([1, 2, 3].sum())
