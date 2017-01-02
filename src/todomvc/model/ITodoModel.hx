package todomvc.model;

import common.ITodoConnection;
import common.TodoItem;
import hex.di.IInjectorContainer;
import hex.log.IsLoggable;
import hex.event.ITrigger;
import hex.event.ITriggerOwner;

/**
 * @author Francis Bourre
 */
@:keepSub
interface ITodoModel extends ITriggerOwner extends IsLoggable extends IInjectorContainer
{
	var output( default, never ) : ITrigger<ITodoConnection>;
	
	function getAllItems() : Array<TodoItem>;
	function getActiveItems() : Array<TodoItem>;
	function getCompletedItems() : Array<TodoItem>;
	
	function addItem( item : TodoItem ) : Void;
	function removeItem( id : String ) : Void;
	function removeCompletedItems() : Void;
	function startItemEdition( id : String ) : Void;
	function setItemCompleted( id : String, isCompleted : Bool ) : Void;
	function renameItem( id : String, title : String ) : Void;
	function cancelItemEdition( id : String ) : Void;
	function toggleAllItems( isCompleted : Bool ) : Void;
}