package coconut.ww;

/**
 * A popover, not unlike Bootstrap's: https://getbootstrap.com/docs/4.0/components/popovers/
 *
 * It is guaranteed to have two children, that can only be selected by tag name:
 * 
 * - a button, that does the actual toggling
 * - a div, that contains the popover
 */
@:less('popover.less')
class Popover extends View {
  
  @:state var isOpen:Bool = false;
  
  @:attribute var className:ClassName = null;
  
  @:attribute function toggler(attr:{ isOpen:Bool }):Children;
  
  @:attribute var content:Children;

  @:attribute var side:PopoverSide = PopoverSide.Bottom;

  @:attribute function leaveOpen(e:Element):Bool return false;

  function open() {
    isOpen = true;
    @in(0) @do {
      if (isOpen) document.addEventListener('click', close);
    }
  }

  function render() '
    <div class=${className.add("cc-popover")} data-side=${(side:String)} data-open=${isOpen}>
      <button type="button" onclick=${if (!isOpen) open()}>
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

  override function afterDestroy(_)
    close();
}