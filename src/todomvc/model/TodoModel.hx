package todomvc.model;

import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
class TodoModel implements ITodoModel implements IOutputOwner
{
	@Output
	public var output( default, never ) : IOutput<ITodoView>;
	
	public function new() 
	{
		
	}
	
	public function getAllTodos() : Array<TodoItem>
	{
		return [ new TodoItem( 'test', false ) ];
	}
	
	public function getActiveTodos() : Array<TodoItem>
	{
		return [ new TodoItem( 'test', false ) ];
	}
	
	public function getCompletedTodos() : Array<TodoItem>
	{
		return [ new TodoItem( 'test', false ) ];
	}
	
	public function addTodo( item : TodoItem ) : Void
	{
		trace( 'TodoModel.addTodo:', item );
		this.output.clearNewTodo();
	}
	
	public function removeTodo( item : TodoItem ) : Void
	{

	}
}