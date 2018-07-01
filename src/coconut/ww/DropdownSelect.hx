package coconut.ww;

class DropdownSelect<T> extends View {
  @:attribute var className:ClassName = null;
  @:attribute var value:T;
  @:attribute var options:List<T>;
  @:attribute function onchange(value:T):Void;
  @:attribute function renderer(option:T):Children;
  function render() '
    <Popover class=${className.add("cc-dropdown-select")}>
      <toggler>
        ${...renderer(value)}
      </toggler>
      <content>
        <for ${o in options}>
          <if ${o != value}>
            <button onclick=${onchange(o)}>${...renderer(o)}</button>
          </if>
        </for>
      </content>
    </Popover>
  ';
}