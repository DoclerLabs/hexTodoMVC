package todomvc.control;

/**
 * @author Francis Bourre
 */
interface ITodoController 
{
	function showAll() : Void;
	
	/**
	 * Renders all active tasks
	 */
	function showActive() : Void;
	
	/**
	 * Renders all completed tasks
	 */
	function showCompleted() : Void;
	
	/**
	 * An event to fire whenever you want to add an item. Simply pass in the event
	 * object and it'll handle the DOM insertion and saving of the new item.
	 */
	function addItem( title : String ) : Void;
	
	/*
	 * Triggers the item editing mode.
	 */
	function editItem( id : Int ) : Void;
	
	/*
	 * Finishes the item editing mode successfully.
	 */
	function editItemSave( id : Int, title : String ) : Void;
	
	/*
	 * Cancels the item editing mode.
	 */
	function editItemCancel( id : Int ) : Void;
	
	/**
	 * By giving it an ID it'll find the DOM element matching that ID,
	 * remove it from the DOM and also remove it from storage.
	 *
	 * @param {number} id The ID of the item to remove from the DOM and
	 * storage
	 */
	function removeItem( id : Int ) : Void;
	
	/**
	 * Will remove all completed items from the DOM and storage.
	 */
	function removeCompletedItems() : Void;
	
	/**
	 * Give it an ID of a model and a checkbox and it will update the item
	 * in storage based on the checkbox's state.
	 *
	 * @param {number} id The ID of the element to complete or uncomplete
	 * @param {object} checkbox The checkbox to check the state of complete
	 *                          or not
	 * @param {boolean|undefined} silent Prevent re-filtering the todo items
	 */
	function toggleComplete( id : Int, completed : Dynamic, silent : Bool = true ) : Void;
	
	/**
	 * Will toggle ALL checkboxes' on/off state and completeness of models.
	 * Just pass in the event object.
	 */
	function toggleAll( isCompleted : Bool ) : Void;
}