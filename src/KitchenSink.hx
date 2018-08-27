package;

import js.Browser.*;
import coconut.ww.*;
import coconut.ui.*;


class KitchenSink extends coconut.ui.View {
	
	static function main() {
		new KitchenSink({}).mount(document.body);
	}
	
	@:state var dropdown:String = null;
	
	function render() '
		<div>
			<h1>Checkbox</h1>
			<Checkbox ontoggle=${(checked:Bool) -> trace('Checkbox checked: $checked')}>Label</Checkbox>
			
			<h1>DropdownSelect</h1>
			<DropdownSelect
				value=${dropdown}
				options=${[for(i in 0...5) '$i']}
				onchange=${value -> dropdown = value}
				renderer=${(v:String) -> [(v:RenderResult)]}
			/>
		</div>
	';
}