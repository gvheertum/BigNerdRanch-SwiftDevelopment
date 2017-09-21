# Personal findings and notes
Please note that there are from a standpoint of a developer with .NET development experience and therefor might use terms related to .NET or use comparisons to .NET.

### IDE
- When you want to view details regarding a var, you can use alt-click (described as option-click in the book), this will show a popout with information about the variable (like the type).
- In the menu Help -> Documentation and API reference you can find details regarding the language and libraries.

### General
- For readability numeric values can be split with a 1000 separator (_) -> 9_001
- Naming conventions seem to prefer lowerCamelCase (e.g. enum values, struct properties) 
- Classes and structs allow nesting of other class, struct, enum items
- Swift does not enforce the filename to be equal to the classes nor does it enforce a single class per file
- Crash and burn can be done with fatalError("Errmsg")
- If you are sure the return type is not nil (even if the type return is nullable), you can add a ! to the end of the call:
var myVar : MyType = MyType()!; //In case MyType returns MyType? through a fail-able init
- The ! operator on nullables can be used like the .Value in .NET, this will force the element to use the value of the optional instead of the optional (like .NET this yields an error if the type IS nil)
- guard statements are used like asserts, but I am still not sure why I should do:
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
- Type aliases can be used as replacements for base types, by saying typealias MyAlias = Double, you are allowed to use MyAlias as identifier instead of double, unlike inheriting from double this allows you to use double <-> myalias vars in any combination (from double -> myalias and v.v.)
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
- Generics work like they do in .NET by specifying MyType<T>, where you can use T through the class/enum to indicate the generic element type
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
- Through extensions you can set default (for example for the description), which can be overridden in implementor classes or extensions on those classes. The most specific item will be called
- Extensions cannot redefine items set in the class itself (if we have description in the class, we cannot use an extension to redefine this element), implementing more-specific implementations (if the parent has a definition) is allowed
- Extensions with default implementations can yield "confusing" results if there is an extensions on a class and a child element also uses the same variable name. Swift will yield the implementation belonging to the type you have at hand at that moment. If we type the element as the parent, the parent part is shown, if we type the var as the child the child logic is used. This is kinda similar to the .NET working of explicit interfaces and the use of new (instead of override), .NET will also call the function related to the type at hand. The book uses an example with a var using a getter (string compose) in the parent and a simple string var in the child.
- If the last parameter in the parameters is a function we can use 2 notations (in this example the param is (Double) -> Void):
```swift
    el?.functionToCall() { nw in print("Value of NW: \(nw)"); };
    el?.functionToCall(callFunc: { nw in print("Value of NW: \(nw)"); });
```
- Operator overloading is done by creating a static func OPERATOR(left: type, right: type)  (e.g. static func ==(left: element, right: element) -> Bool)
- The way the == works is called infix (placing the operator between 2 items)
- The usage of @ elements in the code indicates attributes, these can be applied to many items like: properties, functions and input parameters
- Next to optional properties you can have something like: var bla : String!, which is called a "implicitly-unwrapped optional String". The var can set as Optional, however every usage will be treated as explicit unwrap (bla.call is mapped to -> bla!.call).
- Casting in Swift is done with the ```let varOfNewType = varOfOldType as TypeWeWant``` when using as? we get a nil if the cast fails (so the basic xxx as yyy in .NET working), in this case the var is of type TypeWeWant? (Optional)
- There is also the option to use as! for casting, hthis will directly unwrap the result, so the resuslt is TypeWeWant
- Using the as (without ? or !), will only work for types that the compiler can guarantee
- Like most languages swift allows you to use the parentheses to define "blocks" in the code (e.g. for casting: ```(windowController.contentViewController as! ViewController).textView.string = contents;```) 
- Swift 4 offers the option to use a string over multiple lines, this is achieved by using tripple quotes. Indentation is matched with the indent of the closing quotes (so 2 tabs there means that 2 tabs are trimmed from the content), where the indent of the text in the block needs to be at-least at the level of the last quotes (so the indentation will not go negative).

