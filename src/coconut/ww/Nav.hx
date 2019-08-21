package coconut.ww;

typedef NavItem = {
  final ?disabled:Bool;
  final title:Children;
  final ?style:coconut.ww._internal.StyleProvider<{ final selected:Bool; }>;
}

class Nav extends View {
  
  static final ROOT = css('
    display: flex;
  ');

  @:attribute var selectedIndex:Int;
  @:attribute function onselect(index:Int):Void;
  
  @:attribute var items:tink.pure.Slice<NavItem>;

  function render() '
    <nav class=$ROOT>
      <for ${i in 0...items.length}>
        <NavButton item=${items[i]} selected=${i == selectedIndex} onselect=${onselect(i)} />
      </for>
    </nav>
  ';
}

private class NavButton extends View {

  static final ROOT = css('
    background: none;
    border: none;
    padding: 1em;
    flex-grow: 1;
  ');

  @:attribute var item:NavItem;
  @:computed var className:ClassName = switch item.style {
    case null: null;
    case f: f.getClass({ selected: selected });
  }

  @:attribute var selected:Bool;
  @:attribute function onselect():Void;

  function render() '
    <button 
        class=${ROOT.add(className)} 
        onclick=${onselect}
        disabled=${item.disabled}
      >
      ${...item.title}
    </button>
  ';
}