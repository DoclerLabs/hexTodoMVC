package todomvc.module;

import hex.config.stateful.IStatefulConfig;
import hex.di.IInjectorContainer;
import hex.log.IsLoggable;
import hex.module.Module;
import hex.module.dependency.IRuntimeDependencies;
import hex.module.dependency.RuntimeDependencies;
import todomvc.control.ITodoController;
import todomvc.control.TodoController;
import todomvc.model.FilterModel;
import todomvc.model.IFilterModel;
import todomvc.model.ITodoModel;
import todomvc.model.TodoModel;
import todomvc.service.ITodoService;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
class TodoModule extends Module implements IsLoggable
{
	public function new( serviceConfig : IStatefulConfig, viewConfig : IStatefulConfig ) 
	{
		super();

		this._map( ITodoController, TodoController, '', true );
		this._map( ITodoModel, TodoModel, '', true );
		this._map( IFilterModel, FilterModel, '', true );
		
		this._addStatefulConfigs( [ serviceConfig, viewConfig ] );
		
		this._get( ITodoModel ).output.connect( this._get( ITodoView ) );
		this._get( IFilterModel ).output.connect( this._get( ITodoView ) );
	}
	
	override function _getRuntimeDependencies() : IRuntimeDependencies
	{
		var rd = new RuntimeDependencies();
		rd.addMappedDependencies( [ { type: ITodoView, name: '' }, { type: ITodoService, name: '' } ] );
		return rd;
	}
	
	@Debug({
		msg: "TodoModule is initialized",
		arg: [ this ]
	})
	@PostConstruct
	function _init() : Void 
	{
		super._onInitialisation();
		
	}
}