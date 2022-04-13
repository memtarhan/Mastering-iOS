import Combine
import UIKit

// MARK: - Combine workflow

/*

 1 - The Subscriber tells the Publisher that it wants to subscribe. The Publisher sends back a subscription. The Subscriber uses that subscription to start requesting elements. The subscriber can request from N to unlimited values.
 2 - Now the Publisher is free to send those values over time. The Subscriber will receive those inputs.
 3 - In subscriptions that are not expecting unlimited values, a completion event is sent to the Subscriber, so it is aware that the subscription is over.

 */

let publisher = [1, 2, 3, 4].publisher
/// We use the method sink to attach a subscriber to the publisher, defining inside its completion block an action to perform over each value received over time.
let subscriber = publisher.sink { element in
    print(element)
}

print("*******************")

// Using filter
/// The filter operator is used to just remove values matching some condition out of the stream.

let evenNumbersSubscriber = publisher
    .filter { $0 % 2 == 0 }
    .sink { print($0) }

print("*******************")

// Using map
/// The map operator helps us to apply a certain operation to every value of the stream, transforming it into a different type.

struct User: CustomStringConvertible {
    var id: Int

    var description: String { "User with id: \(id)" }
}

let mappedSubscriber = publisher
    .map { User(id: $0) }
    .sink { print($0.description) }

print("*******************")

// Using reduce
/// The reduce operator returns the result of combining all the values of the stream using a given operation to apply.

let reduceExample = [1, 2, 3, 4].publisher
    .reduce(1, { $0 * $1 })
    .sink(receiveValue: { print("\($0)", terminator: " ") })

print("*******************")

// Using scan
/// An operator very much related to reduce is scan. The scan operator does exactly the same as reduce but it emits the result at each step

let scanExample = [1, 2, 3, 4].publisher
    .scan(1, { $0 * $1 })
    .sink(receiveValue: { print("\($0)", terminator: " ") })
