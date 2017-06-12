package todomvc.module;

import hex.di.mapping.IDependencyOwner;
import hex.di.mapping.MappingDefinition;
import hex.log.IsLoggable;
import hex.module.ContextModule;
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
@Dependency( var _:ITodoView)
@Dependency( var _:ITodoService)
@:keepSub
class TodoModule extends ContextModule implements IsLoggable implements IDependencyOwner
{
	public function new( serviceMapping : MappingDefinition, viewMapping : MappingDefinition ) 
	{
		super();

		this._map( ITodoController, TodoController, '', true );

		this._map( ITodoModel, TodoModel, '', true );
		this._map( IFilterModel, FilterModel, '', true );

		@AfterMapping

		this._get( ITodoModel ).output.connect( this._get( ITodoView ) );
		this._get( IFilterModel ).output.connect( this._get( ITodoView ) );
	}

}