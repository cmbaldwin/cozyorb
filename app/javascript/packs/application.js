// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("@popperjs/core")

//var Trix = require("trix")
import * as Trix from "trix"
require("@rails/actiontext")
import * as Nav from './nav'

document.addEventListener("trix-initialize", event => {
  const { toolbarElement } = event.target
  const blockTools = toolbarElement.querySelector("[data-trix-button-group=block-tools]")
  blockTools.insertAdjacentHTML("afterbegin", `
    <button type="button" class="trix-button" data-trix-action="x-horizontal-rule" title="Horizontal Rule" tabindex="-1">━</button>
  `)
})

document.addEventListener("trix-action-invoke", event => {
  if (event.actionName == "x-horizontal-rule") {
    const { editor } = event.target
    const attachment = new Trix.Attachment({ content: "<hr>", contentType: "vnd.rubyonrails.horizontal-rule.html" })
    editor.insertAttachment(attachment)
  }
})

document.addEventListener('turbolinks:load', () => {
  // Navigation
  Nav.mobileNav()
  setTimeout(function () {
    document.querySelectorAll('.notice_alert').forEach(
      element => {
        element.style.display = 'none'
      });
  }, 2000);
})