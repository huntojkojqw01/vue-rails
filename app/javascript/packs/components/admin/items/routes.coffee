import Index from "./index"
import Edit from "./edit"

export default [
  { path: "",name: "items",component: Index }
  { path: ":id/edit", name: "edit item", component: Edit }
  { path: "new", name: "new item", component: Edit}
]