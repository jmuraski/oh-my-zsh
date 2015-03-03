(function() {
  var Point, Range, editorUtils, emmet, normalize, path, preprocessSnippet, resources, snippets, snippetsPath, tabStops, utils, visualize, _ref;

  _ref = require('atom'), Point = _ref.Point, Range = _ref.Range;

  path = require('path');

  emmet = require('emmet');

  utils = require('emmet/lib/utils/common');

  tabStops = require('emmet/lib/assets/tabStops');

  resources = require('emmet/lib/assets/resources');

  editorUtils = require('emmet/lib/utils/editor');

  snippetsPath = atom.packages.resolvePackagePath('snippets');

  snippets = require(snippetsPath);

  visualize = function(str) {
    return str.replace(/\t/g, '\\t').replace(/\n/g, '\\n').replace(/\s/g, '\\s');
  };

  normalize = function(text, editor) {
    return editorUtils.normalize(text, {
      indentation: editor.getTabText(),
      newline: '\n'
    });
  };

  preprocessSnippet = function(value) {
    var order, tabstopOptions;
    order = [];
    tabstopOptions = {
      tabstop: function(data) {
        var group, placeholder;
        group = parseInt(data.group, 10);
        if (group === 0) {
          order.push(-1);
          group = order.length;
        } else {
          if (order.indexOf(group) === -1) {
            order.push(group);
          }
          group = order.indexOf(group) + 1;
        }
        placeholder = data.placeholder || '';
        if (placeholder) {
          placeholder = tabStops.processText(placeholder, tabstopOptions);
        }
        if (placeholder) {
          return "${" + group + ":" + placeholder + "}";
        } else {
          return "$" + group;
        }
      },
      escape: function(ch) {
        if (ch === '$') {
          return '\\$';
        } else {
          return ch;
        }
      }
    };
    return tabStops.processText(value, tabstopOptions);
  };

  module.exports = {
    setup: function(editorView, selectionIndex) {
      var buf, bufRanges;
      this.editorView = editorView;
      this.selectionIndex = selectionIndex != null ? selectionIndex : 0;
      this.editor = this.editorView.getEditor();
      buf = this.editor.getBuffer();
      bufRanges = this.editor.getSelectedBufferRanges();
      return this._selection = {
        index: 0,
        saved: new Array(bufRanges.length),
        bufferRanges: bufRanges,
        indexRanges: bufRanges.map(function(range) {
          return {
            start: buf.characterIndexForPosition(range.start),
            end: buf.characterIndexForPosition(range.end)
          };
        })
      };
    },
    exec: function(fn) {
      var ix, success;
      ix = this._selection.bufferRanges.length - 1;
      this._selection.saved = new Array(this._selection.bufferRanges.length);
      success = true;
      while (ix >= 0) {
        this._selection.index = ix--;
        if (fn(this._selection.index) === false) {
          success = false;
          break;
        }
      }
      if (success && this._selection.saved.length > 1) {
        return this._setSelectedBufferRanges(this._selection.saved);
      }
    },
    _setSelectedBufferRanges: function(sels) {
      return this.editor.setSelectedBufferRanges(sels.filter(function(s) {
        return !!s;
      }));
    },
    _saveSelection: function(delta) {
      var i, range, _results;
      this._selection.saved[this._selection.index] = this.editor.getSelectedBufferRange();
      if (delta) {
        i = this._selection.index + 1;
        delta = Point.fromObject([delta, 0]);
        _results = [];
        while (i < this._selection.saved.length) {
          range = this._selection.saved[i];
          this._selection.saved[i] = new Range(range.start.translate(delta), range.end.translate(delta));
          _results.push(i++);
        }
        return _results;
      }
    },
    selectionList: function() {
      return this._selection.indexRanges;
    },
    getCaretPos: function() {
      return this.getSelectionRange().start;
    },
    setCaretPos: function(pos) {
      return this.createSelection(pos);
    },
    getSelectionRange: function() {
      return this._selection.indexRanges[this._selection.index];
    },
    getSelectionBufferRange: function() {
      return this._selection.bufferRanges[this._selection.index];
    },
    createSelection: function(start, end) {
      var buf, sels;
      if (end == null) {
        end = start;
      }
      sels = this._selection.bufferRanges;
      buf = this.editor.getBuffer();
      sels[this._selection.index] = new Range(buf.positionForCharacterIndex(start), buf.positionForCharacterIndex(end));
      return this._setSelectedBufferRanges(sels);
    },
    getSelection: function() {
      return this.editor.getTextInBufferRange(this.getSelectionBufferRange());
    },
    getCurrentLineRange: function() {
      var index, lineLength, row, sel;
      sel = this.getSelectionBufferRange();
      row = sel.getRows()[0];
      lineLength = this.editor.lineLengthForBufferRow(row);
      index = this.editor.getBuffer().characterIndexForPosition({
        row: row,
        column: 0
      });
      return {
        start: index,
        end: index + lineLength
      };
    },
    getCurrentLine: function() {
      var row, sel;
      sel = this.getSelectionBufferRange();
      row = sel.getRows()[0];
      return this.editor.lineForBufferRow(row);
    },
    getContent: function() {
      return this.editor.getText();
    },
    replaceContent: function(value, start, end, noIndent) {
      var buf, caret, changeRange, oldValue;
      if (end == null) {
        end = start == null ? this.getContent().length : start;
      }
      if (start == null) {
        start = 0;
      }
      value = normalize(value, this.editor);
      buf = this.editor.getBuffer();
      changeRange = new Range(Point.fromObject(buf.positionForCharacterIndex(start)), Point.fromObject(buf.positionForCharacterIndex(end)));
      oldValue = this.editor.getTextInBufferRange(changeRange);
      buf.setTextInRange(changeRange, '');
      caret = buf.positionForCharacterIndex(start);
      this.editor.setSelectedBufferRange(new Range(caret, caret));
      snippets.insert(preprocessSnippet(value), this.editor);
      this._saveSelection(utils.splitByLines(value).length - utils.splitByLines(oldValue).length);
      return value;
    },
    getSyntax: function() {
      return this.editor.getGrammar().name.toLowerCase();
    },
    getProfileName: function() {
      return this.editor.getGrammar().name;
    },
    getFilePath: function() {
      return this.editor.buffer.file.path;
    }
  };

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLHlJQUFBOztBQUFBLEVBQUEsT0FBaUIsT0FBQSxDQUFRLE1BQVIsQ0FBakIsRUFBQyxhQUFBLEtBQUQsRUFBUSxhQUFBLEtBQVIsQ0FBQTs7QUFBQSxFQUNBLElBQUEsR0FBaUIsT0FBQSxDQUFRLE1BQVIsQ0FEakIsQ0FBQTs7QUFBQSxFQUdBLEtBQUEsR0FBYyxPQUFBLENBQVEsT0FBUixDQUhkLENBQUE7O0FBQUEsRUFJQSxLQUFBLEdBQWMsT0FBQSxDQUFRLHdCQUFSLENBSmQsQ0FBQTs7QUFBQSxFQUtBLFFBQUEsR0FBYyxPQUFBLENBQVEsMkJBQVIsQ0FMZCxDQUFBOztBQUFBLEVBTUEsU0FBQSxHQUFjLE9BQUEsQ0FBUSw0QkFBUixDQU5kLENBQUE7O0FBQUEsRUFPQSxXQUFBLEdBQWMsT0FBQSxDQUFRLHdCQUFSLENBUGQsQ0FBQTs7QUFBQSxFQVNBLFlBQUEsR0FBZSxJQUFJLENBQUMsUUFBUSxDQUFDLGtCQUFkLENBQWlDLFVBQWpDLENBVGYsQ0FBQTs7QUFBQSxFQVVBLFFBQUEsR0FBVyxPQUFBLENBQVEsWUFBUixDQVZYLENBQUE7O0FBQUEsRUFZQSxTQUFBLEdBQVksU0FBQyxHQUFELEdBQUE7V0FDVixHQUNFLENBQUMsT0FESCxDQUNXLEtBRFgsRUFDa0IsS0FEbEIsQ0FFRSxDQUFDLE9BRkgsQ0FFVyxLQUZYLEVBRWtCLEtBRmxCLENBR0UsQ0FBQyxPQUhILENBR1csS0FIWCxFQUdrQixLQUhsQixFQURVO0VBQUEsQ0FaWixDQUFBOztBQUFBLEVBdUJBLFNBQUEsR0FBWSxTQUFDLElBQUQsRUFBTyxNQUFQLEdBQUE7V0FDVixXQUFXLENBQUMsU0FBWixDQUFzQixJQUF0QixFQUNFO0FBQUEsTUFBQSxXQUFBLEVBQWEsTUFBTSxDQUFDLFVBQVAsQ0FBQSxDQUFi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
//# sourceURL=/Users/jmuraski/.atom/packages/emmet/lib/editor-proxy.coffee