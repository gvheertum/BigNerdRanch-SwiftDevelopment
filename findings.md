# Personal findings and notes
Please note that there are from a standpoint of a developer with .NET development experience and therefor might use terms related to .NET or use comparisons to .NET.

## IDE
- When you want to view details regarding a var, you can use alt-click (described as option-click in the book), this will show a popout with information about the variable (like the type).
- In the menu Help -> Documentation and API reference you can find details regarding the language and libraries.

## General
- For readability numeric values can be split with a 1000 separator (_) -> 9_001
- Naming conventions seem to prefer lowerCamelCase (e.g. enum values, struct properties) 
- Classes and structs allow nesting of other class, struct, enum items
- Swift does not enforce the filename to be equal to the classes nor does it enforce a single class per file
- Crash and burn can be done with fatalError("Errmsg")
- If you are sure the return type is not nil (even if the type return is nullable), you can add a ! to the end of the call:
var myVar : MyType = MyType()!; //In case MyType returns MyType? through a failable init
- guard statements are used like asserst, but I am still not sure why I should do:
```swift
    guard pop > 0 else { return nil}
    //instead of
    if(pop > 0) { return nil; }
    //The first is a bit better for reading, since we ensure something`
```
- Because parameters are named these are used for the signature. Swift allows overrides based on names rather than types (where .NET fails if the signature is equal based on types)
- Ref and value types work as expected (explained in chapter 18), even linking ref types in value types keeps them a ref.
- Copies are by default shallow (so an array copy will copy the array references and not the objects in the array)
- Pointer checks are done with ===, == will perform a value compare
- Ranges (x..y) cover x and y in the result, if you want to extract the last one (e.g. in iterator) use x ..< array.length
- The toString()-esque function is in the CustomStringConvertible.description : string int the CustomStringConvertible protocol
- assert and precondition can be used to make assertions before calling. These will result in an exception (unlike guard)
- while let nextCharacter = functionThatReturnsItems() -> This will run while the return is not nil, returning nil will terminate, great for iterators (or everything else with next(), pop(), whatever)
- Ranges also work with other stuff (like strings: case "0" ... "9":)
- In case of namespace conflicts (naming a var similar to a Swift var) can be fixed by explicitly use the Swift. namespace (like Swift.Error)
- Type aliasses can be used as replacements for base types, by saying typealias MyAlias = Double, you are allowed to use MyAlias as identifier instead of double, unlike inheriting from double this allows you to use double <-> myalias vars in any combination (from double -> myalias and v.v.)
- You can extend known types through:
```swift
    extension Velocity
	{
		var speedInMph : Velocity { return self / 1.60934; }
		var speedInKmh : Velocity { return self; }
	}
```
- Extensions can also include init functions, the init can use self.init to call internal constructors
- Extensions can also include enums and internal classes as part of the definition (which can then be used by the extension code)
- The extended elements are not visible in the object to string notation (so like .NET they are not really part of the object it seems)
- Extensions can be used to set a conformance (by using an inherit in the extension)
- You can have multiple extension definitions for one type
- Generics work like they do in .NET by specifying MyType<T>, where you can use T throught the class/enum to indicate the generic element type
- Variables of generics need to be flagged with the explicit <T>, however you can use the constructor without the type:
	var obj : GenericClass<String> = GenericClass();
- Generic constraints are placed in the <> notation, func functionWithGeneric<T : ElementTNeedsToInheritFrom>();
- You can use the where to check for additional type matches (like properties that need to match a certain type). Sample below ensures that the Element in the Iterator of the Sequence class matches the type T we have in our class
```swift
    mutating func pushMany<S : Sequence>(_ sequence : S)
		where S.Iterator.Element == T`
```
- Extensions can be limited via where constructions
```swift
    extension Sequence where Iterator.Element == Excercise { } //Limits the extension to only be implemented for Sequences with the Excercise as element`
