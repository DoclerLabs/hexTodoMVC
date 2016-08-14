package todomvc.view;

import todomvc.control.ITodoController;
import todomvc.model.TodoItem;

/**
 * ...
 * @author Francis Bourre
 */
interface ITodoView
{
	function setController( controller : ITodoController ) : Void;
	
	function showEntries( entries : Array<TodoItem> ) : Void;
	
	function removeItem( id : String ) : Void;
	
	function updateElementCount( activeTodos : Int ) : Void;
	
	function clearCompletedButton( completedCount : Int, visible : Bool ) : Void ;
	
	function contentBlockVisibility( isVisible : Bool ) : Void;
	
	function toggleAll( isChecked : Bool ) : Void;
	
	function setFilter( page : String ) : Void;
	
	function clearNewTodo() : Void;
	
	function elementComplete( id : String, isCompleted : Bool ) : Void;
	
	function editItem( id : String, title : String ) : Void;
	
	function editItemDone( id : String, title : String ) : Void;
}