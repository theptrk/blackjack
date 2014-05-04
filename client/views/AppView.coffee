class window.AppView extends Backbone.View

  template: _.template '
      <button class="restart-button">New Game</button>
    <div class="game"></div>
  '
  events:
    "click .restart-button": -> @model.newGame()

  initialize: ->
    @model.on 'restart', => @restartedGame()
    @render()

  restartedGame: ->
    @model.on 'restartedGame', @render()


  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.game').html new GameView(model: @model.get('game')).el