```
- Through extensions you can set default (for example for the description), which can be overriden in implementor classes or extensions on those classes. The most specific item will be called
- Extensions cannot redefine items set in the class itself (if we have description in the class, we cannot use an extension to redefine this element), implementing more-specific implementations (if the parent has a definition) is allowed
- Extensions with default implementations can yield "confusing" results if there is an extensions on a class and a child element also uses the same variable name. Swift will yield the implementation belonging to the type you have at hand at that moment. If we type the element as the parent, the parent part is shown, if we type the var as the child the child logic is used. This is kinda similar to the .NET working of explicit interfaces and the use of new (instead of override), .NET will also call the function related to the type at hand. The book uses an example with a var using a getter (string compose) in the parent and a simple string var in the child.


## Exception Handling
- Exceptions are called Errors (inheriting from Error) and are upped by throw xxx()
- Like Java, you need to indicate that a function can throw an exception func myFunc() throws -> returnType. Throw functions need to throw themselves OR have the error handling in place.
- Exception catching via do { try throwingFunction(); } catch {} //Note the do block and the try before the failing function. 
- The try is required to provide in before the function call to a throwable
- A try should be used in a do - catch block, however you can ommit the do catch by using try! functionCall()
- Asserts do not require a catch construction, the catch is only required for the functions explicitly using throw
- The catch will automatically have the var error at your disposal (does not need to be specified in the catch)
- Specific errors can be catched by specifying the type:
    catch Item1.Enum1.enumVal(let var); //This allows you to catch enumVal types of Enum1 in the struct Item1. The enumVal is defined to have a parameter, which can be caught with the let
- Convention seems to have the Error as inner enum in the class using it (Parser.Error for example)
- Guard and try? can be used to do an inline guard try block
    guard let myVar = try? codeThatCanThrow() else {}
- The catch { } is required since the exception system requires you to be exhaustive when catching, thus having a case for a catch all is required (even if you think you catched all thrown types) 

## Protocols (similar to Interfaces)
- Interfaces are called Protocols, inheritance is like regular inheritance (x : y), multiple protocols can be implemented
- mutating is part of the protocol description for struct items that mutate the state (so the protocol needs to flag the element as mutating)
- Protocols cannot be made generic (unlike the interface equivalent in .NET which is able to be generic), however there is an option using associated type. Associated types can constraints like generics by having : and parent after the name (Element : InheritFromThisClass)
```swift
    protocol IteratorProtocol
    {
        associatedtype Element;
        mutating func next() -> Element?
    }
    //In the implementation you set a typealias to refer to element. This informs that the Element is T.
    struct StackIterator<T> : IteratorProtocol
    {
        typealias Element = T;
        mutating func next() -> Element? { return self.stack.pop(); }
    }
```
- In the typealias example the typealias can also be inferred by Swift, if we use the type in a place where the Protocol has the associatedtype defined, it will resolve into that type
```swift
    mutating func next() -> T? { return self.stack.pop(); } //Here Swift will infer the Element = T due to the usage of T? where the Element? was in the protocol.
```
- Protocols with a typealias cannot be used as concrete types, in our above example you cannot have var x : IteratorProtocol = DoSomething();
- Note that if you make a property in a protocol you cannot use {get;}, the semi-colon will yield an error, just use {get}
- Protocols can be extended to have behavior defined in them



## Enumerators
- Enums are not inheriting from any type by default (unlike .net which inherits from int by default)
- Enums funcs are by default immutable, however you can enalbe this by flagging the function as mutating
- Enums can do a whole lot more then we are used to. In Swift they can have functions, but also different values (like when working with shapes)
- Enums can have associated values. These are set through a constructor-like option when creating the value.
- The associated values cannot be read directly from variables (since they are of the enum type)
- Enums can also have recursion (which requires you to flag the enum or at least the recursive bits as inderect), the compiler otherwise needs to allocate enums in your enum without knowing the depth of the enum tree
- Although enum functions can be quite useful, the full recursion I would prefer doing in classes I think
- Enumerators can also be generic. Optional is an example of an enum that is wrapped:
```swift
    enum Optional<Wrapped>
    {
        case None
        case Some(Wrapped)
    }
```

## Struct
- Structs are initialized by StructName(). The new operator cannot be used.
- Struct funcs are by default not allowed to mutate data, like the enums they need to be flagged as mutating
- Mutating functions on structs can be captured in a variable by using the let structFunc = structname.function. The captured function can be fed a struct of the own type and that function can be called again:
```swift
    var p = Person();
    let changeName = Person.changeName; //type = (inout Person) -> (String, String) -> ()
    var changeNameForP = changeName(&p);
    changeNameForP("Harry", "de Testkabouter");
    p.introduce(); //This will update the p object we have (since we parsed a reference)
```
- If you do not defined default values for the struct variables (when the are flagged as let), swift will create a constructor for you
- References are copied as reference when structs are copied, meaning that the inner-elements of the structs point to the same item (as expected). The can be altered to create a copy via the "Copy on write" pattern. This pattern will check if the object in our struct is referencing to a unique element, if not we pull a copy. The call to the function checking this (a mutating function) should be done by all elements accessing the objectName property (this is similar to the EnsureXXX we often create in our .NET projects to ensure certain object state). Since the check and copy is a mutating func, the callers are therfore also mutating.
```swift
    private mutating func copyIfNeeded()
	{
		if !isKnownUniquelyReferenced(&propertyContainingReference) //Note the &
		{
			//Do the copy
		}
	}
