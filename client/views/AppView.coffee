class window.AppView extends Backbone.View

  template: _.template '
    <div class="game"></div>
  '
  initialize: ->

    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.game').html new GameView(model: @model.get('game')).el
