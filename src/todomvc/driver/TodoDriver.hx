package todomvc.driver;

import common.Filter;
import common.TodoItem;
import hex.di.IInjectorContainer;
import hex.error.IllegalStateException;
import hex.log.ILogger;
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
	
	@Inject
	public var logger : ILogger;
	
	@PostConstruct
	@Debug public function init() : Void
	{
		this.view.setController( this.controller );
	}
	
	@Debug public function changeFilter( currentFilter : Filter ) : Void
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
	
	@Debug @Forward( view.showEntries ) 			public function onShowEntries( entries : Array<TodoItem> ) : Void {}
	@Debug @Forward( view.removeItem ) 				public function onRemoveItem( id : String ) : Void {}
	@Debug @Forward( view.updateItemCount ) 		public function onUpdateItemCount( activeItems : Int ) : Void {}
	@Debug @Forward( view.clearCompletedButton ) 	public function onClearCompletedButton( completedCount : Int, visible : Bool ) : Void {}
	@Debug @Forward( view.changeFooterVisibility ) 	public function onChangeFooterVisibility( isVisible : Bool ) : Void {}
	@Debug @Forward( view.toggleAll ) 				public function onToggleAll( isChecked : Bool ) : Void {}
	@Debug @Forward( view.clearNewTodo ) 			public function onClearNewTodo() : Void {}
	@Debug @Forward( view.setItemCompleted ) 		public function onSetItemCompleted( id : String, isCompleted : Bool ) : Void {}
	@Debug @Forward( view.editItem ) 				public function onEditItem( id : String, title : String ) : Void {}
	@Debug @Forward( view.editItemDone ) 			public function onEditItemDone( id : String, title : String ) : Void {}
}