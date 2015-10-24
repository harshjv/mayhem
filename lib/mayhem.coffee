Map = require './map'
{CompositeDisposable} = require 'atom'

module.exports = Mayhem =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable

    @subscriptions.add atom.commands.add 'atom-workspace', 'mayhem:boom': => @boom()
    @subscriptions.add atom.commands.add 'atom-workspace', 'mayhem:fix': => @fix()

  deactivate: ->
    @subscriptions.dispose()

  transform: (map) ->
    if editor = atom.workspace.getActiveTextEditor()
        ranges = editor.getSelectedBufferRanges()
        if not text = editor.getSelectedText()
            text = editor.getText()
        k = 0
        newText = ""
        while k < text.length
            ch = text.charAt(k)
            if map[ch]?
                ch = map[ch]
            ++k
            newText += ch
        editor.setText(newText)

  boom: ->
    @transform(Map.boom)

  fix: ->
    @transform(Map.fix)
