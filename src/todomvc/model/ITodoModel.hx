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
	function editTodo( id : String ) : Void;
	function updateTodo( id : String, isCompleted : Bool ) : Void;
	function editTodoTitle( id : String, title : String ) : Void;
	function cancelEdition( id : String ) : Void;
}