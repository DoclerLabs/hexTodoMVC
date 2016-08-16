package todomvc.model;

import common.Filter;
import common.IFilterConnection;
import hex.di.IInjectorContainer;
import hex.log.ILogger;
import hex.mdvc.model.IOutput;

/**
 * ...
 * @author Francis Bourre
 */
class FilterModel implements IFilterModel implements IInjectorContainer
{
	@Inject
	public var logger : ILogger;
	
	@Output
	public var output( default, never ) : IOutput<IFilterConnection>;
	
	var _currentFilter : Filter;
	
	public function new() 
	{
		this._currentFilter = Filter.ALL;
	}
	
	inline public function setFilter( filter : Filter ) : Void
	{
		#if debug
		logger.debug( ['FilterModel.setFilter:', filter] );
		#end
		
		this._currentFilter = filter;
		this.output.changeFilter( this._currentFilter );
	}
	
	inline public function getFilter() : Filter
	{
		#if debug
		logger.debug( ['FilterModel.getFilter'] );
		#end
		
		return this._currentFilter;
	}
}