### Exception Handling
- Exceptions are called Errors (inheriting from Swift.Error) and are upped by throw xxx()
- Like Java, you need to indicate that a function can throw an exception func myFunc() throws -> returnType. Throw functions need to throw themselves OR have the error handling in place.
- Exception catching via do { try throwingFunction(); } catch {} //Note the do block and the try before the failing function. 
- The try is required to provide in before the function call to a throwable
- A try should be used in a do - catch block, however you can omit the do catch by using try! functionCall()
- Asserts do not require a catch construction, the catch is only required for the functions explicitly using throw
- The catch will automatically have the var error at your disposal (does not need to be specified in the catch)
- Specific errors can be catched by specifying the type:
    catch Item1.Enum1.enumVal(let var); //This allows you to catch enumVal types of Enum1 in the struct Item1. The enumVal is defined to have a parameter, which can be caught with the let
- Convention seems to have the Error as inner enum in the class using it (Parser.Error for example)
- Guard and try? can be used to do an inline guard try block
    guard let myVar = try? codeThatCanThrow() else {}
- The catch { } is required since the exception system requires you to be exhaustive when catching, thus having a case for a catch all is required (even if you think you catched all thrown types) 
- Coding guidelines suggest inheriting from LocalizedError to be able to use more user-friendly messages, this will require you to implement the failureReason string property
- Division of integers result in an Integer result. To be able to use floating point you need to cast them to doubles ```var res : Double = Double(characterRange.location) / Double(string.characters.count)```

### Protocols (similar to Interfaces)
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



### Enumerators
- Enums are not inheriting from any type by default (unlike .net which inherits from int by default)
- Enums funcs are by default immutable, however you can enable this by flagging the function as mutating
- Enums can do a whole lot more then we are used to. In Swift they can have functions, but also different values (like when working with shapes)
- Enums can have associated values. These are set through a constructor-like option when creating the value.
- The associated values cannot be read directly from variables (since they are of the enum type)
- Enums can also have recursion (which requires you to flag the enum or at least the recursive bits as indirect), the compiler otherwise needs to allocate enums in your enum without knowing the depth of the enum tree
- Although enum functions can be quite useful, the full recursion I would prefer doing in classes I think
- Enumerators can also be generic. Optional is an example of an enum that is wrapped:
```swift
    enum Optional<Wrapped>
    {
        case None
        case Some(Wrapped)
    }
```
- Functions in enumerators can refer the it's own instance
```swift
    enum MyEnum
    {
        case myCase;
        case myCase2;
        var caseDescription : String
        {
            switch self
            {
                .myCase: return "Case 1";
                .myCase2: return "Case 2";
            }
        }
    }
```
- Protocols can have optional functions, which are not required to be implemented when extendiing the protocol

### Struct
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
- References are copied as reference when structs are copied, meaning that the inner-elements of the structs point to the same item (as expected). The can be altered to create a copy via the "Copy on write" pattern. This pattern will check if the object in our struct is referencing to a unique element, if not we pull a copy. The call to the function checking this (a mutating function) should be done by all elements accessing the objectName property (this is similar to the EnsureXXX we often create in our .NET projects to ensure certain object state). Since the check and copy is a mutating func, the callers are therefor also mutating.
```swift
    private mutating func copyIfNeeded()
	{
		if !isKnownUniquelyReferenced(&propertyContainingReference) //Note the &
		{
			//Do the copy
		}
	}
```

