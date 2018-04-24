//: Playground - noun: a place where people can play

import UIKit

print("------Linear search algorithm------------------")
print("Inputs")
var searchElementLinearSearch = 5
var linearSearchArr = [3,4,9,1,4,5,7,8,0,6]

print("Proccess")
func linearSearchWithSearchElement(element : Int,andData : [Int]) -> Int?{
    
    for (index,elementOfArr) in andData.enumerate()
    {
        if elementOfArr == element{
            return index
        }
        
    }
    
    return nil
}
var searchElementIndex : Int = linearSearchWithSearchElement(searchElementLinearSearch, andData: linearSearchArr)!
print("Proccess")
print("Output : Index : \(searchElementIndex)  ")

print("-------Linear search algorithm------------------")






print("-------Binary search algorithm------------------")

let searchElementBinarySearch : Int = 2
print("Input : \(searchElementBinarySearch)")
var binarySearchArr : [Int] = []

for index in 0...99{

    binarySearchArr.append(index)

}
print(binarySearchArr)


print("Proccess")
func binarySearchWithSearchElement(searchElement : Int , data : [Int
    ]) -> Int? {
    
    var leftElementIndex : Int = 0
    var rightElementIndex : Int = data.count - 1
    
    
    while leftElementIndex <= rightElementIndex {
        
        
        let middleElementIndex : Int = (leftElementIndex + rightElementIndex) / 2
        let middleValue : Int = data[middleElementIndex]
        
        if middleValue == searchElement{
            
            return middleElementIndex
        }
        if searchElement < middleValue {
            rightElementIndex = middleElementIndex - 1
        }
        if searchElement > middleValue{
            leftElementIndex = middleElementIndex + 1
        }
    }
    
    return nil
    
}
let searchIndex  = binarySearchWithSearchElement(searchElementBinarySearch, data: binarySearchArr)

if searchIndex == nil{
    print("Output : Searched value is not in the array.")
}else{
    print("Output : Index \(searchIndex)")
}

print("--------Binary search algorithm------------------")

print("--------Binary search algorithm with recursion------------------")
func binarySearchWithSearchElement(searchElement : Int, data : [Int],startIndex : Int,endIndex : Int ) -> Int? {
    
    
    let middleIndex : Int = (startIndex + endIndex) / 2
    let middleValue : Int = data[middleIndex]
    

    if searchElement < middleValue {
        return binarySearchWithSearchElement(searchElement, data: data, startIndex: startIndex, endIndex: middleIndex - 1)
        
    }
    if searchElement > middleValue {
        return binarySearchWithSearchElement(searchElement, data: data, startIndex: middleIndex + 1, endIndex: endIndex)
    }
    return middleIndex
}

let searchIndexRecursion = binarySearchWithSearchElement(34, data: binarySearchArr, startIndex: 0, endIndex: binarySearchArr.count - 1)
print(searchIndexRecursion)
print("--------Binary search algorithm with recursion------------------")




print("-------Hacker Rank Practice---------")
var mealCost : Double = 15.50
var tipPercent : Int = 15
var taxPercent : Int = 10

var tip = mealCost * Double(tipPercent)/100
var tax = mealCost * Double(taxPercent)/100
var totalCost = mealCost + tip + tax
print(round(totalCost))


print("-------Hacker Rank Practice---------")


var numberOfInputs : Int = 10
var dataArr : [String] = []
for index  in 0..<numberOfInputs{

    var strOne : String = "Himanshu"
    dataArr.append(strOne)
    

}

func slipStringWithArray(data : String) -> String {
    
    let dataArray : Array<Character> = Array(data.characters)
    
    var leftStr : String = ""
    var rightStr : String = ""
    
    for (index,character) in dataArray.enumerate() {
       
        if index%2 == 0 {
               leftStr = leftStr + "\(character)"
           
        }else{
            // odd
            rightStr = rightStr + "\(character)"
        }
    }
    return leftStr + " " + rightStr
}


for (index,character) in dataArr.enumerate(){

    print(slipStringWithArray(character))


}

print("-------Hacker Rank Practice---------")

let inputValue1 : Int = 3


if inputValue1%2 == 1 || (inputValue1 > 5 && inputValue1 < 21){
    print("Weird")
}else {
    print("Not Weird")
}
print("-------Hacker Rank Practice---------")
class Person {
    var age: Int = 0
    
    init(initialAge: Int) {
        // Add some more code to run some checks on initialAge
        
        if initialAge < 0 {
            print("Age is not valid, setting age to 0.")
        }else{
            age = initialAge
            
        }
        
    }
    
    func amIOld() {
        // Do some computations in here and print out the correct statement to the console
        if age < 13 {
            print("You are young.")
        }else if age >= 13 && age < 18 {
            print("You are a teenager.")
        }else{
            print("You are old.")
        }
    }
    
    func yearPasses() {
        // Increment the age of the person in here
        age += 1
    }
}

let p = Person(initialAge: -1)
p.amIOld()
for index in 0..<10{
p.yearPasses()
}
p.amIOld()
print("-------Hacker Rank Practice---------")

let value : Int = 12

for index in 1...10{


    print("\(value) x \(index) = \(value * index)")
    
    
}

print("-------Hacker Rank Practice---------")

let inputValue2 : Int = 3

for index in 0..<inputValue2{

    
    

}



