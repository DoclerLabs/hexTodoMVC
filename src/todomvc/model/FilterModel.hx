package todomvc.model;

import hex.log.ILogger;
import hex.mdvc.model.IOutput;

/**
 * ...
 * @author Francis Bourre
 */
class FilterModel implements IFilterModel
{
	@Inject
	public var logger : ILogger;
	
	@Output
	public var output( default, never ) : IOutput<IFilterConnection>;
	
	var _currentFilter : String = "";
	
	public function new( route : String = "" ) 
	{
		this._currentFilter = route;
	}
	
	inline public function setFilter( filter : String = "" ) : Void
	{
		#if debug
		logger.debug( ['FilterModel.setFilter:', filter] );
		#end
		
		this._currentFilter = filter;
		this.output.changeFilter( this._currentFilter );
	}
	
	inline public function getFilter() : String
	{
		#if debug
		logger.debug( ['FilterModel.getFilter'] );
		#end
		
		return this._currentFilter;
	}
}