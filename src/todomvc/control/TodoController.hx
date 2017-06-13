package todomvc.control;

import common.Filter;
import common.TodoItem;
import hex.control.ICompletable;
import hex.control.ResultResponder;
import todomvc.model.IFilterModel;
import todomvc.model.ITodoModel;
import todomvc.service.ITodoService;

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

	@Inject
	public var service : ITodoService;

	@Debug @Forward( filterModel.setFilter ) 		public function setFilter( filter : Filter ) : Void { }

	@Debug @Forward( model.startItemEdition ) 		public function editItem( id : String ) : Void {}
	@Debug @Forward( model.cancelItemEdition ) 		public function editItemCancel( id : String ) : Void {}
	@Debug @Forward( model.removeItem ) 			public function removeItem( id : String ) : Void {}
	@Debug @Forward( model.removeCompletedItems ) 	public function removeCompletedItems() : Void {}
	@Debug @Forward( model.toggleAllItems ) 		public function toggleAll( isCompleted : Bool ) : Void {}

	@Debug
	public function toggleComplete( id : String, isCompleted : Bool ) : Void 
	{
		this.model.setItemCompleted(id, isCompleted);
		this._saveItems();
	}

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
		this._saveItems();
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
		this._saveItems();
	}

	@Debug public function populateModel() : Void
	{
		var items = this.service.load();
		for( item in items )
		{
			this.model.addItem( item );
		}
	}

	@Debug function _saveItems() : Void
	{
		this.service.save( this.model.getAllItems() );
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