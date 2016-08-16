package todomvc.control;

import hex.control.ICompletable;
import common.Filter;
import common.TodoItem;

/**
 * @author Francis Bourre
 */
interface ITodoController 
{
	function setFilter( filter : Filter ) : Void;
	
	function showAll() : ICompletable<Array<TodoItem>>;

	function showActive() : ICompletable<Array<TodoItem>>;

	function showCompleted() : ICompletable<Array<TodoItem>>;

	function addItem( title : String ) : Void;

	function editItem( id : String ) : Void;

	function editItemSave( id : String, title : String ) : Void;

	function editItemCancel( id : String ) : Void;

	function removeItem( id : String ) : Void;

	function removeCompletedItems() : Void;

	function toggleComplete( id : String, isCompleted : Bool ) : Void;

	function toggleAll( isCompleted : Bool ) : Void;
}