import { Elm } from "./elm/Main";

const app = Elm.Main.init({
  flags: { token: localStorage.getItem("token") },
  node: document.getElementById("app"),
});

app.ports.saveToken.subscribe((token) => {
  localStorage.setItem("token", token);
});

app.ports.clearToken_.subscribe(() => {
  localStorage.removeItem("token");
});
