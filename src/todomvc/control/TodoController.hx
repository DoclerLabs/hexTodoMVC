package todomvc.control;

import hex.di.IInjectorContainer;
import todomvc.model.ITodoModel;
import todomvc.model.TodoItem;

using StringTools;

/**
 * ...
 * @author Francis Bourre
 */
class TodoController implements ITodoController implements IInjectorContainer
{
	@Inject
	public var model : ITodoModel;
	
	public function new() 
	{
		
	}
	
	/**
	 * An event to fire on load. Will get all items and display them in the
	 * todo-list
	 */
	public function showAll() : Void
	{

	}
	
	/**
	 * Renders all active tasks
	 */
	public function showActive() : Void
	{

	}
	
	/**
	 * Renders all completed tasks
	 */
	public function showCompleted() : Void
	{

	}
	
	/**
	 * An event to fire whenever you want to add an item. Simply pass in the event
	 * object and it'll handle the DOM insertion and saving of the new item.
	 */
	public function addItem( title : String ) : Void
	{
		trace( 'TodoController.addItem:' + title );
		
		var newTodo = title.trim();
		
		if ( newTodo.length > 0  ) 
		{
			this.model.addTodo( new TodoItem( newTodo, false ) );
			/**
				self.model.create(title, function () {
				self.view.render('clearNewTodo');
				self._filter(true);
				});
			 */
		}
	}
	
	/*
	 * Triggers the item editing mode.
	 */
	public function editItem( id : Int ) : Void
	{

	}
	
	/*
	 * Finishes the item editing mode successfully.
	 */
	public function editItemSave( id : Int, title : String ) : Void
	{
		
	}
	
	/*
	 * Cancels the item editing mode.
	 */
	public function editItemCancel( id : Int ) : Void
	{
		
	}
	
	/**
	 * By giving it an ID it'll find the DOM element matching that ID,
	 * remove it from the DOM and also remove it from storage.
	 *
	 * @param {number} id The ID of the item to remove from the DOM and
	 * storage
	 */
	public function removeItem( id : Int ) : Void
	{
		
	}
	
	/**
	 * Will remove all completed items from the DOM and storage.
	 */
	public function removeCompletedItems() : Void
	{
		trace( 'TodoController.removeCompletedItems' );
	}
	
	/**
	 * Give it an ID of a model and a checkbox and it will update the item
	 * in storage based on the checkbox's state.
	 *
	 * @param {number} id The ID of the element to complete or uncomplete
	 * @param {object} checkbox The checkbox to check the state of complete
	 *                          or not
	 * @param {boolean|undefined} silent Prevent re-filtering the todo items
	 */
	public function toggleComplete( id : Int, completed : Dynamic, silent : Bool = true ) : Void
	{
		
	}
	
	/**
	 * Will toggle ALL checkboxes' on/off state and completeness of models.
	 * Just pass in the event object.
	 */
	public function toggleAll( isCompleted : Bool ) : Void
	{
		trace( 'TodoController.toggleAll:', isCompleted );
	}
}