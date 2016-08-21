package todomvc.model;

import common.TodoItem;
import hex.di.IInjectorContainer;
import hex.mdvc.log.IsLoggable;
import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;
import common.ITodoConnection;

/**
 * @author Francis Bourre
 */
interface ITodoModel extends IOutputOwner extends IsLoggable extends IInjectorContainer
{
	var output( default, never ) : IOutput<ITodoConnection>;
	
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