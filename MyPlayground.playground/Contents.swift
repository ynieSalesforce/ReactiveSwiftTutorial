import UIKit
import ReactiveCocoa
import ReactiveSwift
import Overture


//Filter example
let (filterSignal, filterObserver) = Signal<Int, Error>.pipe()

filterSignal.filter{ number in number % 2 == 0 }.observe { (event) in
    guard let value = event.value else { return }
    print("Filtered Value: \(value)")
}

filterObserver.send(value: 1)
filterObserver.send(value: 2)
filterObserver.send(value: 3)
filterObserver.send(value: 4)

//combineLatest Example

let (numbersSignal, numbersObserver) = Signal<Int, Error>.pipe()
let (lettersSignal, lettersObserver) = Signal<String, Error>.pipe()

let combineLatestSignal = Signal.combineLatest(numbersSignal, lettersSignal)
combineLatestSignal.observe { event in
    guard let value = event.value else { return }
    print("Combine Latest Int: \(value.0), String: \(value.1)")
}

combineLatestSignal.observeCompleted {
    print("both signals complete")
}

//numbersSignal.combineLatest(with: lettersSignal).observe { event in
//    guard let value = event.value else { return }
//    print("Int: \(value.0), String: \(value.1)")
//}

//Zip Example. Zip will "pair up" events to each other

let zipSignal = Signal.zip(numbersSignal, lettersSignal)
zipSignal.observe { event in
    guard let value = event.value else { return }
    print("Zip Int: \(value.0), String: \(value.1)")
}
zipSignal.observeCompleted {
    print("both signals complete")
}
numbersObserver.send(value: 0)
numbersObserver.send(value: 1)
lettersObserver.send(value: "A")
numbersObserver.send(value: 2)
lettersObserver.send(value: "B")
numbersObserver.sendCompleted()
lettersObserver.send(value: "C")
lettersObserver.send(value: "D")
lettersObserver.sendCompleted()
