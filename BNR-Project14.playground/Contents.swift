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

class Parser
{
	enum Error : Swift.Error
	{
		case unexpectedEndOfInput
		case invalidToken(Token)
	}
	
	let tokens : [Token];
	var position = 0;
	
	init(_ tokens : [Token])
	{
		self.tokens = tokens;
	}
	
	func getNextToken() -> Token?
	{
		guard position < tokens.count else { return nil; }
		var t = tokens[position];
		position += 1;
		return t;
	}
	
	func getNumber() throws -> Int
	{
		guard let token = getNextToken() else { throw Parser.Error.unexpectedEndOfInput; }
		switch token
		{
		case .number(let nr):
			return nr;
		default:
			throw Parser.Error.invalidToken(token);
		}
	}
	
	func parse() throws -> Int
	{
		var value = try getNumber(); //Get the first number
		
		while let token = getNextToken()
		{
			switch token
			{
			case .plus:
				let nextNumber = try getNumber();
				value += nextNumber;
			case .number:
				throw Parser.Error.invalidToken(token)
			}
		}
		return value;
	}

}

//Training the lexer
func lexerTester(_ params : String...)
{
	
	for p in params
	{
		print("Evaluating: \(p)");
		//** With try? in a guard you can use an inline handling
		//guard let tokens = try? Lexer(p).lex() else { print("Error in lexing"); return; }
		//** With try! you can force your way around the do - catch
		//var tokens = try Lexer(p).lex();
		
		do
		{
			var tokens = try Lexer(p).lex();
			var parser = Parser(tokens);
			var res = try parser.getNumber();
			print("\(p) -> \(res)");
		}
		catch Lexer.Error.InvalidCharacter(let ch)
		{
			print("Invalid character exception thrown for char: \(ch)");
		}
		catch Parser.Error.invalidToken(let t)
		{
			print("Parser exception, invalid token: \(t)");
		}
		catch Parser.Error.unexpectedEndOfInput
		{
			print("Unexepect end of lexing string")
		}
		catch
		{
			print("Whoops, general error, reporting for duty : \(error)");
		}
	}
}

lexerTester("1+1", "2+3", "", "1a", "6+7   + 9 + 2", "22", "22 + ", "+22");
