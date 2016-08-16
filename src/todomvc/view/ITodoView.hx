package todomvc.view;

import common.TodoItem;
import todomvc.control.ITodoController;

/**
 * @author Francis Bourre
 */
interface ITodoView
{
	function setController( controller : ITodoController ) : Void;
	
	function selectAllFilterButton() : Void;
	
	function selectActiveFilterButton() : Void;
	
	function selectCompletedFilterButton() : Void;
	
	//
	function showEntries( entries : Array<TodoItem> ) : Void;
	
	function removeItem( id : String ) : Void;
	
	function updateItemCount( activeItems : Int ) : Void;
	
	function clearCompletedButton( completedCount : Int, visible : Bool ) : Void ;
	
	function changeFooterVisibility( isVisible : Bool ) : Void;
	
	function toggleAll( isChecked : Bool ) : Void;
	
	function clearNewTodo() : Void;
	
	function setItemCompleted( id : String, isCompleted : Bool ) : Void;
	
	function editItem( id : String, title : String ) : Void;
	
	function editItemDone( id : String, title : String ) : Void;
}