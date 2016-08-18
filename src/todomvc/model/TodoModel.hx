package todomvc.model;

import common.ITodoConnection;
import common.TodoItem;
import hex.di.IInjectorContainer;
import hex.mdvc.model.IOutput;
import hex.util.LambdaMacro;

using hex.util.ArrayUtil;

/**
 * ...
 * @author Francis Bourre
 */
class TodoModel implements ITodoModel implements IInjectorContainer
{
	@Output
	public var output( default, never ) : IOutput<ITodoConnection>;
	
	@Inject
	public var logger : hex.log.ILogger;
	
	var _items : Array<TodoItem> = [];
	
	@Debug public function getAllItems() : Array<TodoItem>
	{
		return this._items.copy();
	}
	
	@Debug public function getActiveItems() : Array<TodoItem>
	{
		return this._items.filter( function( e ) { return !e.completed; } );
	}
	
	@Debug public function getCompletedItems() : Array<TodoItem>
	{
		return this._items.filter( function( e ) { return e.completed; } );
	}
	
	@Debug public function addItem( item : TodoItem ) : Void
	{
		this.output.onClearNewTodo();
		this._items.push( item );
		this.output.onShowEntries( this._items );
		this._updateCount();
	}
	
	@Debug public function removeItem( id : String ) : Void
	{
		this._items.doWhen( function( e ) { return e.id == id; },
			function( e, i ) { this._items.splice( i, 1 ); this.output.onRemoveItem( e.id ); this._updateCount(); } );
			
		//this._items.doWhen( ( e => e.id == id ), function( e, i ) { this._items.splice( i, 1 ); this.output.onRemoveItem( e.id ); this._updateCount(); } );
	}
	
	@Debug public function startItemEdition( id : String ) : Void
	{
		var item = this._items.findElement( function( e ){ return e.id == id;  } );
		this.output.onEditItem( item.id, item.title );
	}
	
	@Debug public function removeCompletedItems() : Void
	{
		this._items.doWhen( function( e ) { return e.completed == true; },
			function( e, i ) { this.output.onRemoveItem( e.id ); this._items.splice( i, 1 ); this._updateCount(); });
	}

	@Debug public function setItemCompleted( id : String, isCompleted : Bool ) : Void
	{
		this._items.doOnFirstWhen( function( e ) { return e.id == id; },
			function( e, i ) { e.completed = isCompleted; this.output.onSetItemCompleted( id, isCompleted ); this._updateCount(); });
	}
	
	@Debug public function renameItem( id : String, title : String ) : Void
	{
		this._items.doOnFirstWhen( function( e ) { return e.id == id; },
			function( e, i ) { e.title = title; this.output.onEditItemDone( id, title ); this._updateCount(); });
	}
	
	@Debug public function cancelItemEdition ( id : String ) : Void
	{
		this._items.doOnFirstWhen( function( e ) { return e.id == id; },
			function( e, i ) { this.output.onEditItemDone( id, e.title ); this._updateCount(); });
	}
	
	@Debug public function toggleAllItems( isCompleted : Bool ) : Void
	{
		this._items.doOnAll( function( e, i ) { e.completed = isCompleted; this.output.onSetItemCompleted( e.id, e.completed ); });
		this._updateCount();
	}
	
	//private
	@Debug function _updateCount() : Void
	{
		var itemCount 			= this._items.length;
		var completedItemCount 	= this._items.count( e => e.completed == true );

		this.output.onUpdateItemCount( itemCount - completedItemCount );
		this.output.onClearCompletedButton( completedItemCount, completedItemCount > 0 );
		this.output.onToggleAll( completedItemCount == itemCount );
		this.output.onChangeFooterVisibility( itemCount > 0 );
	}
}