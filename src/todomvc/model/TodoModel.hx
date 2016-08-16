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
	
	public function getAllItems() : Array<TodoItem>
	{
		#if debug
		logger.debug( ['TodoModel.getAllItems'] );
		#end
		
		return this._items.copy();
	}
	
	public function getActiveItems() : Array<TodoItem>
	{
		#if debug
		logger.debug( ['TodoModel.getActiveItems'] );
		#end
		
		var items = [];
		for ( item in this._items )
		{
			if ( !item.completed ) 
			{
				items.push( item );
			}
		}
		
		return items;
	}
	
	public function getCompletedItems() : Array<TodoItem>
	{
		#if debug
		logger.debug( ['TodoModel.getCompletedItems'] );
		#end
		
		var items = [];
		for ( item in this._items )
		{
			if ( item.completed ) 
			{
				items.push( item );
			}
		}
		
		return items;
	}
	
	public function addItem( item : TodoItem ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.addItem:', item] );
		#end
		
		this.output.onClearNewTodo();
		this._items.push( item );
		this.output.onShowEntries( this._items );
		this._updateCount();
	}
	
	public function removeItem( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.removeItem:', id] );
		#end
		
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
	
	public function startItemEdition( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.startItemEdition:', id] );
		#end
		
		var todo = this._getTodo( id );
		this.output.onEditItem( todo.id, todo.title );
	}
	
	public function removeCompletedItems() : Void
	{
		#if debug
		logger.debug( ['TodoModel.removeCompletedItems'] );
		#end
		
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

	public function setItemCompleted( id : String, isCompleted : Bool ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.setItemCompleted:', id, isCompleted] );
		#end
		
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
	
	public function renameItem( id : String, title : String ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.editTodoTitle:', id, title] );
		#end
		
		var todo = this._getTodo( id );
		todo.title = title;
		this._updateCount();
		this.output.onEditItemDone( id, title );
	}
	
	public function cancelItemEdition ( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.cancelEdition:', id] );
		#end
		
		var todo = this._getTodo( id );
		this._updateCount();
		this.output.onEditItemDone( id, todo.title );
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