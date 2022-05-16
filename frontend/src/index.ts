import { Elm } from "./elm/Main.elm";
import * as User from "./ts/user";

const app = Elm.Main.init({
  flags: { user: User.load() },
  node: document.getElementById("app"),
});

app.ports.saveUser.subscribe((user) => {
  User.save(user);
});

app.ports.logout_.subscribe(() => {
  User.clear();
});
