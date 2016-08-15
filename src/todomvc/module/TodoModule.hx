package todomvc.module;

import hex.config.stateful.IStatefulConfig;
import hex.mdvc.config.stateless.StatelessModuleConfig;
import hex.mdvc.module.Module;
import hex.module.dependency.IRuntimeDependencies;
import hex.module.dependency.RuntimeDependencies;
import todomvc.control.ITodoController;
import todomvc.control.TodoController;
import todomvc.driver.ITodoDriver;
import todomvc.driver.TodoDriver;
import todomvc.model.FilterModel;
import todomvc.model.IFilterModel;
import todomvc.model.ITodoModel;
import todomvc.model.TodoModel;

/**
 * ...
 * @author Francis Bourre
 */
class TodoModule extends Module
{
	public function new( serviceConfig : hex.config.stateful.IStatefulConfig, viewConfig : hex.config.stateful.IStatefulConfig ) 
	{
		super();
		
		this.getLogger().info( "TodoModule initialized" );

		this._addStatefulConfigs( [ serviceConfig, viewConfig ] );
		this._addStatelessConfigClasses( [ TodoModuleConfig ] );
	}
	
	override function _onInitialisation() : Void 
	{
		super._onInitialisation();
		//this._get( ITodoController ).initialize();
	}
}

private class TodoModuleConfig extends StatelessModuleConfig
{
	override public function configure() : Void
	{
		this.mapController( ITodoController, TodoController );
		this.mapModel( ITodoModel, TodoModel );
		this.mapModel( IFilterModel, FilterModel );
		this.mapDriver( ITodoDriver, TodoDriver );
		
		var view = this.get( ITodoDriver ).view;
		this.get( ITodoModel ).output.connect( view );
		this.get( IFilterModel ).output.connect( view );
	}
}