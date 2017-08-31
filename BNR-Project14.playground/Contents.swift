//Big nerd Ranch - Swift development - Playground 14


import Cocoa

//########################################################################
// Part V - Advanced Swift
//########################################################################

//In this playground: Exceptions

//Build a lexer
enum Token
{
	case number(Int)
	case plus
}

class Lexer
{
	enum Error : Swift.Error
	{
		case InvalidCharacter(Character);
	}
	
	let input: String.CharacterView;
	var position: String.CharacterView.Index;
	
	init(_ input : String)
	{
		self.input = input.characters;
		self.position = self.input.startIndex;
	}
	
	func peek() -> Character?
	{
		guard position < input.endIndex else { return nil; }
		return input[position];
	}

	//Note: The advance allows to hit the end index, reading that one will yield a nil in the peek (signalling string end)
	func advance()
	{
		assert(position < input.endIndex, "Cannot advance beyond the endIndex!");
		position = input.index(after: position); //Get the next index AFTER curr pos
	}
	
	func lex() throws -> [Token]
	{
		var tokens = [Token]();
		
		while let nextCharacter = peek()
		{
			switch nextCharacter
			{
			case "0" ... "9":
				//Number, so read until we are out of number tokens
				let value = getNumber();
				tokens.append(.number(value));
				//Not advancing to next element since that is done in the string itself.
			case "+": //Add the + and continue
					tokens.append(.plus);
					advance();
			case " ": //Move on, skip whitespace
					advance();
			default:
				//No idea what to do, so bye bye
				throw Lexer.Error.InvalidCharacter(nextCharacter)
			}
		}
		return tokens;
	}
	
	//If a number is found, read stuff until no longer a number
	func getNumber() -> Int
	{
		var value = 0;
		while let nextCharacter = peek()
		{
			switch nextCharacter
			{
			case "0" ... "9":
				let digitValue = Int(String(nextCharacter))!;
				value = (10 * value) + digitValue;
				advance();
			default:
				return value;
			}
		}
		return value; //End of strhing, bye
	}
}


//Training the lexer
func lexerTester(_ params : String...)
{
	for p in params
	{
		print("Lexing: \(p)");
		do
		{
			var l = try Lexer(p).lex();
			print(l);
		}
		catch Lexer.Error.InvalidCharacter(let ch)
		{
			print("Invalid character exception thrown for char: \(ch)");
		}
		catch
		{
			print("Whoops, general error, reporting for duty : \(error)");
		}
	}
}

lexerTester("1+1", "2+3", "", "1a");
