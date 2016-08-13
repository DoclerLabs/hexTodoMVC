package configuration;

import todomvc.model.TodoItem;
import todomvc.service.ITodoService;

/**
 * ...
 * @author Francis Bourre
 */
class TodoLocalStorage implements ITodoService
{

	public function new() 
	{
		
	}
	
	public function load (): Array<TodoItem>
	{
		return null;
	}
	
    public function save( todos : Array<TodoItem> ) : Void
	{
		
	}
}