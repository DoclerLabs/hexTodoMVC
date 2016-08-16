package js;

import common.Filter;
import common.TodoItem;
import hex.di.IInjectorContainer;
import hex.log.ILogger;
import js.Browser;
import js.html.Element;
import js.html.InputElement;
import js.html.LIElement;
import js.jquery.JQuery;
import todomvc.control.ITodoController;
import todomvc.view.ITodoView;

/**
 * ...
 * @author Francis Bourre
 */
class TodoViewJS implements ITodoView implements IInjectorContainer
{
	@Inject
	public var logger 		: ILogger;
	
	var _controller 		: ITodoController;
	var _qs 				: String -> Element = Browser.document.querySelector;
	
	var _template 			: Template;
	var _todoList 			: InputElement;
	var _todoItemCounter 	: Element;
	var _clearCompleted 	: Element;
	var _main 				: Element;
	var _footer 			: Element;
	var _toggleAll 			: InputElement;
	var _newTodo 			: InputElement;
	
	public function new( 	todoList,
							todoItemCounter,
							clearCompleted,
							main,
							footer,
							toggleAll,
							newTodo ) 
	{
		this._template 			= new Template();
		this._todoList 			= cast todoList;
		this._todoItemCounter 	= cast todoItemCounter;
		this._clearCompleted 	= cast clearCompleted;
		this._main 				= cast main;
		this._footer 			= cast footer;
		this._toggleAll 		= cast toggleAll;
		this._newTodo 			= cast newTodo;
		
		this.showFooter( false );
	}
	
	public function setController( controller : ITodoController ) : Void
	{
		#if debug
		logger.debug( ['TodoModel.setController:', controller] );
		#end
		
		this._controller = controller;
		new JQuery( function() : Void { this._initJQuery(); } );
	}
	
	function _initJQuery() : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._initJQuery'] );
		#end
		
