(function() {
  var CliStatusView, CommandOutputView, View, domify,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  View = require('atom').View;

  domify = require('domify');

  CommandOutputView = require('./command-output-view');

  module.exports = CliStatusView = (function(_super) {
    __extends(CliStatusView, _super);

    function CliStatusView() {
      return CliStatusView.__super__.constructor.apply(this, arguments);
    }

    CliStatusView.content = function() {
      return this.div({
        "class": 'cli-status inline-block'
      }, (function(_this) {
        return function() {
          _this.span({
            outlet: 'termStatusContainer'
          }, function() {});
          return _this.span({
            click: 'newTermClick',
            "class": "cli-status icon icon-plus"
          });
        };
      })(this));
    };

    CliStatusView.prototype.commandViews = [];

    CliStatusView.prototype.activeIndex = 0;

    CliStatusView.prototype.initialize = function(serializeState) {
      atom.workspaceView.command('terminal-status:new', (function(_this) {
        return function() {
          return _this.newTermClick();
        };
      })(this));
      atom.workspaceView.command('terminal-status:toggle', (function(_this) {
        return function() {
          return _this.toggle();
        };
      })(this));
      atom.workspaceView.command('terminal-status:next', (function(_this) {
        return function() {
          return _this.activeNextCommandView();
        };
      })(this));
      atom.workspaceView.command('terminal-status:prev', (function(_this) {
        return function() {
          return _this.activePrevCommandView();
        };
      })(this));
      this.createCommandView();
      return this.attach();
    };

    CliStatusView.prototype.createCommandView = function() {
      var commandOutputView, termStatus;
      termStatus = domify('<span class="cli-status icon icon-terminal"></span>');
      commandOutputView = new CommandOutputView;
      commandOutputView.statusIcon = termStatus;
      commandOutputView.statusView = this;
      this.commandViews.push(commandOutputView);
      termStatus.addEventListener('click', (function(_this) {
        return function() {
          return commandOutputView.toggle();
        };
      })(this));
      this.termStatusContainer.append(termStatus);
      return commandOutputView;
    };

    CliStatusView.prototype.activeNextCommandView = function() {
      return this.activeCommandView(this.activeIndex + 1);
    };

    CliStatusView.prototype.activePrevCommandView = function() {
      return this.activeCommandView(this.activeIndex - 1);
    };

    CliStatusView.prototype.activeCommandView = function(index) {
      if (index >= this.commandViews.length) {
        index = 0;
      }
      if (index < 0) {
        index = this.commandViews.length - 1;
      }
      return this.commandViews[index] && this.commandViews[index].open();
    };

    CliStatusView.prototype.setActiveCommandView = function(commandView) {
      return this.activeIndex = this.commandViews.indexOf(commandView);
    };

    CliStatusView.prototype.removeCommandView = function(commandView) {
      var index;
      index = this.commandViews.indexOf(commandView);
      return index >= 0 && this.commandViews.splice(index, 1);
    };

    CliStatusView.prototype.newTermClick = function() {
      return this.createCommandView().toggle();
    };

    CliStatusView.prototype.attach = function() {
      return atom.workspaceView.statusBar.appendLeft(this);
    };

    CliStatusView.prototype.destroy = function() {
      var index, _i, _ref;
      for (index = _i = _ref = this.commandViews.length; _ref <= 0 ? _i <= 0 : _i >= 0; index = _ref <= 0 ? ++_i : --_i) {
        this.removeCommandView(this.commandViews[index]);
      }
      return this.detach();
    };

    CliStatusView.prototype.toggle = function() {
      return this.commandViews[this.activeIndex] && this.commandViews[this.activeIndex].toggle();
    };

    return CliStatusView;

  })(View);

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLDhDQUFBO0lBQUE7bVNBQUE7O0FBQUEsRUFBQyxPQUFRLE9BQUEsQ0FBUSxNQUFSLEVBQVIsSUFBRCxDQUFBOztBQUFBLEVBQ0EsTUFBQSxHQUFTLE9BQUEsQ0FBUSxRQUFSLENBRFQsQ0FBQTs7QUFBQSxFQUVBLGlCQUFBLEdBQW9CLE9BQUEsQ0FBUSx1QkFBUixDQUZwQixDQUFBOztBQUFBLEVBSUEsTUFBTSxDQUFDLE9BQVAsR0FDTTtBQUNKLG9DQUFBLENBQUE7Ozs7S0FBQTs7QUFBQSxJQUFBLGFBQUMsQ0FBQSxPQUFELEdBQVUsU0FBQSxHQUFBO2FBQ1IsSUFBQyxDQUFBLEdBQUQsQ0FBSztBQUFBLFFBQUEsT0FBQSxFQUFPLHlCQUFQO09BQUwsRUFBdUMsQ0FBQSxTQUFBLEtBQUEsR0FBQTtlQUFBLFNBQUEsR0FBQTtBQUNyQyxVQUFBLEtBQUMsQ0FBQSxJQUFELENBQU07QUFBQSxZQUFBLE1BQUEsRUFBUSxxQkFBUjtXQUFOLEVBQXFDLFNBQUEsR0FBQSxDQUFyQyxDQUFBLENBQUE7aUJBQ0EsS0FBQyxDQUFBLElBQUQsQ0FBTTtBQUFBLFlBQUEsS0FBQSxFQUFPLGNBQVA7QUFBQSxZQUF1QixPQUFBLEVBQU8sMkJBQTlCO1dBQU4sRUFGcUM7UUFBQSxFQUFBO01BQUEsQ0FBQSxDQUFBLENBQUEsSUFBQSxDQUF2QyxFQURRO0lBQUEsQ0FBVixDQUFBOztBQUFBLDRCQUtBLFlBQUEsR0FBYyxFQUxkLENBQUE7O0FBQUEsNEJBTUEsV0FBQSxHQUFhLENBTmIsQ0FBQTs7QUFBQSw0QkFPQSxVQUFBLEdBQVksU0FBQyxjQUFELEdBQUE7QUFDVixNQUFBLElBQUksQ0FBQyxhQUFhLENBQUMsT0FBbkIsQ0FBMkIscUJBQTNCLEVBQWtELENBQUEsU0FBQSxLQUFBLEdBQUE7ZUFB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
//# sourceURL=/Users/jmuraski/.atom/packages/terminal-status/lib/cli-status-view.coffee