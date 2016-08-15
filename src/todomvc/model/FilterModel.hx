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
	
	var _currentFilter : String = "All";
	
	public function new( route : String = "All" ) 
	{
		this._currentFilter = route;
	}
	
	inline public function setFilter( filter : String = "All" ) : Void
	{
		this._currentFilter = filter == "" ? "All" : filter;
		this.output.changeFilter( this._currentFilter );
	}
	
	inline public function getFilter() : String
	{
		return this._currentFilter;
	}
}