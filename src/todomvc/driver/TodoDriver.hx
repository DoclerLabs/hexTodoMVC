package todomvc.driver;

import hex.di.IInjectorContainer;
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
	var _controller : ITodoController;

	public function new() 
	{
		
	}
	
	@PostConstruct
	public function init() : Void
	{
		this.view.setController( this._controller );
	}
}