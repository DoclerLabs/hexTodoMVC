package todomvc.control;

import common.Filter;
import common.TodoItem;
import hex.control.ICompletable;
import hex.control.forward.IForwarder;
import hex.di.IInjectorContainer;
import hex.log.IsLoggable;

/**
 * @author Francis Bourre
 */
@:keepSub
interface ITodoController extends IForwarder extends IsLoggable extends IInjectorContainer
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

	function populateModel() : Void;
}