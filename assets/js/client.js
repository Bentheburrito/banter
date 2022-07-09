
// Expand or collapse a post's content on the main posts page
export function expandCollapsePostBody () {
  let classes = this.el.getAttribute("class").split(" ");
  console.log(classes);
  if (classes.includes("post-body--minimized")) {
    this.el.setAttribute("class", classes.filter(c => c != "post-body--minimized").join(" "));
  } else {
    this.el.setAttribute("class", classes.append("post-body--minimized").join(" "));
  }
}