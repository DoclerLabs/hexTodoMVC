package todomvc.model;

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
	
	public function getAllTodos() : Array<TodoItem>
	{
		#if debug
		logger.debug( ['TodoModel.getAllTodos'] );
		#end
		
		return this._items.copy();
	}
	
	public function getActiveTodos() : Array<TodoItem>
	{
		#if debug
		logger.debug( ['TodoModel.getActiveTodos'] );
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
	
	public function getCompletedTodos() : Array<TodoItem>
	{
		#if debug
		logger.debug( ['TodoModel.getCompletedTodos'] );
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
	
	public function addTodo( item : TodoItem ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.addTodo:', item] );
		#end
		
		this.output.clearNewTodo();
		this._items.push( item );
		this.output.showEntries( this._items );
		this._updateCount();
	}
	
	public function removeTodo( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.removeTodo:', id] );
		#end
		
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
		#if debug
		logger.debug( ['TodoModel.removeCompleted'] );
		#end
		
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
		#if debug
		logger.debug( ['TodoModel.getTodo:', id] );
		#end
		
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
		#if debug
		logger.debug( ['TodoModel.updateTodo:', id, isCompleted] );
		#end
		
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
		#if debug
		logger.debug( ['TodoModel._updateCount'] );
		#end
		
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