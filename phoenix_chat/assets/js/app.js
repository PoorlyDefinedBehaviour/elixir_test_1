// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss";

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
import socket from "./socket";
//
import "phoenix_html";

const channel = socket.channel("chat_room:lobby", {});
const messages = document.querySelector("#messages");
const messageInput = document.querySelector("#messageInput");
const nameInput = document.querySelector("#nameInput");

messageInput.addEventListener("keyup", (event) => {
  const enterKeyCode = 13;

  console.log("aaaaa", event.keyCode);

  if (event.keyCode !== enterKeyCode) {
    return;
  }

  channel.push("shout", {
    name: nameInput.value,
    message: messageInput.value,
  });

  messageInput.value = "";
});

channel.on("shout", ({ name, message }) => {
  const element = document.createElement("p");

  element.innerHTML = `<b>${name || "new_user"}: ${message}</b>`;

  messages.appendChild(element);

  messages.scrollTop = messages.scrollHeight;
});

channel
  .join()
  .receive("ok", (response) => console.log("Channel joined", response))
  .receive("error", (response) => console.error("Unable to join", response));
