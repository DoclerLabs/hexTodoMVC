package common;

import todomvc.control.ITodoController;

/**
 * @author Francis Bourre
 */
interface ITodoConnection 
{
	function onShowEntries( entries : Array<TodoItem> ) : Void;
	
	function onRemoveItem( id : String ) : Void;
	
	function onUpdateItemCount( activeItems : Int ) : Void;
	
	function onClearCompletedButton( completedCount : Int, visible : Bool ) : Void ;
	
	function onChangeFooterVisibility( isVisible : Bool ) : Void;
	
	function onToggleAll( isChecked : Bool ) : Void;
	
	function onClearNewTodo() : Void;
	
	function onSetItemCompleted( id : String, isCompleted : Bool ) : Void;
	
	function onEditItem( id : String, title : String ) : Void;
	
	function onEditItemDone( id : String, title : String ) : Void;
}