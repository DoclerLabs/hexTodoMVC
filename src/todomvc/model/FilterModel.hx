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
	
	var _currentFilter : Filter = Filter.ALL;
	
	@Debug public function setFilter( filter : Filter ) : Void
	{
		this._currentFilter = filter;
		this.output.changeFilter( this._currentFilter );
	}
}