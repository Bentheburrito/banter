// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}

// Copy/pasted from https://github.com/phoenixframework/phoenix_live_view/issues/1011. Maintains textarea size
Hooks.MaintainAttrs = {
  attrs () { return this.el.getAttribute("data-attrs").split(", ") },
  beforeUpdate () { this.prevAttrs = this.attrs().map(name => [name, this.el.getAttribute(name)]) },
  updated () { this.prevAttrs.forEach(([name, val]) => this.el.setAttribute(name, val)) }
}

Hooks.ExpandCollapse = {
  mounted () {
    let postBodyContainerId = this.el.id.replace("status", "container");
    let postBodyContainer = document.querySelector(`#${postBodyContainerId}`);

    // If the post body has overflow, add an onClick event listener to toggle expanding/collapsing the post body.
    if (postBodyContainer.scrollHeight > postBodyContainer.clientHeight) {
      this.el.addEventListener("click", () => expandCollapsePostBody(this.el, postBodyContainer));
      setPostBodyStatus(this.el, "/images/down_arrow.png")
    } else {
      // Otherwise, remove this element (the expand/collapse button/arrow image)
      this.el.remove();
    }
  }
}


let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken }, hooks: Hooks })

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

//// CLIENT-SIDE FUNCTIONS ////

// Expand or collapse a post's content on the main posts page
function expandCollapsePostBody (statusImg, postBodyContainer) {

  let classes = postBodyContainer.getAttribute("class").split(" ");

  if (classes.includes("post-body--minimized")) {
    postBodyContainer.setAttribute("class", classes.filter(c => c != "post-body--minimized").join(" "));
    setPostBodyStatus(statusImg, "/images/up_arrow.png");
  } else {
    classes.push("post-body--minimized");
    postBodyContainer.setAttribute("class", classes.join(" "));
    setPostBodyStatus(statusImg, "/images/down_arrow.png");
  }
}

function setPostBodyStatus (postStatusImage, statusImg) {
  postStatusImage.setAttribute("src", statusImg);
}

// This for loop and the above expandCollapsePostBody fn were in client.js, but with liveview when opening a post
// the event listener would disappear, so had to add a phx-hook to assign the event listener on mount instead.
// for (let postBody of document.querySelectorAll(".post-body-container")) {
//   this.addEventListener("click", expandCollapsePostBody);
// }
