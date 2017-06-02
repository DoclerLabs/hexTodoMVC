package;

import hex.compiletime.xml.BasicStaticXmlCompiler;
import hex.domain.TopLevelDomain;
import hex.log.LogManager;
import hex.log.DomainLoggerContext;
import hex.log.TraceEverythingDomainConfiguration;
import hex.runtime.ApplicationAssembler;

/**
 * ...
 * @author Francis Bourre
 */
class TodoMVC
{
	static public function main() : Void
	{
		#if debug
			LogManager.context = new DomainLoggerContext(TopLevelDomain.DOMAIN);
			DomainLoggerContext.getContext().setConfiguration(new TraceEverythingDomainConfiguration());
		#end
		// convert XML DSL to haxe code by Macro
		var code = BasicStaticXmlCompiler.compile( new ApplicationAssembler(), "configuration/context.xml" );
		code.execute();
	}
}