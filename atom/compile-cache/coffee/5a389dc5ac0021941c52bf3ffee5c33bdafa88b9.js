(function() {
  var CommandOutputView, EditorView, View, addClass, ansihtml, exec, fs, lastOpenedView, readline, removeClass, resolve, spawn, _ref, _ref1, _ref2,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  _ref = require('atom'), View = _ref.View, EditorView = _ref.EditorView;

  _ref1 = require('child_process'), spawn = _ref1.spawn, exec = _ref1.exec;

  ansihtml = require('ansi-html-stream');

  readline = require('readline');

  _ref2 = require('domutil'), addClass = _ref2.addClass, removeClass = _ref2.removeClass;

  resolve = require('path').resolve;

  fs = require('fs');

  lastOpenedView = null;

  module.exports = CommandOutputView = (function(_super) {
    __extends(CommandOutputView, _super);

    function CommandOutputView() {
      this.flashIconClass = __bind(this.flashIconClass, this);
      return CommandOutputView.__super__.constructor.apply(this, arguments);
    }

    CommandOutputView.prototype.cwd = null;

    CommandOutputView.content = function() {
      return this.div({
        tabIndex: -1,
        "class": 'panel cli-status panel-bottom'
      }, (function(_this) {
        return function() {
          _this.div({
            "class": 'panel-heading'
          }, function() {
            return _this.div({
              "class": 'btn-group'
            }, function() {
              _this.button({
                outlet: 'killBtn',
                click: 'kill',
                "class": 'btn hide'
              }, function() {
                return _this.span('kill');
              });
              _this.button({
                click: 'destroy',
                "class": 'btn'
              }, function() {
                return _this.span('destroy');
              });
              return _this.button({
                click: 'close',
                "class": 'btn'
              }, function() {
                _this.span({
                  "class": "icon icon-x"
                });
                return _this.span('close');
              });
            });
          });
          return _this.div({
            "class": 'cli-panel-body'
          }, function() {
            _this.pre({
              "class": "terminal",
              outlet: "cliOutput"
            }, "Welcome to terminal status. http://github.com/guileen/terminal-status");
            return _this.subview('cmdEditor', new EditorView({
              mini: true,
              placeholderText: 'input your command here'
            }));
          });
        };
      })(this));
    };

    CommandOutputView.prototype.initialize = function() {
      var cmd;
      this.subscribe(atom.config.observe('terminal-status.WindowHeight', (function(_this) {
        return function() {
          return _this.adjustWindowHeight();
        };
      })(this)));
      this.userHome = process.env.HOME || process.env.HOMEPATH || process.env.USERPROFILE;
      cmd = 'test -e /etc/profile && source /etc/profile;test -e ~/.profile && source ~/.profile; node -pe "JSON.stringify(process.env)"';
      exec(cmd, function(code, stdout, stderr) {
        return process.env = JSON.parse(stdout);
      });
      atom.workspaceView.command("cli-status:toggle-output", (function(_this) {
        return function() {
          return _this.toggle();
        };
      })(this));
      return this.on("core:confirm", (function(_this) {
        return function() {
          var args, inputCmd;
          inputCmd = _this.cmdEditor.getEditor().getText();
          _this.cliOutput.append("\n$>" + inputCmd + "\n");
          _this.scrollToBottom();
          args = [];
          inputCmd.replace(/("[^"]*"|'[^']*'|[^\s'"]+)/g, function(s) {
            if (s[0] !== '"' && s[0] !== "'") {
              s = s.replace(/~/g, _this.userHome);
            }
            return args.push(s);
          });
          cmd = args.shift();
          if (cmd === 'cd') {
            return _this.cd(args);
          }
          if (cmd === 'ls') {
            return _this.ls(args);
          }
          return _this.spawn(inputCmd, cmd, args);
        };
      })(this));
    };

    CommandOutputView.prototype.adjustWindowHeight = function() {
      var maxHeight;
      maxHeight = atom.config.get('terminal-status.WindowHeight');
      return this.cliOutput.css("max-height", "" + maxHeight + "px");
    };

    CommandOutputView.prototype.showCmd = function() {
      this.cmdEditor.show();
      this.cmdEditor.getEditor().selectAll();
      this.cmdEditor.focus();
      return this.scrollToBottom();
    };

    CommandOutputView.prototype.scrollToBottom = function() {
      return this.cliOutput.scrollTop(10000000);
    };

    CommandOutputView.prototype.flashIconClass = function(className, time) {
      var onStatusOut;
      if (time == null) {
        time = 100;
      }
      console.log('addClass', className);
      addClass(this.statusIcon, className);
      this.timer && clearTimeout(this.timer);
      onStatusOut = (function(_this) {
        return function() {
          return removeClass(_this.statusIcon, className);
        };
      })(this);
      return this.timer = setTimeout(onStatusOut, time);
    };

    CommandOutputView.prototype.destroy = function() {
      var _destroy;
      _destroy = (function(_this) {
        return function() {
          if (_this.hasParent()) {
            _this.close();
          }
          if (_this.statusIcon && _this.statusIcon.parentNode) {
            _this.statusIcon.parentNode.removeChild(_this.statusIcon);
          }
          return _this.statusView.removeCommandView(_this);
        };
      })(this);
      if (this.program) {
        this.program.once('exit', _destroy);
        return this.program.kill();
      } else {
        return _destroy();
      }
    };

    CommandOutputView.prototype.kill = function() {
      if (this.program) {
        return this.program.kill();
      }
    };

    CommandOutputView.prototype.open = function() {
      this.lastLocation = atom.workspace.getActivePane();
      if (!this.hasParent()) {
        atom.workspaceView.prependToBottom(this);
      }
      if (lastOpenedView && lastOpenedView !== this) {
        lastOpenedView.close();
      }
      lastOpenedView = this;
      this.scrollToBottom();
      this.statusView.setActiveCommandView(this);
      return this.cmdEditor.focus();
    };

    CommandOutputView.prototype.close = function() {
      this.lastLocation.activate();
      this.detach();
      return lastOpenedView = null;
    };

    CommandOutputView.prototype.toggle = function() {
      if (this.hasParent()) {
        return this.close();
      } else {
        return this.open();
      }
    };

    CommandOutputView.prototype.cd = function(args) {
      var dir;
      dir = resolve(this.getCwd(), args[0]);
      return fs.stat(dir, (function(_this) {
        return function(err, stat) {
          if (err) {
            if (err.code === 'ENOENT') {
              return _this.errorMessage("cd: " + args[0] + ": No such file or directory");
            }
            return _this.errorMessage(err.message);
          }
          if (!stat.isDirectory()) {
            return _this.errorMessage("cd: not a directory: " + args[0]);
          }
          _this.cwd = dir;
          return _this.message("cwd: " + _this.cwd);
        };
      })(this));
    };

    CommandOutputView.prototype.ls = function(args) {
      var files, filesBlocks;
      files = fs.readdirSync(this.getCwd());
      filesBlocks = [];
      files.forEach((function(_this) {
        return function(filename) {
          return filesBlocks.push(_this._fileInfoHtml(filename, _this.getCwd()));
        };
      })(this));
      filesBlocks = filesBlocks.sort(function(a, b) {
        var aDir, bDir;
        aDir = a[1].isDirectory();
        bDir = b[1].isDirectory();
        if (aDir && !bDir) {
          return -1;
        }
        if (!aDir && bDir) {
          return 1;
        }
        return a[2] > b[2] && 1 || -1;
      });
      filesBlocks = filesBlocks.map(function(b) {
        return b[0];
      });
      return this.message(filesBlocks.join('') + '<div class="clear"/>');
    };

    CommandOutputView.prototype._fileInfoHtml = function(filename, parent) {
      var classes, filepath, stat;
      classes = ['icon', 'file-info'];
      filepath = parent + '/' + filename;
      stat = fs.lstatSync(filepath);
      if (stat.isSymbolicLink()) {
        classes.push('stat-link');
        stat = fs.statSync(filepath);
      }
      if (stat.isFile()) {
        if (stat.mode & 73) {
          classes.push('stat-program');
        }
        classes.push('icon-file-text');
      }
      if (stat.isDirectory()) {
        classes.push('icon-file-directory');
      }
      if (stat.isCharacterDevice()) {
        classes.push('stat-char-dev');
      }
      if (stat.isFIFO()) {
        classes.push('stat-fifo');
      }
      if (stat.isSocket()) {
        classes.push('stat-sock');
      }
      if (filename[0] === '.') {
        classes.push('status-ignored');
      }
      return ["<span class=\"" + (classes.join(' ')) + "\">" + filename + "</span>", stat, filename];
    };

    CommandOutputView.prototype.getGitStatusName = function(path, gitRoot, repo) {
      var status;
      status = (repo.getCachedPathStatus || repo.getPathStatus)(path);
      console.log('path status', path, status);
      if (status) {
        if (repo.isStatusModified(status)) {
          return 'modified';
        }
        if (repo.isStatusNew(status)) {
          return 'added';
        }
      }
      if (repo.isPathIgnore(path)) {
        return 'ignored';
      }
    };

    CommandOutputView.prototype.message = function(message) {
      this.cliOutput.append(message);
      this.showCmd();
      removeClass(this.statusIcon, 'status-error');
      return addClass(this.statusIcon, 'status-success');
    };

    CommandOutputView.prototype.errorMessage = function(message) {
      this.cliOutput.append(message);
      this.showCmd();
      removeClass(this.statusIcon, 'status-success');
      return addClass(this.statusIcon, 'status-error');
    };

    CommandOutputView.prototype.getCwd = function() {
      return this.cwd || atom.project.path || this.userHome;
    };

    CommandOutputView.prototype.spawn = function(inputCmd, cmd, args) {
      var err, htmlStream;
      this.cmdEditor.hide();
      htmlStream = ansihtml();
      htmlStream.on('data', (function(_this) {
        return function(data) {
          _this.cliOutput.append(data);
          return _this.scrollToBottom();
        };
      })(this));
      try {
        this.program = exec(inputCmd, {
          stdio: 'pipe',
          env: process.env,
          cwd: this.getCwd()
        });
        this.program.stdout.pipe(htmlStream);
        this.program.stderr.pipe(htmlStream);
        removeClass(this.statusIcon, 'status-success');
        removeClass(this.statusIcon, 'status-error');
        addClass(this.statusIcon, 'status-running');
        this.killBtn.removeClass('hide');
        this.program.once('exit', (function(_this) {
          return function(code) {
            console.log('exit', code);
            _this.killBtn.addClass('hide');
            removeClass(_this.statusIcon, 'status-running');
            _this.program = null;
            addClass(_this.statusIcon, code === 0 && 'status-success' || 'status-error');
            return _this.showCmd();
          };
        })(this));
        this.program.on('error', (function(_this) {
          return function(err) {
            console.log('error');
            _this.cliOutput.append(err.message);
            _this.showCmd();
            return addClass(_this.statusIcon, 'status-error');
          };
        })(this));
        this.program.stdout.on('data', (function(_this) {
          return function() {
            _this.flashIconClass('status-info');
            return removeClass(_this.statusIcon, 'status-error');
          };
        })(this));
        return this.program.stderr.on('data', (function(_this) {
          return function() {
            console.log('stderr');
            return _this.flashIconClass('status-error', 300);
          };
        })(this));
      } catch (_error) {
        err = _error;
        this.cliOutput.append(err.message);
        return this.showCmd();
      }
    };

    return CommandOutputView;

  })(View);

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLDRJQUFBO0lBQUE7O21TQUFBOztBQUFBLEVBQUEsT0FBcUIsT0FBQSxDQUFRLE1BQVIsQ0FBckIsRUFBQyxZQUFBLElBQUQsRUFBTyxrQkFBQSxVQUFQLENBQUE7O0FBQUEsRUFDQSxRQUFnQixPQUFBLENBQVEsZUFBUixDQUFoQixFQUFDLGNBQUEsS0FBRCxFQUFRLGFBQUEsSUFEUixDQUFBOztBQUFBLEVBRUEsUUFBQSxHQUFXLE9BQUEsQ0FBUSxrQkFBUixDQUZYLENBQUE7O0FBQUEsRUFHQSxRQUFBLEdBQVcsT0FBQSxDQUFRLFVBQVIsQ0FIWCxDQUFBOztBQUFBLEVBSUEsUUFBMEIsT0FBQSxDQUFRLFNBQVIsQ0FBMUIsRUFBQyxpQkFBQSxRQUFELEVBQVcsb0JBQUEsV0FKWCxDQUFBOztBQUFBLEVBS0MsVUFBVyxPQUFBLENBQVEsTUFBUixFQUFYLE9BTEQsQ0FBQTs7QUFBQSxFQU1BLEVBQUEsR0FBSyxPQUFBLENBQVEsSUFBUixDQU5MLENBQUE7O0FBQUEsRUFRQSxjQUFBLEdBQWlCLElBUmpCLENBQUE7O0FBQUEsRUFVQSxNQUFNLENBQUMsT0FBUCxHQUNNO0FBQ0osd0NBQUEsQ0FBQTs7Ozs7S0FBQTs7QUFBQSxnQ0FBQSxHQUFBLEdBQUssSUFBTCxDQUFBOztBQUFBLElBQ0EsaUJBQUMsQ0FBQSxPQUFELEdBQVUsU0FBQSxHQUFBO2FBQ1IsSUFBQyxDQUFBLEdBQUQsQ0FBSztBQUFBLFFBQUEsUUFBQSxFQUFVLENBQUEsQ0FBVjtBQUFBLFFBQWMsT0FBQSxFQUFPLCtCQUFyQjtPQUFMLEVBQTJELENBQUEsU0FBQSxLQUFBLEdBQUE7ZUFBQSxTQUFBLEdBQUE7QUFDekQsVUFBQSxLQUFDLENBQUEsR0FBRCxDQUFLO0FBQUEsWUFBQSxPQUFBLEVBQU8sZUFBUDtXQUFM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
//# sourceURL=/Users/jmuraski/.atom/packages/terminal-status/lib/command-output-view.coffee