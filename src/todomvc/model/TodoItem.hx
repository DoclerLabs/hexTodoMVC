package todomvc.model;

import hex.data.GUID;

/**
 * ...
 * @author Francis Bourre
 */
class TodoItem
{
	public var id 			: String;
	public var title 		: String;
    public var completed 	: Bool;
	
	inline public function new( title : String, completed : Bool ) 
	{
		this.id 		= GUID.uuid();
		this.title 		= title;
		this.completed 	= completed;
	}
}