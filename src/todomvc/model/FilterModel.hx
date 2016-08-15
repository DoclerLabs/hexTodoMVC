package todomvc.model;

import hex.mdvc.model.IOutput;

/**
 * ...
 * @author Francis Bourre
 */
class FilterModel implements IFilterModel
{
	@Output
	public var output( default, never ) : IOutput<IFilterConnection>;
	
	var _currentFilter : String = "";
	
	public function new( route : String = "" ) 
	{
		this._currentFilter = route;
	}
	
	inline public function setFilter( filter : String = "" ) : Void
	{
		this._currentFilter = filter;
		this.output.changeFilter( this._currentFilter );
	}
	
	inline public function getFilter() : String
	{
		return this._currentFilter;
	}
}