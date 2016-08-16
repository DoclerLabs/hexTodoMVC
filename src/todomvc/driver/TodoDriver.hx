package todomvc.driver;

import hex.di.IInjectorContainer;
import hex.error.IllegalStateException;
import todomvc.control.ITodoController;
import common.Filter;
import common.TodoItem;
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
	var _controller : ITodoController;

	public function new() 
	{
		
	}
	
	@PostConstruct
	public function init() : Void
	{
		this.view.setController( this._controller );
	}
	
	public function changeFilter( currentFilter : Filter ) : Void
	{
		switch( currentFilter )
		{
			case Filter.ALL:
				this.view.selectAllFilterButton();
				this._controller.showAll().onComplete( this._showItems );
				
			case Filter.ACTIVE:
				this.view.selectActiveFilterButton();
				this._controller.showActive().onComplete( this._showItems );
				
			case Filter.COMPLETED:
				this.view.selectCompletedFilterButton();
				this._controller.showCompleted().onComplete( this._showItems );
				
			case _:
				throw new IllegalStateException( "changeFilter call with illegal filter parameter: '" + currentFilter + "'" );
		}
	}
	
	function _showItems( items : Array<TodoItem> ) : Void
	{
		this.view.showEntries( items );
	}
}