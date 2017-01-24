package todomvc.control;

import common.Filter;
import common.TodoItem;
import hex.control.ICompletable;
import hex.control.ResultResponder;
import todomvc.model.IFilterModel;
import todomvc.model.ITodoModel;

using StringTools;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
class TodoController implements ITodoController
{
	@Inject
	public var model : ITodoModel;
	
	@Inject
	public var filterModel : IFilterModel;

	@Debug @Forward( filterModel.setFilter ) 		public function setFilter( filter : Filter ) : Void { }

	@Debug @Forward( model.startItemEdition ) 		public function editItem( id : String ) : Void {}
	@Debug @Forward( model.cancelItemEdition ) 		public function editItemCancel( id : String ) : Void {}
	@Debug @Forward( model.removeItem ) 			public function removeItem( id : String ) : Void {}
	@Debug @Forward( model.removeCompletedItems ) 	public function removeCompletedItems() : Void {}
	@Debug @Forward( model.setItemCompleted ) 		public function toggleComplete( id : String, isCompleted : Bool ) : Void {}
	@Debug @Forward( model.toggleAllItems ) 		public function toggleAll( isCompleted : Bool ) : Void {}

	@Debug public function showAll() : ICompletable<Array<TodoItem>>
	{
		return new ResultResponder( this.model.getAllItems() );
	}

	@Debug public function showActive() : ICompletable<Array<TodoItem>>
	{
		return new ResultResponder( this.model.getActiveItems() );
	}

	@Debug public function showCompleted() : ICompletable<Array<TodoItem>>
	{
		return new ResultResponder( this.model.getCompletedItems() );
	}

	@Debug public function addItem( title : String ) : Void
	{
		var newTodoTitle = title.trim();
		if ( newTodoTitle.length > 0  ) 
		{
			this.model.addItem( new TodoItemVO( newTodoTitle, false ) );
		}
	}

	@Debug public function editItemSave( id : String, title : String ) : Void
	{
		var updatedTodoTitle = title.trim();
		if ( updatedTodoTitle.length > 0 ) 
		{
			this.model.renameItem( id, title );

		} else 
		{
			this.removeItem( id );
		}
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