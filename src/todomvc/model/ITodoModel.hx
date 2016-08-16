package todomvc.model;

import common.TodoItem;
import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;
import common.ITodoConnection;

/**
 * @author Francis Bourre
 */
interface ITodoModel extends IOutputOwner
{
	var output( default, never ) : IOutput<ITodoConnection>;
	
	function getAllTodos() : Array<TodoItem>;
	function getActiveTodos() : Array<TodoItem>;
	function getCompletedTodos() : Array<TodoItem>;
	
	function addTodo( item : TodoItem ) : Void;
	function removeTodo( id : String ) : Void;
	function removeCompleted() : Void;
	
	function getTodo( id : String ) : TodoItem;
	function updateTodo( id : String, isCompleted : Bool ) : Void;
}