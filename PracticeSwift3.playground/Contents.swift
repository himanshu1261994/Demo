//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var str2 : String = "Hello world"
var value : Int = 12
var tupple : (String,String) = ("Hello","Hello2")
print(tupple.0)
print(tupple.1)

var myFirstArray : [Int] = []
myFirstArray.append(5)
myFirstArray.append(6)
myFirstArray.append(1)
myFirstArray.append(8)
myFirstArray.append(9)
myFirstArray.append(10)
myFirstArray.append(45)
myFirstArray.append(21)

myFirstArray.reverse()

myFirstArray.sort { (item1, item2) -> Bool in
    
    return item1 < item2
}

var arr : Array<Int> = Array()

arr = myFirstArray

for object in myFirstArray {

    
    
 
    
}
print(arr)









