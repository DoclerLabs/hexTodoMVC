package js;

import todomvc.model.TodoItem;

using StringTools;

/**
 * ...
 * @author Francis Bourre
 */
class Template
{
	public var defaultTemplate( default, null ) : String 
	=	'<li data-id="{{id}}" class="{{completed}}">'
		+		'<div class="view">'
		+			'<input class="toggle" type="checkbox" {{checked}}>'
		+			'<label>{{title}}</label>'
		+			'<button class="destroy"></button>'
		+		'</div>'
		+	'</li>';
	
	public function new() 
	{
		
	}
	
	/**
	 * Creates an <li> HTML string and returns it for placement in your app.
	 *
	 * NOTE: In real life you should be using a templating engine such as Mustache
	 * or Handlebars, however, this is a vanilla JS example.
	 *
	 * @param {object} data The object containing keys you want to find in the
	 *                      template to replace.
	 * @return {string} HTML String of an <li> element
	 *
	 * @example
	 * view.show({
	 *	id: 1,
	 *	title: "Hello World",
	 *	completed: 0,
	 * });
	 */
	public function show( data : Array<TodoItem> ) : String
	{
		var i, l;
		var view = '';

		for ( i in 0... data.length ) 
		{
			var template = this.defaultTemplate;
			var completed = '';
			var checked = '';

			if ( data[ i ].completed ) 
			{
				completed = 'completed';
				checked = 'checked';
			}

			template = template.replace( '{{id}}', data[ i ].id );
			template = template.replace( '{{title}}', this._escape( data[ i ].title ) );
			template = template.replace( '{{completed}}', completed );
			template = template.replace( '{{checked}}', checked );

			view = view + template;
		}

		return view;
	}
	
	/**
	 * Displays a counter of how many to dos are left to complete
	 *
	 * @param {number} activeTodos The number of active todos.
	 * @return {string} String containing the count
	 */
	public function itemCounter( activeTodos : Int ) : String
	{
		var plural = activeTodos == 1 ? '' : 's';
		return '<strong>' + activeTodos + '</strong> item' + plural + ' left';
	}

	/**
	 * Updates the text within the "Clear completed" button
	 *
	 * @param  {[type]} completedTodos The number of completed todos.
	 * @return {string} String containing the count
	 */
	public function clearCompletedButton( completedTodos : Int ) : String
	{
		return ( completedTodos > 0 ) ? 'Clear completed' : '';
	}
	
	//
	var reHasUnescapedHtml = ~/[&<>"'`]/g;

	function _escape ( string : String ) : String
	{
		return string.htmlEscape( true );
	}
}