### Classes
- No mandatory access modifiers (public/private/etc needed) -> Default behavior is internal
- Functions are overridden by adding an override to the function
- Calls to the parent class are done through super.[call]
- Override of set vars cannot be done with a simple override addition
- Final prevents override (unlike .net where override cannot be done if not virtual abstract), swift seems to always allow override unless otherwise specified (where .NET can use the new when no override is possible as a work around)
- Structs are copied by value, so altering a struct in your class will only alter the working copy of that element and not the "original", in the monster example this makes that the town in the main is having the old number of residents, while the town copy in the monster updates the number in the local town. This also explains why you should not use let x = nullable {} to work with structs, since updating values will update them locally in the temp var, not in the original.
- Structs have static funcs, classes have class funcs (and statics). These funcs are not created for each instance of the class, but are shared. Class funcs can be overridden (override class func ...), as long as they are not flagged as final (or when used static, since static cannot be overridden, so static func is functionally equal to final class func). The class/statics cannot be called on instances of the class since they are part of the type and not the instances.
- Constructors are called initializators and are defined by init(properties) { } in the class and struct, inits can delegate work to other inits by using self.init, unlike some other languages this call can be at the end of the function body, allowing us to setup certain stuff (while .NET uses constructor() : base() / this() which calls the constructor of this/base first before running the body). Please note that before being able to use super/self the init of that item NEEDS to be called before accessing the item.
- Constructors are inherited from the parent class, meaning that the constructors of the parent class can be used to construct child classes (unlike .net where you are required to have something in the child to satisfy the parent class constructor). Even having own constructors in the child class does not remove the possibility to use the parent call
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
- If you want to fail in the constructor there is a technique called failing initializers, these are flagged with init?(). This makes the return type a nullable type for this constructor.
- Chaining constructors (calling each other) all need to be failable if the parent is failing
- The self init needs to be called before setting self.var in the init function (super can be called whenever)

### Functional aspects
- Function returns can be written as:
```swift    
    return
    {
        (name : String) -> String in
        return "\(greeting), \(name)";
    };
```
 which will return a function taking a string argument and returning a string

### Properties and variables
- Lazy properties are properties that are set when called (not on init of the object/struct). This will set the property once (and only once) if the property is called
```swift
    lazy var townSize : TownSize =
	{}(); //Note that the {} are required
```
- The lazy makes the function using it mutating. Using this var from a non-mutating function in a struct will yield an compiler error.
- Swift also allows get{} set{} logic, like .NET for properties
```swift
    var prop : Type
    {
        get {}
        set(paramName) {}
    }
```
Set requires a paramnam, this will allow you to use names that make sense. The notation of the set is a bit different due to the requirement of the parametername. Also note that the parameter does not require a type (is inferred from the property)
- Properties support observer functions that are attached to the property and are fired when the property is changed (or at least the set is called, it doesnt check if the value is really changing)
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
- vars can be flagged as class, making them "static-y", the pattern used for the class var is the pattern for lazy eval:
```swift    
    class var myVar : Type
    {
        return [xx];
    }
```
- making vars readonly is done on the definition of the var
	internal private(set) var myProperty = value; //this defines the property internal and the set private
- Properties can have a willSet element in the definition to perform certain checks upon setting the value (unlike the didSet this is done before checking)
```swift
	var prop : Double
	{
		willSet
		{
			precondition(newValue <= 1.0 && newValue >= 0, "Value need to be between 0 and 1)";
		}	
	} 
```
- The willset however does not seem to check on the init, if I put 33 there, it will just work and put 33 there\

