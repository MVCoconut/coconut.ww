package coconut.ww;

import coconut.ww.Nav;

typedef Tab = NavItem & {
  final content:{ final status:PaneStatus; }->Children;
}

class TabSwitcher extends View {

  static final ROOT = css('
    min-height: 400px;
    min-width: 300px;
    background: blanchedalmond;
    display: flex;
    flex-direction: column;

    &>*:first-child {
      flex-grow: 0;
    }
    
    &>*:last-child {
      flex-grow: 1;
    }
    
    &[data-bottom] {
     &>*:first-child {
        order: 2;
      }
    }
  ');

  @:attribute var className:ClassName = null;
  @:attribute var bottom:Bool = false;
  @:attribute var tabs:{ function tab(attr:Tab):Tab; }->tink.pure.Slice<Tab>;
  
  @:computed var allTabs:tink.pure.Slice<Tab> = tabs({ tab: t -> t});
  @:state var selectedIndex:Int = 0;
  // @:computed var items:tink.pure.Slice<Nav.NavItem> = 
  //   [for (tab in children) ({
  //     title: tab.title,
  //     disabled: tab.disabled
  //   }:Nav.NavItem)];
  
  function render() '
    <div class=${ROOT.add(className)} data-bottom=${bottom}>
      
      <Nav items=${allTabs} selectedIndex=$selectedIndex onselect=${selectedIndex = event} />

      <PaneSwitcher 
          selectedIndex=${selectedIndex} 
          total=${allTabs.length} onselect=${selectedIndex = event}
        >
        <pane>
          <Isolated>
            ${...allTabs[index].content({ status: status })}
          </Isolated>
        </pane>
      </PaneSwitcher>

    </div>
  ';
}