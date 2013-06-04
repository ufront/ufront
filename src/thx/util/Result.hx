package thx.util;

enum Result
{
	Ok;
	Failure(messages : Array<Message>);
}