package todomvc.model;

/**
 * @author Francis Bourre
 */
interface ITodoModel 
{
	function addTodo( item : TodoItem ) : Void;
	function removeTodo( item : TodoItem ) : Void;
}