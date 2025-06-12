// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import ToggleController from "./toggle_controller"
application.register("toggle", ToggleController)
eagerLoadControllersFrom("controllers", application)

const application = Application.start()
const context = require.context(".", true, /\.js$/)
application.load(definitionsFromContext(context))
