package todomvc.model;

import hex.mdvc.model.IOutput;
import hex.mdvc.model.IOutputOwner;

/**
 * ...
 * @author Francis Bourre
 */
class TodoModel implements ITodoModel
{
	@Output
	public var output( default, never ) : IOutput<ITodoConnection>;
	
	var _items : Array<TodoItem>;
	
	public function new() 
	{
		this._items = [];
	}
	
	public function getAllTodos() : Array<TodoItem>
	{
		return this._items.copy();
	}
	
	public function getActiveTodos() : Array<TodoItem>
	{
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
	
	public function getCompletedTodos() : Array<TodoItem>
	{
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
	
	public function addTodo( item : TodoItem ) : Void
	{
		trace( 'TodoModel.addTodo:', item );
		this.output.clearNewTodo();
		this._items.push( item );
		this.output.showEntries( this._items );
		this._updateCount();
	}
	
	public function removeTodo( id : String ) : Void
	{
		for ( index in 0...this._items.length )
		{
			if ( this._items[ index ].id == id )
			{
				this._items.splice( index, 1 );
				this.output.removeItem( id );
				this._updateCount();
				break;
			}
		}
	}
	
	public function removeCompleted() : Void
	{
		var l = this._items.length;
		var item = null;
		while ( l-- > 0 )
		{
			item = this._items[ l ];
			
			if ( item.completed )
			{
				this._items.splice( l, 1 );
				this.output.removeItem( item.id );
			}
		}
		
		if ( item != null )
		{
			this._updateCount();
		}
	}
	
	public function getTodo( id : String ) : TodoItem
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
	
	public function updateTodo( id : String, isCompleted : Bool ) : Void
	{
		for ( item in this._items )
		{
			if ( item.id == id ) 
			{
				item.completed = isCompleted;
				this.output.elementComplete( id, isCompleted );
				this._updateCount();
				break;
			}
		}
	}
	
	function _updateCount() : Void
	{
		var completed 	= 0;
		var active 		= 0;
		var total 		= 0;
		
		for ( item in this._items )
		{
			if ( item.completed ) 
			{
				completed++;
			} 
			else 
			{
				active++;
			}
				
			total++;
		}
		
		var todos = this.getAllTodos();
		this.output.updateElementCount( active );
		this.output.clearCompletedButton( completed, completed > 0 );
		this.output.toggleAll( completed == total );
		this.output.showFooter( total > 0 );
	}
}