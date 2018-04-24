package coconut.ww;

class TabSwitcher extends View {
  @:attribute var className:ClassName = null;
  @:attribute var bottom:Bool = false;
  @:skipCheck @:attribute var children:tink.pure.Slice<Tab>;
  @:state var selectedIndex:Int = 0;
  function render() '
    <div class={className.add("cc-tabswitcher")} data-bottom={bottom}>
      
      <nav class="cc-tabbar">
        <for {i in 0...children.length}>
          <TabButton {...children[i]} selected={i == selectedIndex} onselect={selectedIndex = i} />
        </for>
      </nav>

      <PaneSwitcher selectedIndex={selectedIndex} total={children.length} onselect={selectedIndex = event}>
        <pane>
          <TabPane status={status} tab={children[index]} />
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
        class={className.add("cc-tab")} 
        onclick={onselect}
        data-selected={selected}
        disabled={disabled}
      >
      {...title}
    </button>
  ';
}

private class TabPane extends View {
  @:attribute var tab:Tab;
  @:attribute var status:PaneStatus;
  function render() '
    <div>
      <for {c in tab.content({ status: status })}>{c}</for>
    </div>
  ';  
}