### Garbage collection (See GarbageTown example)
- The deinit will be called if all references are lost to a certain instance
- The deinit will not be called if there are circular references (Person has 0..* assets, Asset has 0..1 person). Setting one of the items to nil will not toggle the deinit. Even if you reset the person and the asset var (the temporary one created to insert into the person), since the reference is still in the original person the count stays > 0. This is due to the strong reference principle in Swift. By adding a ref in the asset to the person, the person reference count will be incremented with 1 (meaning that if the main var is deallocated, the counter still > 0)
- In swift you can flag a reference as weak, meaning this will not increment the count. In the asset/person case, the asset will have a weak var to the person since we do not want to keep the assets alive if the person is deallocated (due to the 0..1 relation between asset and person).
```swift
    weak var owner : Person?;
```
- weak references can only be var and is always optional (to allow setting nil and deallocate)
- Be aware that if you set references yourself (so manually assigning the owner to the asset), the the owner is nilled at the moment the var of the owner is set to nil (since the reference count = 0 when deallocating that one), this might yield surprising results if you are not expecting this. Exposing the weak references therefor might not always be desirable.
- Please be aware that the self reference can also cause issues when used in a closure, this links self to the other object causing a circular reference.
- Reference count cannot be requested by hand (or at least not via a trivial way), this is partially due to Swift being allowed to get creative with the counts and assign stuff when he likes. You can however use the isKnownUniquelyReferenced(item) function to see if you are the only one referencing elements at a given momen.

### Event handlers
- You can use typealias to define a function signature to make events more readable
- After defining the event alias you can make a variable of that type (and set it to nil if required)
- The variable with the event type can be called as function (with a nil-propagation call)
```swift
    typealias NetWorthChanged = (Double) -> Void;
	var netWorthChangedHandler: NetWorthChanged? = nil;
	var netWorth: Double = 0.0
	{
		didSet
		{
			netWorthChangedHandler?(netWorth); 
		}
	}
```
- Assigning an event handler can be done by making an inline func (sample below sets the handler in the account var to a function having the nw variable for the double of the signature and calling the netWorthChanged in the class defining this handler)
```swift
    accountant.netWorthChangedHandler =
    {
        nw in
        self.netWorthChanged(to: nw); //By using self you will include a reference to the self in the closure, meaning the count is upped by one
        return;
    };
```
- Regarding the use of self in the event handler, see the closures chapter


### Closures
- When using self in a closure one can use [weak self] in the signature of the function. Please note that the self then becomes option and needs null-propagation to be used. This principle is referred to as "Capture List"
```swift
    accountant.netWorthChangedHandler =
    {
        [weak self] nw in
        self?.netWorthChanged(to: nw); //Due to the weak self, the count of self is not incremented here
        return;
    }
```
- Closures can be used after the function is done, therefor the reference is kept to self (or any other element wrapped in the closure). Examples of closures getting called are event handlers or async like structures. You provide a function to call, the system calls it when it feels like it. In most cases the function you sent your reference to is long-done and returned. This is called an escaping closure, the closure will escape the current flow/scope.
- Swift supports completion functions that are called directly in the closure. There you are not required to flag self as weak. This also allows you to omit the self (otherwise the self will be required, otherwise an compiler error is shown).
```swift
    //Defined in the accountant:
    func gainedWithCompletion(_ asset: Asset, completion: () -> Void)

    //usage in the call:
    accountant.gainedWithCompletion(asset) { /*Completion body, can work directly on self without requiring to use self.xxx */ };
```
- By default parameter function are handled as non escaping, if you try to feed this to code that IS escaping, the compiler will give an error:
```swift
    func useNetWorthChangedHandler(handler : (Double) -> Void)
	{
		accountant.netWorthChangedHandler = handler; //The handler is escaping (not called directly), this requires explicit flagging of the handler property as escaping
	}


    func useNetWorthChangedHandler(handler : @escaping (Double) -> Void)
	{
		accountant.netWorthChangedHandler = handler; //The handler is escaping (not called directly), this requires explicit flagging of the handler property as escaping
	}
```

