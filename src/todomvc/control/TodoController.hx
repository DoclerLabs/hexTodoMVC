package todomvc.control;

import common.Filter;
import common.TodoItem;
import hex.control.ICompletable;
import hex.control.ResultResponder;
import hex.data.GUID;
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
	
	public function new() 
	{
		
	}
	
	public function setFilter( filter : Filter ) : Void
	{
		#if debug
		logger.debug( ['TodoController::setFilter:', filter] );
		#end
		
		this.filterModel.setFilter( filter );
	}
	
	/**
	 * An event to fire on load. Will get all items and display them in the
	 * todo-list
	 */
	public function showAll() : ICompletable<Array<TodoItem>>
	{
		#if debug
		logger.debug( ['TodoController::showAll'] );
		#end
		return new ResultResponder( this.model.getAllTodos() );
	}
	
	/**
	 * Renders all active tasks
	 */
	public function showActive() : ICompletable<Array<TodoItem>>
	{
		#if debug
		logger.debug( ['TodoController::showActive'] );
		#end
		return new ResultResponder( this.model.getActiveTodos() );
	}
	
	/**
	 * Renders all completed tasks
	 */
	public function showCompleted() : ICompletable<Array<TodoItem>>
	{
		#if debug
		logger.debug( ['TodoController::showCompleted'] );
		#end
		return new ResultResponder( this.model.getCompletedTodos() );
	}
	
	/**
	 * An event to fire whenever you want to add an item. Simply pass in the event
	 * object and it'll handle the DOM insertion and saving of the new item.
	 */
	public function addItem( title : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::addItem:' + title] );
		#end
		
		var newTodoTitle = title.trim();
		
		if ( newTodoTitle.length > 0  ) 
		{
			this.model.addTodo( new TodoItemVO( newTodoTitle, false ) );
		}
	}
	
	/*
	 * Triggers the item editing mode.
	 */
	public function editItem( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::editItem:' + id] );
		#end
	}
	
	/*
	 * Finishes the item editing mode successfully.
	 */
	public function editItemSave( id : String, title : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::editItemSave:' + id] );
		#end
	}
	
	/*
	 * Cancels the item editing mode.
	 */
	public function editItemCancel( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::editItemCancel:', id] );
		#end
	}
	
	/**
	 * By giving it an ID it'll find the DOM element matching that ID,
	 * remove it from the DOM and also remove it from storage.
	 *
	 * @param {number} id The ID of the item to remove from the DOM and
	 * storage
	 */
	public function removeItem( id : String ) : Void
	{
		#if debug
		logger.debug( ['TodoController::removeItem:', id] );
		#end
		this.model.removeTodo( id );
	}
	
	/**
	 * Will remove all completed items from the DOM and storage.
	 */
	public function removeCompletedItems() : Void
	{
		#if debug
		logger.debug( ['TodoController::removeCompletedItems'] );
		#end
		this.model.removeCompleted();
	}
	
	/**
	 * Give it an ID of a model and a checkbox and it will update the item
	 * in storage based on the checkbox's state.
	 *
	 * @param {number} id The ID of the element to complete or uncomplete
	 * @param {object} checkbox The checkbox to check the state of complete
	 *                          or not
	 * @param {boolean|undefined} silent Prevent re-filtering the todo items
	 */
	public function toggleComplete( id : String, isCompleted : Bool, silent : Bool = true ) : Void
	{
		#if debug
		logger.debug( ['TodoController::toggleComplete:', id, isCompleted, silent] );
		#end
		this.model.updateTodo( id, isCompleted );
	}
	
	/**
	 * Will toggle ALL checkboxes' on/off state and completeness of models.
	 * Just pass in the event object.
	 */
	public function toggleAll( isCompleted : Bool ) : Void
	{
		#if debug
		logger.debug( ['TodoController::toggleAll:', isCompleted] );
		#end
	}
}

private class TodoItemVO
{
	public var id 			: String;
	public var title 		: String;
    public var completed 	: Bool;
	
	inline public function new( title : String, completed : Bool ) 
	{
		this.id 		= GUID.uuid();
		this.title 		= title;
		this.completed 	= completed;
	}
}