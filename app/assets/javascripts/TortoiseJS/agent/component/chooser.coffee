ChooserEditForm = EditForm.extend({

  data: {
    choices: undefined # String
    display: undefined # String
  }

  isolated: true

  components: {
    formVariable: RactiveEditFormVariable
    formCode:     RactiveEditFormCodeContainer
  }

  validate: (form) ->
    varName = form.varName.value
    # choices = form.codeChoices.value
    { display: varName, varName: varName.toLowerCase() } #, choices: form.choicesCode.value }

  partials: {

    title: "Chooser"

    widgetFields:
      """
      <formVariable id="{{id}}-varname" name="varName"     value="{{display}}" />
      <formCode     id="{{id}}-choices" name="choicesCode" value="{{choices}}" label="Choices" />
      """

  }

})

window.RactiveChooser = RactiveWidget.extend({

  isolated: true

  components: {
    editForm: ChooserEditForm
  }

  template:
    """
    <label id="{{id}}"
           on-contextmenu="showContextMenu:{{id + '-context-menu'}}"
           class="netlogo-widget netlogo-chooser netlogo-input"
           style="{{dims}}">
      <span class="netlogo-label">{{widget.display}}</span>
      <select class="netlogo-chooser-select" value="{{widget.currentValue}}">
      {{#widget.choices}}
        <option class="netlogo-chooser-option" value="{{.}}">{{>literal}}</option>
      {{/}}
      </select>
    </label>
    <div id="{{id}}-context-menu" class="netlogo-widget-editor-menu-items">
      <ul class="context-menu-list">
        <li class="context-menu-item" on-click="editWidget">Edit</li>
        <li class="context-menu-item" on-click="deleteWidget:{{id}},{{id + '-context-menu'}},{{widget.id}}">Delete</li>
      </ul>
    </div>
    <editForm idBasis="{{id}}" choices="{{widget.choices}}" display="{{widget.display}}" twoway="false"/>
    """

  partials: {

    literal:
      """
      {{# typeof . === "string"}}{{.}}{{/}}
      {{# typeof . === "number"}}{{.}}{{/}}
      {{# typeof . === "object"}}
        [{{#.}}
          {{>literal}}
        {{/}}]
      {{/}}
      """

  }

})
