package coconut.ww;

class Tab implements Model {
  @:constant var className:ClassName = @byDefault null;
  @:constant var title:Children;
  @:constant var disabled:Bool = @byDefault false;
  @:constant var content:{ final status:PaneStatus; }->Children;
}