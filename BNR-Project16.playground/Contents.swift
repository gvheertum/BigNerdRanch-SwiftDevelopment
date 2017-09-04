//Big nerd Ranch - Swift development - Playground 16


import Cocoa

//########################################################################
// Part V - Advanced Swift
//########################################################################

//In this playground: Generics

//Test a stack without any generics
struct IntegerStack
{
	private	var items = [Int](); //This means copy-past parties all over the place, so generics will be very welcome here ;)
	
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

//ONTO THE GENERICS!!

protocol Sequence
{
	associatedtype Iterator : IteratorProtocol;
	func makeIterator() -> Iterator;
}

protocol IteratorProtocol
{
	associatedtype Element;
	mutating func next() -> Element?;
}


struct Stack<T> : Sequence
{
	typealias Element = T;
	
	private	var items = [T]();
	
	mutating func push(_ newItem : T)
	{
		items.append(newItem);
	}
	
	mutating func pushMany<S : Sequence>(_ sequence : S)
		where S.Iterator.Element == T
	{
		var iterator = sequence.makeIterator();
		while let item = iterator.next()
		{
			self.push(item);
		}
	}
	
	mutating func pop() -> T?
	{
		guard !items.isEmpty else { return nil; }
		return items.removeLast();
	}
	
	func map<U>(_ f: (T) -> U) -> Stack<U>
	{
		var mapped = Stack<U>();
		for item in items
		{
			mapped.push(f(item));
		}
		return mapped;
	}
	
	func makeIterator() -> StackIterator<T>
	{
		return StackIterator(stack: self);
	}
	
	func describe() -> String
	{
		var res = "[";
		for i in items
		{
			res += "\(i), ";
		}
		res += "]";
		return res;
	}
}


struct StackIterator<T> : IteratorProtocol
{
	//typealias Element = T;
	var stack: Stack<T>;
	
	//mutating func next() -> Element?
	mutating func next() -> T?  //This will be inferred by Swift to typealias Element = T
	{
		return self.stack.pop();
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

//Call mapping on a stack with numbers
var mappingTestStack : Stack<Int> = Stack();
mappingTestStack.push(1);
mappingTestStack.push(3);
mappingTestStack.push(5);
var squaredTestStack = mappingTestStack.map({ $0 * $0});
print(squaredTestStack);

var tmpStackIterator = squaredTestStack.makeIterator();
while let itemInIterator = tmpStackIterator.next()
{
	print(itemInIterator);
}


//Push many test
var pushManyStack : Stack<Int> = Stack();
pushManyStack.pushMany(mappingTestStack);
pushManyStack.pushMany(squaredTestStack);
print(pushManyStack.describe());

//MAPPING FUNCTIONS (TEST)
//Take array of T (items) convert T to U with F, yields array of U items
func myMapper<T, U>(_ items: [T], _ f : (T) -> (U)) -> [U]
{
	var uRes = [U]();
	for i in items
	{
		uRes.append(f(i));
	}
	return uRes;
}

func intToStr(_ i : Int) -> String
{
	return "\(i)";
}
var mappingRes = myMapper([1,2,3], intToStr);

