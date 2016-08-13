package todomvc.model;

/**
 * ...
 * @author Francis Bourre
 */
class TodoItem
{
	public var title : String;
    public var completed : Bool;
	
	inline public function new( title : String, completed : Bool ) 
	{
		this.title = title;
		this.completed = completed;
	}
}