package configuration;

import haxe.Json;
import common.TodoItem;
import common.TodoItem;
import todomvc.service.ITodoService;
import hex.log.IsLoggable;

/**
 * ...
 * @author Francis Bourre
 */
@:keepSub
class TodoLocalStorage implements ITodoService implements IsLoggable
{
	static var STORAGE_ID = 'todos-hexMachina';

	public function new() 
	{
	}
	
	@Debug public function load (): Array<TodoItem>
	{
		return Json.parse(js.Browser.getLocalStorage().getItem(STORAGE_ID));
	}
	
    @Debug public function save( todos : Array<TodoItem> ) : Void
	{
		js.Browser.getLocalStorage().setItem(STORAGE_ID, Json.stringify(todos));
	}
}