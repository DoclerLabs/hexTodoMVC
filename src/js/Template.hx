package js;

import common.TodoItem;

using StringTools;

/**
 * ...
 * @author Francis Bourre
 */
class Template
{
	public var items( default, null ) : haxe.Template = new haxe.Template 
		( '::foreach items::'
		+ '<li data-id="::id::" class="::if completed::completed::end::">'
		+		'<div class="view">'
		+			'<input class="toggle" type="checkbox" ::if completed::checked::end::>'
		+			'<label>::title::</label>'
		+			'<button class="destroy"></button>'
		+		'</div>'
		+	'</li>'
		+	'::end::' );
		
	public var activeItems( default, null ) : haxe.Template = new haxe.Template 
		( '<strong>::activeItems::</strong> item::if (activeItems>1)::s::end:: left' );
		
	public var completedCount( default, null ) : haxe.Template = new haxe.Template 
		( '::if (completedCount>0)::Clear completed::end::' );

	public function new() {}
}