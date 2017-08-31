//Big nerd Ranch - Swift development - Playground 11


import Cocoa

//########################################################################
// Part IV - Enumerations, Structures and Classes
// Copy on write
//########################################################################

//In this playground: Logic and reasoning behind copy on write

var str = "Hello, playground"

struct IntArray
{
	private var buffer : IntArrayBuffer;
	var name : String;
	init(name : String)
	{
		print("Constructing IntArray: \(name)");
		self.name = name;
		buffer = IntArrayBuffer();
	}
	
	func describe()
	{
		print("\(name): Buffer: \(buffer.storage)");
	}
	
	func insert(_ value : Int, at index: Int)
	{
		buffer.storage.insert(value, at: index);
	}
	func append(_ value : Int)
	{
		buffer.storage.append(value);
	}
	func remove(at index: Int)
	{
		buffer.storage.remove(at: index);
	}
}

fileprivate class IntArrayBuffer
{
	var storage: [Int];
	init()
	{
		print("Constructing IntArrayBuffer");
		storage = [];
	}
	init(buffer : IntArrayBuffer) //Init with an existing buffer
	{
		print("Constructing IntArrayBuffer with param buffer");
		storage = buffer.storage;
	}
}

print("Starting CopyOnWrite thingy");

var iList = IntArray(name: "List 1");
iList.append(1);
iList.append(5);
iList.append(6);
iList.describe();

var iList2 = iList;
iList2.name = "List 2";
iList2.append(7);
//By default the inner list is having an equal reference, while the value properties are copied
iList.describe(); //List 1: Buffer: [1, 5, 6, 7]
iList2.describe(); //List 2: Buffer: [1, 5, 6, 7]


print("** COPY ON WRITE*");

struct IntArrayWithCOW
{
	private var buffer : IntArrayBuffer;
	var name : String;
	init(name : String)
	{
		print("Constructing IntArrayCOW: \(name)");
		self.name = name;
		buffer = IntArrayBuffer();
	}
	
	private mutating func copyIfNeeded()
	{
		if !isKnownUniquelyReferenced(&buffer)
		{
			print("This is not a uniquely referenced element: let's make a copy");
		}
	}
	
	func describe()
	{
		print("\(name): Buffer: \(buffer.storage)");
	}
	
	mutating func insert(_ value : Int, at index: Int)
	{
		copyIfNeeded();
		buffer.storage.insert(value, at: index);
	}
	mutating func append(_ value : Int)
	{
		copyIfNeeded();
		buffer.storage.append(value);
	}
	mutating func remove(at index: Int)
	{
		copyIfNeeded();
		buffer.storage.remove(at: index);
	}
}


var iListCow = IntArrayWithCOW(name: "COW List 1");
iListCow.append(11);
iListCow.append(15);
iListCow.append(16);
iListCow.describe();

var iListCow2 = iListCow;
iListCow2.name = "COW List 2";
iListCow2.append(17);
iListCow.describe(); //List 1: Buffer: [1, 5, 6, 7]
iListCow2.describe(); //List 2: Buffer: [1, 5, 6, 7]
