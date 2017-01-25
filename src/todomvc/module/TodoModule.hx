package todomvc.module;

import hex.config.stateful.IStatefulConfig;
import hex.config.stateless.ModuleConfig;
import hex.module.Module;
import hex.module.dependency.IRuntimeDependencies;
import hex.module.dependency.RuntimeDependencies;
import todomvc.control.ITodoController;
import todomvc.control.TodoController;
import todomvc.model.FilterModel;
import todomvc.model.IFilterModel;
import todomvc.model.ITodoModel;
import todomvc.model.TodoModel;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
class TodoModule extends Module
{
	public function new( serviceConfig : IStatefulConfig, viewConfig : IStatefulConfig ) 
	{
		super();
		
		this.getLogger().info( "TodoModule initialized" );

		this._addStatelessConfigClasses( [ TodoModuleConfig ] );
		this._addStatefulConfigs( [ serviceConfig, viewConfig ] );
		this._addStatelessConfigClasses( [ ListenerConfig ] );	
	}
	
	override function _getRuntimeDependencies() : IRuntimeDependencies
	{
		return new RuntimeDependencies();
	}
}

private class TodoModuleConfig extends ModuleConfig
{
	override public function configure() : Void
	{
		this.mapController( ITodoController, TodoController, '', true );
		this.mapModel( ITodoModel, TodoModel, '', true );
		this.mapModel( IFilterModel, FilterModel, '', true );
	}
}

private class ListenerConfig extends ModuleConfig
{
	override public function configure() : Void
	{
		this.get( ITodoModel ).output.connect( this.get( ITodoView ) );
		this.get( IFilterModel ).output.connect( this.get( ITodoView ) );
	}
}