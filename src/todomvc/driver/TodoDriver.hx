package todomvc.driver;

import common.Filter;
import common.TodoItem;
import hex.di.IInjectorContainer;
import hex.error.IllegalStateException;
import todomvc.control.ITodoController;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
class TodoDriver implements ITodoDriver implements IInjectorContainer
{
	@Inject
	public var view : ITodoView;
	
	@Inject
	var controller : ITodoController;
	
	@PostConstruct
	public function init() : Void
	{
		this.view.setController( this.controller );
	}
	
	public function changeFilter( currentFilter : Filter ) : Void
	{
		switch( currentFilter )
		{
			case Filter.ALL:
				this.view.selectAllFilterButton();
				this.controller.showAll().onComplete( this.view.showEntries.bind() );
				
			case Filter.ACTIVE:
				this.view.selectActiveFilterButton();
				this.controller.showActive().onComplete( this.view.showEntries.bind() );
				
			case Filter.COMPLETED:
				this.view.selectCompletedFilterButton();
				this.controller.showCompleted().onComplete( this.view.showEntries.bind() );
				
			case _:
				throw new IllegalStateException( "changeFilter call with illegal filter parameter: '" + currentFilter + "'" );
		}
	}
	
	/*
	@Forward( view.showEntries ) 			public function onShowEntries( entries : Array<TodoItem> ) : Void {}
	@Forward( view.removeItem ) 			public function onRemoveItem( id : String ) : Void
	@Forward( view.updateItemCount ) 		public function onUpdateItemCount( activeItems : Int ) : Void {}
	@Forward( view.clearCompletedButton ) 	public function onClearCompletedButton( completedCount : Int, visible : Bool ) : Void {}
	@Forward( view.changeFooterVisibility ) public function onChangeFooterVisibility( isVisible : Bool ) : Void {}
	@Forward( view.toggleAll ) 				public function onToggleAll( isChecked : Bool ) : Void {}
	@Forward( view.clearNewTodo ) 			public function onClearNewTodo() : Void {}
	@Forward( view.setItemCompleted ) 		public function onSetItemCompleted( id : String, isCompleted : Bool ) : Void {}
	@Forward( view.editItem ) 				public function onEditItem( id : String, title : String ) : Void {}
	@Forward( view.editItemDone ) 			public function onEditItemDone( id : String, title : String ) : Void {}
	*/
	
	public function onShowEntries( entries : Array<TodoItem> ) : Void
	{
		this.view.showEntries( entries );
	}
	
	public function onRemoveItem( id : String ) : Void
	{
		this.view.removeItem( id );
	}
	
	public function onUpdateItemCount( activeItems : Int ) : Void
	{
		this.view.updateItemCount( activeItems );
	}
	
	public function onClearCompletedButton( completedCount : Int, visible : Bool ) : Void
	{
		this.view.clearCompletedButton( completedCount, visible );
	}
	
	public function onChangeFooterVisibility( isVisible : Bool ) : Void
	{
		this.view.changeFooterVisibility( isVisible );
	}
	
	public function onToggleAll( isChecked : Bool ) : Void
	{
		this.view.toggleAll( isChecked );
	}
	
	public function onClearNewTodo() : Void
	{
		this.view.clearNewTodo();
	}
	
	public function onSetItemCompleted( id : String, isCompleted : Bool ) : Void
	{
		this.view.setItemCompleted( id, isCompleted );
	}
	
	public function onEditItem( id : String, title : String ) : Void
	{
		this.view.editItem( id, title );
	}
	
	public function onEditItemDone( id : String, title : String ) : Void
	{
		this.view.editItemDone( id, title );
	}
}