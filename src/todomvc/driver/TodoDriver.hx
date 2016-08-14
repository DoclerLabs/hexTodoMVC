package todomvc.driver;

import hex.di.IInjectorContainer;
import hex.mdvc.driver.IInput;
import todomvc.control.ITodoController;
import todomvc.model.ITodoConnection;
import todomvc.model.TodoItem;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
class TodoDriver implements ITodoDriver implements IInjectorContainer
{
	@Input
	public var input : IInput<ITodoConnection>;
	
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
	
	public function addTodo( item : TodoItem ) : Void
	{
		
	}
	
	public function removeTodo( item : TodoItem ) : Void
	{
		
	}
}