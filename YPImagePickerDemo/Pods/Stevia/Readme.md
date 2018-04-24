# Stevia

### Natural sweetener for Swift
Stevia adds some convenient functions and syntax to Swift, with varying degrees of craziness. Use at your own risk.

### Closures
The `*` operator is overloaded to run a `() -> ()` closure multiple times.

```swift
3 * { print("Hello!") }
// Hello!
// Hello!
// Hello!
```

### Comparison operators
On a US keyboard  `≤`, `≥`, and `≠` are very easy to type (`option` + `<`, `>` or `=`), so Stevia adds these operators for concise, easy-to-read code.

```swift
let b = 1 ≠ 2
// true
let c = 1 ≤ 2
// true
let d = 1 ≥ 2
// false
```

### Arrays
Stevia overloads the addition operator for arrays so we can just add elements of the same type to them, no wrapping needed.

```swift
let primes = 2 + [3, 5, 7] + 11
// [2, 3, 5, 7, 11]
```

### Installation
Using [CocoaPods](http://cocoapods.org) 0.36 or above, add Stevia to your podfile:

```swift
pod 'Stevia'
```

### License
Copyright © 2015 [phelgo](https://twitter.com/phelgo). [MIT licensed.](http://www.opensource.org/licenses/MIT)
