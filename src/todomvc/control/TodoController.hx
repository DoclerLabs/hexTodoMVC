package todomvc.control;

import common.Filter;
import common.TodoItem;
import hex.control.ICompletable;
import hex.control.ResultResponder;
import hex.di.IInjectorContainer;
import hex.log.ILogger;
import todomvc.model.IFilterModel;
import todomvc.model.ITodoModel;

using StringTools;

/**
 * ...
 * @author Francis Bourre
 */
class TodoController implements ITodoController implements IInjectorContainer
{
	@Inject
	public var model : ITodoModel;
	
	@Inject
	public var filterModel : IFilterModel;
	
	@Inject
	public var logger : ILogger;

	public function setFilter( filter : Filter ) : Void
	{
		#if debug
		logger.debug( ['TodoController::setFilter:', filter] );
		#end
		
		this.filterModel.setFilter( filter );
	}

	public function showAll() : ICompletable<Array<TodoItem>>
	{
		#if debug
		logger.debug( ['TodoController::showAll'] );
		#end
		return new ResultResponder( this.model.getAllItems() );
	}

	public function showActive() : ICompletable<Array<TodoItem>>
	{
		#if debug
		logger.debug( ['TodoController::showActive'] );
		#end
		return new ResultResponder( this.model.getActiveItems() );
	}

	public function showCompleted() : ICompletable<Array<TodoItem>>
	{
		#if debug
		logger.debug( ['TodoController::showCompleted'] );
		#end
		return new ResultResponder( this.model.getCompletedItems() );
	}

	public function addItem( title : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::addItem:' + title] );
		#end
		
		var newTodoTitle = title.trim();
		if ( newTodoTitle.length > 0  ) 
		{
			this.model.addItem( new TodoItemVO( newTodoTitle, false ) );
		}
	}

	public function editItem( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::editItem:', id] );
		#end
		this.model.startItemEdition( id );
	}

	public function editItemSave( id : String, title : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::editItemSave:', id, title] );
		#end
		
		var updatedTodoTitle = title.trim();
		if ( updatedTodoTitle.length > 0 ) 
		{
			this.model.renameItem( id, title );

		} else 
		{
			this.removeItem( id );
		}
	}

	public function editItemCancel( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::editItemCancel:', id] );
		#end
		
		this.model.cancelItemEdition( id );
	}

	public function removeItem( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::removeItem:', id] );
		#end
		this.model.removeItem( id );
	}
	
	public function removeCompletedItems() : Void
	{
		#if debug
		logger.debug( ['TodoController::removeCompletedItems'] );
		#end
		this.model.removeCompletedItems();
	}

	public function toggleComplete( id : String, isCompleted : Bool ) : Void
	{
		#if debug
		logger.debug( ['TodoController::toggleComplete:', id, isCompleted] );
		#end
		this.model.setItemCompleted( id, isCompleted );
	}

	public function toggleAll( isCompleted : Bool ) : Void
	{
		#if debug
		logger.debug( ['TodoController::toggleAll:', isCompleted] );
		#end
		this.model.toggleAllItems( isCompleted );
	}
}

private class TodoItemVO
{
	public var id 			: String;
	public var title 		: String;
    public var completed 	: Bool;
	
	inline public function new( title : String, completed : Bool = false ) 
	{
		this.id 		= hex.data.GUID.uuid();
		this.title 		= title;
		this.completed 	= completed;
	}
}