		new JQuery( Browser.window ).on( 'hashchange', _onHashChange );
		new JQuery( this._newTodo ).on( 'change', this._onNewTodo );
		new JQuery( this._clearCompleted ).on( 'click', this._onClearCompleted );
		new JQuery( this._toggleAll ).on( 'click', this._onToggleAll );
		new JQuery( this._todoList ).delegate( 'li label', 'dblclick', this._onEditItem );
		new JQuery( this._todoList ).delegate( '.destroy', 'click', this._onRemoveItem );
		new JQuery( this._todoList ).delegate( '.toggle', 'click', this._onToggleComplete );
		new JQuery( this._todoList ).delegate( 'li .edit', 'blur', this._onItemSave );
		new JQuery( this._todoList ).delegate( 'li .edit', 'keypress', this._onItemKeyPress );
		new JQuery( this._todoList ).delegate( 'li .edit', 'keyup', this._onEditItemCancel );
		new JQuery( Browser.window ).on( 'hashchange', _onHashChange );
	}
	
	/**
	 * UIs callbacks
	 */
	function _onHashChange( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onHashChange', e] );
		#end
		
		var location : String = ( cast e.target ).location.hash;
		var route = location.split( '/' )[ 1 ];
		
		var filter = switch( route )
		{
			case "active": Filter.ACTIVE;
			case "completed": Filter.COMPLETED;
			case _: Filter.ALL;
		}
		this._controller.setFilter( filter ); 
	}
	
	function _onNewTodo( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onNewTodo', e] );
		#end
		
		this._controller.addItem( ( cast e.target ).value ); 
	}
	
	function _onClearCompleted( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onClearCompleted', e] );
		#end
		
		this._controller.removeCompletedItems();
	}
	
	function _onToggleAll( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onToggleAll', e] );
		#end
		
		this._controller.toggleAll( ( cast e.target ).checked );
	}
	
	function _onEditItem( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onEditItem', e] );
		#end
		
		this._controller.editItem( this._itemID( cast e.target ) );
	}
	
	function _onRemoveItem( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onRemoveItem', e] );
		#end
		
		this._controller.removeItem( this._itemID( cast e.target ) );
	}
	
	function _onToggleComplete( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onToggleComplete', e] );
		#end
		
		this._controller.toggleComplete( this._itemID( cast e.target ), ( cast e.target ).checked );
	}
	
	function _onItemSave( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onItemSave', e] );
		#end
		
		var li : LIElement = ( cast e.target );
		if ( li.dataset.iscanceled != 'undefined' ) 
		{
			this._controller.editItemSave( new JQuery( li ).parent().attr( 'data-id' ), "" + li.value );
		}
	}
	
	function _onItemKeyPress( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onItemKeyPress', e] );
		#end
		
		if ( e.keyCode == 13 ) 
		{
			var li : LIElement = ( cast e.target );
			li.blur();
		}
	}

	function _onEditItemCancel( e : js.jquery.Event ) : Void
	{
		#if debug
		logger.debug( ['TodoViewJS._onEditItemCancel', e] );
		#end
		
		if ( e.keyCode == 27 ) 
		{
			var li : LIElement = ( cast e.target );
			li.dataset.iscanceled = "true";
			li.blur();

			this._controller.editItemCancel( this._itemID( li ) );
		}
	}
	
	/**
	 * ITodoView implementation
	 */
	public function selectAllFilterButton() : Void
	{
		this._setFilter( '' );
	}
	
	public function selectActiveFilterButton() : Void
	{
		this._setFilter( 'active' );
	}
	
	public function selectCompletedFilterButton() : Void
	{
		this._setFilter( 'completed' );
	}
	
	/**
	 * ITodoConnection implementation
	 */
	public function showEntries( entries : Array<TodoItem> ) : Void 
	{
		this._todoList.innerHTML = this._template.show( entries );
	}
	
	public function removeItem(  id : String ) : Void 
	{
		this._removeItem( id );
	}
	
	public function updateElementCount( activeTodos : Int ) : Void 
	{
		this._todoItemCounter.innerHTML = this._template.itemCounter( activeTodos );
	}
	
	public function clearCompletedButton( completedCount : Int, visible : Bool ) : Void 
	{
		this._clearCompletedButton( completedCount, visible );
	}
	
	public function showFooter( isVisible : Bool ) : Void 
	{
		this._main.style.display = this._footer.style.display = isVisible ? 'block' : 'none';
	}
	
	public function toggleAll( isChecked : Bool ) : Void 
	{
		this._toggleAll.checked = isChecked;
	}
	
	public function clearNewTodo() : Void
	{
		this._newTodo.value = '';
	}
	
	public function elementComplete( id : String, isCompleted : Bool ) : Void 
	{
		this._elementComplete( id, isCompleted );
	}
	
	public function editItem( id : String, title : String ) : Void
	{
		this._editItem( id, title );
	}
	
	public function editItemDone( id : String, title : String ) : Void
	{
		this._editItemDone( id, title );
	}
	
	function _removeItem( id : String ) : Void
	{
		var elem = this._qs( '[data-id="' + id + '"]' );

		if ( elem != null ) 
		{
			this._todoList.removeChild( elem );
		}
	}
	
	//private
	function _setFilter( currentFilter : String ) : Void
	{
		this._qs( '.filters .selected' ).className = '';
		this._qs( '.filters [href="#/' + currentFilter + '"]' ).className = 'selected';
	}
	
	function _itemID( element ) : String
	{
		return new JQuery( element ).parent().parent().attr( 'data-id' );
	}

	function _clearCompletedButton( completedTodos : Int, visible : Bool ) : Void
	{
		this._clearCompleted.innerHTML = this._template.clearCompletedButton( completedTodos );
		this._clearCompleted.style.display = visible ? 'block' : 'none';
	}

	function _elementComplete( id, completed ) : Void
	{
		var listItem = this._qs( '[data-id="' + id + '"]' );

		if ( listItem != null ) 
		{
			listItem.className = completed ? 'completed' : '';

			// In case it was toggled from an event and not by clicking the checkbox
			//qs( 'input', listItem ).checked = completed;
			var input : InputElement = cast listItem.querySelector( 'input' );
			input.checked = completed;
		}
	}

	function _editItem( id, title ) : Void
	{
		trace( '_editItem', id, title );
		var listItem = this._qs('[data-id="' + id + '"]');

		if ( listItem != null ) 
		{
			listItem.className = listItem.className + ' editing';

			var input : InputElement = cast Browser.document.createElement( 'input' );
			input.className = 'edit';

			listItem.appendChild( input );
			input.focus();
			input.value = title;
		}
	}

	function _editItemDone( id, title ) : Void
	{
		var listItem = this._qs( '[data-id="' + id + '"]' );

		if ( listItem != null ) 
		{
			var input : InputElement = cast listItem.querySelector( 'input.edit' );
			listItem.removeChild( input );
			listItem.className = listItem.className.split( 'editing' ).join( '' );

			var list = listItem.querySelectorAll( 'label' );
			for ( label in list )
			{
				( cast label ).textContent = title;
			}
		}
	}
}