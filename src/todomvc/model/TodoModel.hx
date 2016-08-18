package todomvc.model;

import common.ITodoConnection;
import common.TodoItem;
import hex.di.IInjectorContainer;
import hex.log.ILogger;
import hex.mdvc.model.IOutput;

/**
 * ...
 * @author Francis Bourre
 */
class TodoModel implements ITodoModel implements IInjectorContainer
{
	@Output
	public var output( default, never ) : IOutput<ITodoConnection>;
	
	@Inject
	public var logger : ILogger;
	
	var _items : Array<TodoItem>;
	
	public function new() 
	{
		this._items = [];
	}
	
	@Debug public function getAllItems() : Array<TodoItem>
	{
		return this._items.copy();
	}
	
	@Debug public function getActiveItems() : Array<TodoItem>
	{
		return [ for ( item in this._items ) if ( !item.completed ) item ];
	}
	
	@Debug public function getCompletedItems() : Array<TodoItem>
	{
		return [ for ( item in this._items ) if ( item.completed ) item ];
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
		for ( index in 0...this._items.length )
		{
			if ( this._items[ index ].id == id )
			{
				this._items.splice( index, 1 );
				this.output.onRemoveItem( id );
				this._updateCount();
				break;
			}
		}
	}
	
	@Debug public function startItemEdition( id : String ) : Void
	{
		var todo = this._getTodo( id );
		this.output.onEditItem( todo.id, todo.title );
	}
	
	@Debug public function removeCompletedItems() : Void
	{
		var l = this._items.length;
		var item = null;
		while ( l-- > 0 )
		{
			item = this._items[ l ];
			
			if ( item.completed )
			{
				this._items.splice( l, 1 );
				this.output.onRemoveItem( item.id );
			}
		}
		
		if ( item != null )
		{
			this._updateCount();
		}
	}

	@Debug public function setItemCompleted( id : String, isCompleted : Bool ) : Void
	{
		for ( item in this._items )
		{
			if ( item.id == id ) 
			{
				item.completed = isCompleted;
				this.output.onSetItemCompleted( id, isCompleted );
				this._updateCount();
				break;
			}
		}
	}
	
	@Debug public function renameItem( id : String, title : String ) : Void
	{
		var todo = this._getTodo( id );
		todo.title = title;
		this._updateCount();
		this.output.onEditItemDone( id, title );
	}
	
	@Debug public function cancelItemEdition ( id : String ) : Void
	{
		var todo = this._getTodo( id );
		this._updateCount();
		this.output.onEditItemDone( id, todo.title );
	}
	
	@Debug public function toggleAllItems( isCompleted : Bool ) : Void
	{
		for ( index in 0...this._items.length )
		{
			var item = this._items[ index ];
			item.completed = isCompleted;
			this.output.onSetItemCompleted( item.id, item.completed );
		}
		this._updateCount();
	}
	
	//private
	function _getTodo( id : String ) : TodoItem
	{
		for ( item in this._items )
		{
			if ( item.id == id ) 
			{
				return item;
			}
		}
		
		return null;
	}
	
	function _updateCount() : Void
	{
		#if debug
		logger.debug( ['TodoModel._updateCount'] );
		#end
		
		var completedItemCount 	= 0;
		var activeItemCount 	= 0;
		
		for ( item in this._items )
		{
			if ( item.completed ) 
			{
				completedItemCount++;
			} 
			else 
			{
				activeItemCount++;
			}
		}
		
		var itemCount 	= completedItemCount + activeItemCount;
		var todos 		= this.getAllItems();
		
		this.output.onUpdateItemCount( activeItemCount );
		this.output.onClearCompletedButton( completedItemCount, completedItemCount > 0 );
		this.output.onToggleAll( completedItemCount == itemCount );
		this.output.onChangeFooterVisibility( itemCount > 0 );
	}
}