package todomvc.view;

import common.ITodoConnection;
import todomvc.control.ITodoController;

/**
 * @author Francis Bourre
 */
interface ITodoView extends ITodoConnection
{
	function setController( controller : ITodoController ) : Void;
	
	function selectAllFilterButton() : Void;
	
	function selectActiveFilterButton() : Void;
	
	function selectCompletedFilterButton() : Void;
}