###Equality, comparison and operators
- Self created enums/classes are not comparable, comparing these with == will yield a compiler error. You'll need to implement the Equality protocol, which prescribes a static func == with 2 parameters (left and right hand side), returning a Bool 
```swift
    class Point : Equatable
    {
        static func ==(left : Point, right: Point) -> Bool //Naming of the vars is free
        {
            return left.x == right.x && left.y == right.y;
        }
    }
```
- Having the == implemented, will also create the != for you
- Being able to have the greater-than and smaller-than, you'll need to implement the Comparable protocol, which requires you to implement the smaller-than operator. Unlike .NET the comparable works on a bool result, where IComparable in .NET returns an integer regarding the comparable result (neg is left is greater, 0 if equal, pos is right is greater)
```swift
    class Point: Comparable
    {
        static func <(left: Point, right: Point) -> Bool
	    {
	    	return left.x < right.x && left.y < right.y;
    	}
    }
```
- For comparison you only need to have the equal and smaller-than operator implemented, the others are inferred by Swift
- Comparable requires the Equatable protocol to also be defined (the Comparable protocol inherits the Equatable protocol)
- You can have your own operators defined as infix operator OPERATORSTRING and then implementing a function with that operator.
```swift
    infix operator +++; //Must be in file scope
    
    class Person
    {
        static func +++(l: Person, r: Person)
	    {
	    	l.spouse = r;
		    r.spouse = l;
	    }
    }

    //Or:
    func +++(l: Person, r: Person)
	{
		l.spouse = r;
		r.spouse = l;
	}
```
- The implementation of the operator can be in the class (as static) or in file scope for a certain class/enum (having them both yields an exception regarding the item being ambiguous)
- Operators exist in PrecedenceGroups to define which one needs to go before the other (this concept I am not going to explore for now)
- The characters to be used in operators are limited to a set of mathematical operators, so no emojiing here
- Guidelines advice against the use of non trivial operators to prevent readability issues

