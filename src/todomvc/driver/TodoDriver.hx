package todomvc.driver;

import hex.di.IInjectorContainer;
import hex.mdvc.driver.IInput;
import todomvc.control.ITodoController;
import todomvc.model.TodoItem;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
class TodoDriver implements ITodoDriver implements IInjectorContainer
{
	@Input
	public var input : IInput<ITodoView>;
	
	@Inject
	var _view : ITodoView;
	
	@Inject
	var _controller : ITodoController;

	public function new() 
	{
		
	}
	
	@PostConstruct
	public function init() : Void
	{
		this._view.setController( this._controller );
	}
	
	//
	public function setController( controller : ITodoController ) : Void
	{
		
	}
	
	public function showEntries( entries : Array<TodoItem> ) : Void 
	{
		this._view.showEntries( entries );
	}
	
	public function removeItem(  id : String ) : Void 
	{
		this._view.removeItem( id );
	}
	
	public function updateElementCount( activeTodos : Int ) : Void 
	{
		this._view.updateElementCount( activeTodos );
	}
	
	public function clearCompletedButton( completedCount : Int, visible : Bool ) : Void 
	{
		this._view.clearCompletedButton( completedCount, visible );
	}
	
	public function contentBlockVisibility( isVisible : Bool ) : Void 
	{
		this._view.contentBlockVisibility( isVisible );
	}
	
	public function toggleAll( isChecked : Bool ) : Void 
	{
		this._view.toggleAll( isChecked );
	}
	
	public function setFilter( page : String ) : Void
	{
		this._view.setFilter( page );
	}
	
	public function clearNewTodo() : Void
	{
		this._view.clearNewTodo();
	}
	
	public function elementComplete( id : String, isCompleted : Bool ) : Void 
	{
		this._view.elementComplete( id, isCompleted );
	}
	
	public function editItem( id : String, title : String ) : Void
	{
		this._view.editItem( id, title );
	}
	
	public function editItemDone( id : String, title : String ) : Void
	{
		this._view.editItemDone( id, title );
	}
}