//Big nerd Ranch - Swift development - Playground 16


import Cocoa

//########################################################################
// Part V - Advanced Swift
//########################################################################

//In this playground: Generics

struct IntegerStack
{
	private	var items = [Int]();
	
	mutating func push(_ newItem : Int)
	{
		items.append(newItem);
	}
	
	mutating func pop() -> Int?
	{
		guard !items.isEmpty else { return nil; }
		return items.removeLast();
	}
}

var stack = IntegerStack();
stack.push(11);
stack.push(22);
stack.pop();
stack.pop();
stack.pop();


struct Stack<T>
{
	private	var items = [T]();
	
	mutating func push(_ newItem : T)
	{
		items.append(newItem);
	}
	
	mutating func pop() -> T?
	{
		guard !items.isEmpty else { return nil; }
		return items.removeLast();
	}
}

var genericStack : Stack<Int> = Stack<Int>();
genericStack.push(101);
genericStack.push(102);
genericStack.pop();
genericStack.pop();
genericStack.pop();

var stringStack : Stack<String> = Stack();
stringStack.push("TestString");
stringStack.push("TestString2");
stringStack.pop();
stringStack.pop();
stringStack.pop();
