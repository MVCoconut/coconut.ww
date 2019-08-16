package coconut.ww;

// @:less('root.less')//TODO: add somewhere else
class TabSwitcher extends View {

  static final ROOT = css('
    min-height: 400px;
    min-width: 300px;
    background: blanchedalmond;
    display: flex;
    flex-direction: column;

    &>nav {
      &>button {
        background: none;
        border: none;
        padding: 1em 2em;
        flex-grow: 1;
      }
      flex-grow: 0;
    }
    &[data-bottom] {
     & >nav {
        order: 2;
      }
    }
  ');

  static final CONTENT = css('
    flex-grow: 1;
  ');

  @:attribute var className:ClassName = null;
  @:attribute var bottom:Bool = false;
  @:attribute var children:tink.pure.Slice<Tab>;
  
  @:state var selectedIndex:Int = 0;
  
  function render() '
    <div class=${ROOT.add(className)} data-bottom=${bottom}>
      
      <nav>
        <for ${i in 0...children.length}>
          <TabButton ${...children[i]} selected=${i == selectedIndex} onselect=${selectedIndex = i} />
        </for>
      </nav>

      <PaneSwitcher class=${CONTENT} selectedIndex=${selectedIndex} total=${children.length} onselect=${selectedIndex = event}>
        <pane>
          <TabPane status=${status} tab=${children[index]} />
        </pane>
      </PaneSwitcher>

    </div>
  ';
}

private class TabButton extends View {
  @:attribute var className:ClassName = null;
  @:attribute var title:Children;
  @:attribute var disabled:Bool = false;
  @:attribute var selected:Bool;
  @:attribute function onselect():Void;

  function render() '
    <button 
        class=${className} 
        onclick=${onselect}
        data-selected=${selected}
        disabled=${disabled}
      >
      ${...title}
    </button>
  ';
}

private class TabPane extends View {
  
  @:attribute var tab:Tab;
  @:attribute var status:PaneStatus;

  function render() '
    <div class=${tab.className}>
      <for ${c in tab.content({ status: status })}>${c}</for>
    </div>
  ';  
}