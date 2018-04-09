import coconut.ww.*;

class Playground {
  static function main() {
    js.Browser.document.body.appendChild(
      coconut.Ui.hxx('
        <TabSwitcher>
          <Tab>
            <title>Home</title>
            <content>
              Tab content 1
            </content>
          </Tab>
          <Tab>
            <title>Search</title>
            <content>
              Tab content 2
            </content>
          </Tab>
          <Tab>
            <title>Notifications</title>
            <content>
              Tab content 3
            </content>
          </Tab>
          <Tab>
            <title>Messages</title>
            <content>
              Tab content 4
            </content>
          </Tab>
        </TabSwitcher>
      ').toElement()
    );
  }
}