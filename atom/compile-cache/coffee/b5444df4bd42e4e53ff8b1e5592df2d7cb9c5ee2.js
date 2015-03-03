(function() {
  var exec;

  exec = require("child_process").exec;

  module.exports = {
    config: {
      application: {
        type: 'string',
        "default": 'Marked 2.app'
      }
    },
    activate: function(state) {
      return atom.workspaceView.command("marked:open", (function(_this) {
        return function() {
          return _this.openMarked();
        };
      })(this));
    },
    openMarked: function() {
      var app, path, _ref, _ref1;
      path = (_ref = atom.workspace.getActiveEditor().buffer) != null ? (_ref1 = _ref.file) != null ? _ref1.path : void 0 : void 0;
      app = atom.config.get('marked.application');
      if (path != null) {
        return exec("open -a \"" + app + "\" \"" + path + "\"");
      }
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLElBQUE7O0FBQUEsRUFBQSxJQUFBLEdBQU8sT0FBQSxDQUFRLGVBQVIsQ0FBd0IsQ0FBQyxJQUFoQyxDQUFBOztBQUFBLEVBRUEsTUFBTSxDQUFDLE9BQVAsR0FDRTtBQUFBLElBQUEsTUFBQSxFQUNFO0FBQUEsTUFBQSxXQUFBLEVBQ0U7QUFBQSxRQUFBLElBQUEsRUFBTSxRQUFOO0FBQUEsUUFDQSxTQUFBLEVBQVMsY0FEVDtPQURGO0tBREY7QUFBQSxJQUlBLFFBQUEsRUFBVSxTQUFDLEtBQUQsR0FBQTthQUNSLElBQUksQ0FBQyxhQUFhLENBQUMsT0FBbkIsQ0FBMkIsYUFBM0IsRUFBMEMsQ0FBQSxTQUFBLEtBQUEsR0FBQTtlQUFBLFNBQUEsR0FBQTtpQkFBRyxLQUFDLENBQUEsVUFBRCxDQUFBLEVBQUg7UUFBQSxFQUFBO01BQUEsQ0FBQSxDQUFBLENBQUEsSUFBQSxDQUExQyxFQURRO0lBQUEsQ0FKVjtBQUFBLElBT0EsVUFBQSxFQUFZLFNBQUEsR0FBQTtBQUNWLFVBQUEsc0JBQUE7QUFBQSxNQUFBLElBQUEsaUdBQW9ELENBQUUsc0JBQXRELENBQUE7QUFBQSxNQUNBLEdBQUEsR0FBTSxJQUFJLENBQUMsTUFBTSxDQUFDLEdBQVosQ0FBZ0Isb0JBQWhCLENBRE4sQ0FBQTtBQUVBLE1BQUEsSUFBeUMsWUFBekM7ZUFBQSxJQUFBLENBQU0sWUFBQSxHQUFXLEdBQVgsR0FBZ0IsT0FBaEIsR0FBc0IsSUFBdEIsR0FBNEIsSUFBbEMsRUFBQTtPQUhVO0lBQUEsQ0FQWjtHQUhGLENBQUE7QUFBQSIKfQ==
//# sourceURL=/Users/jmuraski/.atom/packages/marked/lib/marked.coffee