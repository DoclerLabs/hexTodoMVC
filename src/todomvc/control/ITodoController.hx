package todomvc.control;

import todomvc.model.TodoItem;

/**
 * @author Francis Bourre
 */
interface ITodoController 
{
	function addTodo( title : String ) : Void;
	function editTodo( todoItem : TodoItem ) : Void;
	function revertEdits( todoItem : TodoItem ) : Void;
	function doneEditing( todoItem : TodoItem )  : Void;
	function removeTodo( todoItem: TodoItem ) : Void;
	function clearDoneTodos() : Void;
	function markAll( completed : Bool ) : Void;
}