```

## Classes
- No mandatory access modifiers (public/private/etc needed) -> Default behavior is internal
- Functions are overriden by adding an override to the function
- Calls to the parent class are done through super.[call]
- Override of set vars cannot be done with a simple override addition
- Final prevents override (unlike .net where override cannot be done if not virtual abstract), swift seems to always allow override unless otherwise specified (where .NET can use the new when no override is possible as a work around)
- Structs are copied by value, so altering a struct in your class will only alter the working copy of that element and not the "original", in the monster example this makes that the town in the main is having the old number of residents, while the town copy in the monster updates the number in the local town. This also explains why you should not use let x = nullable {} to work with structs, since updating values will update them locally in the temp var, not in the original.
- Structs have static funcs, classes have class funcs (and statics). These funcs are not created for each instance of the class, but are shared. Class funcs can be overriden (override class func ...), as long as they are not flagged as final (or when used static, since static cannot be overriden, so static func is functionally equal to final class func). The class/statics cannot be called on instances of the class since they are part of the type and not the instances.
- Constructors are called initializators and are defined by init(properties) { } in the class and struct, inits can delegate work to other inits by using self.init, unlike some other languages this call can be at the end of the function body, allowing us to setup certain stuff (while .NET uses constructor() : base() / this() which calls the constructor of this/base first before running the body). Please note that before being able to use super/self the init of that item NEEDS to be called before accessing the item.
- Constructors are inheritted from the parent class, meaning that the constructors of the parent class can be used to construct child classes (unlike .net where you are required to have something in the child to satisfy the parent class constructor). Even having own constructors in the child class does not remove the possiblity to use the parent call
```swift
    class A { init(x,y); } class B : A { }
    var t = B(x,y);
```
- You can require children to have their own version of the constructor by applying required to the init in the parent, this will force the child to have a constructor with the same signature.
- There is a special type of constructor that does not enforce setting values to all properties in the body (something the init normally enforces), this is the convenience indicator. This will suspend checking whether the properties are all set. This is most likely to be used when having "inheritance" to another constructor and therefor not setting the properties ourself.
```swift
    convenience init(a,b) { }
```
- When using convenience options, there is one init required that sets all let elements, and that one should be called by the convenience param
- Deconstructors are called deinit functions. These functions are called if all references are dropped, these functions are also called if the children are deconstructed (as expected)
```swift
    deinit { /*Do Stuff*/ } 
```
- If you want to fail in the constructor there is a technique called failing initalizers, these are flagged with init?(). This makes the return type a nullable type for this constructor.
- Chaining constructors (calling each other) all need to be failable if the parent is failing
- The self init needs to be called before setting self.var in the init function (super can be called whenever)

## Functional aspects
- Function returns can be written as:
```swift    
    return
    {
        (name : String) -> String in
        return "\(greeting), \(name)";
    };
```
 which will return a function taking a string argument and returning a string

## Properties and variables
* Lazy properties are properties that are set when called (not on init of the object/struct). This will set the property once (and only once) if the property is called
```swift
    lazy var townSize : TownSize =
	{}(); //Note that the {} are required
```
* The lazy makes the function using it mutating. Using this var from a non-mutating function in a struct will yield an compiler error.
* Swift also allows get{} set{} logic, like .NET for properties
```swift
    var prop : Type
    {
        get {}
        set(paramName) {}
    }
```
Set requires a paramnam, this will allow you to use names that make sense. The notation of the set is a bit differtent due to the requirement of the parametername. Also note that the parameter does not require a type (is inferred from the property)
* Properties support observer functions that are attached to the property and are fired when the property is changed (or at least the set is called, it doesnt check if the value is really changing)
```swift
    var propName : Type = [xxxx]
    {
        didSet(oldpropName)
        {
            //oldpropName contains the property value before the set
            //The function is called after setting, so the propName itself will contain the new value
        }
    }
```
* vars can be flagged as class, making them "staticy", the patern used for the class var is the pattern for lazy eval:
```swift    
    class var myVar : Type
    {
        return [xx];
    }
```
* making vars readonly is done on the definition of the var
	internal private(set) var myProperty = value; //this defines the property internal and the set private
* Properties can have a willSet element in the definition to perform certain checks upon setting the value (unlike the didSet this is done before checking)
```swift
	var prop : Double
	{
		willSet
		{
			precondition(newValue <= 1.0 && newValue >= 0, "Value need to be between 0 and 1)";
		}	
	} 
```
* The willset however does not seem to check on the init, if I put 33 there, it will just work and put 33 there