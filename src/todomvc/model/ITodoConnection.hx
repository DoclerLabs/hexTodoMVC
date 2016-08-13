package todomvc.model;

/**
 * @author Francis Bourre
 */
interface ITodoConnection 
{
	function addTodo( item : TodoItem ) : Void;
	function removeTodo( item : TodoItem ) : Void;
}