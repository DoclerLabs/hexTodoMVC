package todomvc.model;

import hex.mdvc.model.IOutput;
import todomvc.view.ITodoView;

/**
 * @author Francis Bourre
 */
interface ITodoModel 
{
	var output( default, never ) : IOutput<ITodoView>;
	
	function getAllTodos() : Array<TodoItem>;
	function getActiveTodos() : Array<TodoItem>;
	function getCompletedTodos() : Array<TodoItem>;
	
	function addTodo( item : TodoItem ) : Void;
	function removeTodo( item : TodoItem ) : Void;
}