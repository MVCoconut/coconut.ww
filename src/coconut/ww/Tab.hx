package coconut.ww;

class Tab implements Model {
  @:constant var className:ClassName = null;
  @:constant var title:Children;
  @:constant var disabled:Bool = false;
  @:constant var content:{ var status(default, never):PaneStatus; }->Children;
}