### Application development for Mac/iOS
- Working with Objective-C libraries is called bridging
- The basic working of application for Mac/iOS is the MVC pattern
- @IBAction and @IBOutlet are attributes for elements in the applications
- IB stands for InterfaceBuilder
- Flagging items with IB attributes, allows you to use them in the interface builder
- Layout pinning can be done with control-drag on a control and pin them to something you want to link an aspect to (this will draw lines like WPF does when "pinning" elements) - you can also link to items to match base line etc (like buttons next to each other)
- Connecting elements-events (target-action pair) from the form to the controller can be done by control-dragging the element to the controller icon at the top of the window (the square button). This will link the target event to the action in the controller. This works on @IBAction elements
- Outlets work the other way around, you drag the controller to the element, this allows you to pick an IBOutlet property to link to a target
- Outlets need to be optional (regular (?) or explicitly unwrapped (!))
- Getting text from a NSTextView is done via the .string property (took me a while, expected value or text or something in that line)
- When making a document based app, you need to implement the document class (inherting from NSDocument) and implement the save functions, otherwise the app will crash when trying to save (the document app auto-creates the save options)
- The document-controller construction in the VocalTextEdit does not seem to be the best way to work with this, since I am not sure if the viewcontroller should be responsible, however this could be how the frontend pattern for these type of apps is defined.
- Document layout applications have a function defined in the Document class that allows you to return "data". To get data you can use for example: ```contents.data(using: .utf8)``` (where content is a String). This will create a Data object to be used by the document class (and it's callers).
- The document.read is called *before* the window is loaded (in multi document apps like the VocalTextEdit app we made), this means that you are not able to directly assign items through the view controller (that did seem a bit nasty to begin with tbh). To make this work you assign the value to the document class on load and put the data where it goes when the makeWindowControllers is called. Note that if you add it before the ```addWindowController``` call, you need to use the created controller instance, since the way we picked the controller in the save won't work since that used the ```let wController = windowControllers.first!; let vController = wController.contentViewController as! ViewController;``` construction, depending on windowControllers.first, which results in an error since the controller is not in the list yet.
- The book continued a with a refactor on the assigning and reading of the data. They refactored to a version where there is a property in the ViewController to assign the contents to, this property directly applies it to the textview (and reads the textview on getting the property). Solves the issue where the document should not be responsible for the handling of how to display. Still, it feels a bit weird, I would expect the document to be read by the controller, which on it's turn takes the required actions and bindings.
- You can tap into events in other items by checking if there are delegates availaibe. The delegates often can be assigned an implementation of a certain protocol like the NSSpeechSynthesizerDelegate in NSSpeechSynthesizer.
- When linking elements to eachother or the form (for positioning), be aware that if you have multiple items, the control might be placed in an unexpected way. You can select the "guide" and delete it (it will not "reset" if you drag a new similar one).
- The documentation of controls needs to be really read well, for example the protocol for observing the speech synth is not what you would expect as non-native swift developer. Also the working of the progress bar (what to assing) might seem strange at first.

### iOS development
- Similar pattern as MacOS applications, ViewController with outlets and actions (IBOutlet IBAction).
- Namespacing of screen elements is UIxxx where MacOS uses NSxxx.
- In the designer you can use content-hugging for priority in element growing.
- There is an option to fix issues in a frame (bottom right icon)
- Naming of elements in the controls differs from the MacOS versions, the textfield now has a property text instead of string
- Table views accept collections that adhere to the UITableViewDataSource protocol (by direct implementation or by extension)
- iOS apps can write data to their sandbox, this is based on URL items and can be requested from the FileManager
```swift
private let fileUrl : URL =
	{
		let documentDirUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
		let documentDirUrl = documentDirUrls.first!;
		return documentDirUrl.appendingPathComponent("todolist.items");
	}();
```
- If you push data to an NSArray you can easily read and write it. Regular array's are castable to an NSArray.
```swift
func saveItems()
{
    let itemsArray = items as NSArray;
    print("writing to: \(fileUrl)");
    if(!itemsArray.write(to: fileUrl, atomically: true))
    {
        print("Uh oh, writing is broken :(");
    }
}

func loadItems()
{
    if let itemsArray = NSArray(contentsOf: fileUrl) as? [String]
    {
        items = itemsArray;
    }
}
```
- Classes used should inherit from NSObject (this is not by default, unlike .NET auto-inheriting from Object)
- When writing delegate classes you might encounter an error telling you that the protocol is not implemented correctly:
```Class does not conform NSObjectProtocol```, this is due to classes not inheriting NSObject by default in swift. A correct inheritance should include the protocol *and* NSObject: ```class TodoTableObserver : NSObject, UITableViewDelegate```
- Also interesting, protocols with _ parameters need to be defined that way.
```swift
func tableView(_ view : UITableView, didSelectRowAt: IndexPath) {} //Will match
func tableView(view : UITableView, didSelectRowAt: IndexPath) {} //Will NOT match (but gives a warning stating that the protocol is almost matched)
```
Note that the whole signature needs to match, including the return object (which is not always very clear in the top level documentation).
- Function redirects to Objective-C can be done with attributes:
```@objc(tableViewSettingsDidChange:notification:)``` (not tested, but found in the docs)
- Found a "funny" thing when creating observer classes. If you put the class that inherits the delegate protocol in a variable in the view and set that variable as delegate on the control the observer works (and signals changes). If you say ```tableview.delegate = TableObserver();``` the observer will not work.

### Interop Objective-C and Swift
- I skipped this part of the book, since I am in no way willing to go into Objective-C for now ;)
- You can combine Swift and Objective-C in a single project
- When creating Swift objects in a Objective-C project, XCode will give you the possibility to configure a bridging header.
- When exposing to Objective-C you can only use classes. Structs are not visible to Objective-C.
- If using swift in an Objective-C project with bridging, XCode will create a -Swift.h file for each swift file (so test.swift gets a test-Swift.h), these header files can be used in Objective-C files via the #import statement.
- If you want to use Objective-C elements in Swift you need to include the header files of that code into swift by inserting ```#import "headerfile.h"``` in the bridging-header file, this will make the elements in the header file available to Swift. Swift will translate the Objective-C elements to Swift.

#Book.finish()