package todomvc.model;

import common.Filter;
import common.IFilterConnection;
import hex.event.ITrigger;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
class FilterModel implements IFilterModel
{
	@Trigger
	public var output( default, never ) : ITrigger<IFilterConnection>;
	
	var _currentFilter : Filter = Filter.ALL;
	
	@Debug public function setFilter( filter : Filter ) : Void
	{
		this._currentFilter = filter;
		this.output.changeFilter( this._currentFilter );
	}
}