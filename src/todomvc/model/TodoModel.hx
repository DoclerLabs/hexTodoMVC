package todomvc.model;

import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;

/**
 * ...
 * @author Francis Bourre
 */
class TodoModel implements ITodoModel implements IOutputOwner
{
	@Output
	public var output( default, never ) : IOutput<ITodoConnection>;
	
	public function new() 
	{
		
	}
	
	public function addTodo( item : TodoItem ) : Void
	{
		this.output.addTodo( item );
	}
	
	public function removeTodo( item : TodoItem ) : Void
	{
		this.output.removeTodo( item );
	}
}