LinterRailsBestPracticesView = require './linter-rails-best-practices-view'
{CompositeDisposable} = require 'atom'

module.exports = LinterRailsBestPractices =
  linterRailsBestPracticesView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @linterRailsBestPracticesView = new LinterRailsBestPracticesView(state.linterRailsBestPracticesViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @linterRailsBestPracticesView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'linter-rails-best-practices:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @linterRailsBestPracticesView.destroy()

  serialize: ->
    linterRailsBestPracticesViewState: @linterRailsBestPracticesView.serialize()

  toggle: ->
    console.log 'LinterRailsBestPractices was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
