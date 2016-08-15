package todomvc.model;

import todomvc.control.ITodoController;

/**
 * @author Francis Bourre
 */
interface ITodoConnection 
{
	function setController( controller : ITodoController ) : Void;
	
	function showEntries( entries : Array<TodoItem> ) : Void;
	
	function removeItem( id : String ) : Void;
	
	function updateElementCount( activeTodos : Int ) : Void;
	
	function clearCompletedButton( completedCount : Int, visible : Bool ) : Void ;
	
	function contentBlockVisibility( isVisible : Bool ) : Void;
	
	function toggleAll( isChecked : Bool ) : Void;
	
	function clearNewTodo() : Void;
	
	function elementComplete( id : String, isCompleted : Bool ) : Void;
	
	function editItem( id : String, title : String ) : Void;
	
	function editItemDone( id : String, title : String ) : Void;
}