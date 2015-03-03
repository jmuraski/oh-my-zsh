(function() {
  var CliStatusView;

  CliStatusView = require('./cli-status-view');

  module.exports = {
    cliStatusView: null,
    activate: function(state) {
      var createStatusEntry;
      createStatusEntry = (function(_this) {
        return function() {
          return _this.cliStatusView = new CliStatusView(state.cliStatusViewState);
        };
      })(this);
      if (atom.workspaceView.statusBar) {
        return createStatusEntry();
      } else {
        return atom.packages.once('activated', function() {
          return createStatusEntry();
        });
      }
    },
    deactivate: function() {
      return this.cliStatusView.destroy();
    },
    configDefaults: {
      'WindowHeight': 300
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLGFBQUE7O0FBQUEsRUFBQSxhQUFBLEdBQWdCLE9BQUEsQ0FBUSxtQkFBUixDQUFoQixDQUFBOztBQUFBLEVBRUEsTUFBTSxDQUFDLE9BQVAsR0FDRTtBQUFBLElBQUEsYUFBQSxFQUFlLElBQWY7QUFBQSxJQUVBLFFBQUEsRUFBVSxTQUFDLEtBQUQsR0FBQTtBQUNSLFVBQUEsaUJBQUE7QUFBQSxNQUFBLGlCQUFBLEdBQW9CLENBQUEsU0FBQSxLQUFBLEdBQUE7ZUFBQSxTQUFBLEdBQUE7aUJBQ2xCLEtBQUMsQ0FBQSxhQUFELEdBQXFCLElBQUEsYUFBQSxDQUFjLEtBQUssQ0FBQyxrQkFBcEIsRUFESDtRQUFBLEVBQUE7TUFBQSxDQUFBLENBQUEsQ0FBQSxJQUFBLENBQXBCLENBQUE7QUFHQSxNQUFBLElBQUcsSUFBSSxDQUFDLGFBQWEsQ0FBQyxTQUF0QjtlQUNFLGlCQUFBLENBQUEsRUFERjtPQUFBLE1BQUE7ZUFHRSxJQUFJLENBQUMsUUFBUSxDQUFDLElBQWQsQ0FBbUIsV0FBbkIsRUFBZ0MsU0FBQSxHQUFBO2lCQUM5QixpQkFBQSxDQUFBLEVBRDhCO1FBQUEsQ0FBaEMsRUFIRjtPQUpRO0lBQUEsQ0FGVjtBQUFBLElBWUEsVUFBQSxFQUFZLFNBQUEsR0FBQTthQUNWLElBQUMsQ0FBQSxhQUFhLENBQUMsT0FBZixDQUFBLEVBRFU7SUFBQSxDQVpaO0FBQUEsSUFrQkEsY0FBQSxFQUNFO0FBQUEsTUFBQSxjQUFBLEVBQWdCLEdBQWhCO0tBbkJGO0dBSEYsQ0FBQTtBQUFBIgp9
//# sourceURL=/Users/jmuraski/.atom/packages/terminal-status/lib/cli-status.coffee