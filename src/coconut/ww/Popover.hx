package coconut.ww;

/**
 * A popover, not unlike Bootstrap's: https://getbootstrap.com/docs/4.0/components/popovers/
 *
 * It is guaranteed to have two children, that can only be selected by tag name:
 * 
 * - a button, that does the actual toggling
 * - a div, that contains the popover
 */
class Popover extends View {

  static final ROOT = css('
    position: relative;
    display: table;//TODO: figure out if this is really the best choice
    &>div:last-child {
      position: absolute;
      z-index: 10000;//TODO: find something slightly more reasonable
    }
    &:not([data-open])>div:last-child {
      display: none;//TODO: animated
    }

    &[data-side="top"]>div:last-child {
      bottom: 100%;
      left: 0;
    }
    &[data-side="bottom"]>div:last-child {
      top: 100%;
      left: 0;
    }
    &[data-side="left"]>div:last-child {
      right: 100%;
      top: 0;
    }
    &[data-side="right"]>div:last-child {
      left: 100%;
      top: 0;
    }  
  ');
  
  @:state var isOpen:Bool = false;
  
  @:attribute var className:ClassName = null;
  
  @:attribute function toggler(attr:{ final isOpen:Bool; }):Children;
  
  @:attribute var content:Children;

  @:attribute var side:PopoverSide = PopoverSide.Bottom;

  @:attribute function leaveOpen(e:Element):Bool return false;

  function toggle()
    if (isOpen) close();
    else open();

  function open() {
    isOpen = true;
    @in(0) @do {
      if (isOpen) document.addEventListener('click', close);
    }
  }

  function render() '
    <div class=${ROOT.add(className)} data-side=${(side:String)} data-open=${isOpen}>
      <button type="button" onclick=${toggle()}>
        ${...toggler({ isOpen: isOpen })}
      </button>
      <div onclick=${if (!leaveOpen(event.currentTarget)) close()}>
        ${...content}
      </div>
    </div>
  ';

  function close() {
    if (isOpen) document.removeEventListener('click', close);
    isOpen = false;
  }

  override function viewWillUnmount()
    close();
}