package todomvc.model;

import common.Filter;
import common.IFilterConnection;
import hex.mdvc.model.IOutput;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
class FilterModel implements IFilterModel
{
	@Output
	public var output( default, never ) : IOutput<IFilterConnection>;
	
	var _currentFilter : Filter = Filter.ALL;
	
	@Debug public function setFilter( filter : Filter ) : Void
	{
		this._currentFilter = filter;
		this.output.changeFilter( this._currentFilter );
	}
}