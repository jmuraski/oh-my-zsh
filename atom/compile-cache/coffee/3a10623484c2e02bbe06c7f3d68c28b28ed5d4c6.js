(function() {
  var $, BOTTOM, CONFLICT_REGEX, Conflict, Emitter, INVALID, MIDDLE, Marker, Navigator, OurSide, Side, TOP, TheirSide, _ref;

  $ = require('atom').$;

  Emitter = require('emissary').Emitter;

  _ref = require('./side'), Side = _ref.Side, OurSide = _ref.OurSide, TheirSide = _ref.TheirSide;

  Navigator = require('./navigator');

  CONFLICT_REGEX = /^<{7} (.+)\r?\n([^]*?)={7}\r?\n([^]*?)>{7} (.+)(?:\r?\n)?/mg;

  INVALID = null;

  TOP = 'top';

  MIDDLE = 'middle';

  BOTTOM = 'bottom';

  Marker = (function() {
    var options;

    options = {
      persistent: false,
      invalidate: 'never'
    };

    function Marker(state, editor) {
      this.state = state;
      this.editor = editor;
      this.position = INVALID;
    }

    Marker.prototype.start = function(m) {
      this.m = m;
      this.startRow = this.m.range.start.row;
      this.endRow = this.m.range.end.row;
      this.chunks = this.m.match;
      this.chunks.shift();
      this.currentRow = this.startRow;
      this.position = TOP;
      return this.previousSide = null;
    };

    Marker.prototype.finish = function() {
      return this.previousSide.followingMarker = this.previousSide.refBannerMarker;
    };

    Marker.prototype.markOurs = function() {
      return this._markHunk(OurSide);
    };

    Marker.prototype.markSeparator = function() {
      var marker, sepRowEnd, sepRowStart;
      if (this.position !== MIDDLE) {
        throw new Error("Unexpected position for separator: " + this.position);
      }
      this.position = BOTTOM;
      sepRowStart = this.currentRow;
      sepRowEnd = this._advance(1);
      marker = this.editor.markBufferRange([[sepRowStart, 0], [sepRowEnd, 0]], this.options);
      this.previousSide.followingMarker = marker;
      return new Navigator(marker);
    };

    Marker.prototype.markTheirs = function() {
      return this._markHunk(TheirSide);
    };

    Marker.prototype._markHunk = function(sideKlass) {
      var bannerMarker, bannerRowEnd, bannerRowStart, lines, marker, ref, rowEnd, rowStart, side, sidePosition, text;
      sidePosition = this.position;
      switch (this.position) {
        case TOP:
          ref = this.chunks.shift();
          text = this.chunks.shift();
          lines = text.split(/\n/);
          bannerRowStart = this.currentRow;
          bannerRowEnd = rowStart = this._advance(1);
          rowEnd = this._advance(lines.length - 1);
          this.position = MIDDLE;
          break;
        case BOTTOM:
          text = this.chunks.shift();
          ref = this.chunks.shift();
          lines = text.split(/\n/);
          rowStart = this.currentRow;
          bannerRowStart = rowEnd = this._advance(lines.length - 1);
          bannerRowEnd = this._advance(1);
          this.position = INVALID;
          break;
        default:
          throw new Error("Unexpected position for side: " + this.position);
      }
      bannerMarker = this.editor.markBufferRange([[bannerRowStart, 0], [bannerRowEnd, 0]], this.options);
      marker = this.editor.markBufferRange([[rowStart, 0], [rowEnd, 0]], this.options);
      side = new sideKlass(text, ref, marker, bannerMarker, sidePosition);
      this.previousSide = side;
      return side;
    };

    Marker.prototype._advance = function(rowCount) {
      return this.currentRow += rowCount;
    };

    return Marker;

  })();

  module.exports = Conflict = (function() {
    Emitter.includeInto(Conflict);

    function Conflict(ours, theirs, parent, navigator, state) {
      this.ours = ours;
      this.theirs = theirs;
      this.parent = parent;
      this.navigator = navigator;
      this.state = state;
      this.ours.conflict = this;
      this.theirs.conflict = this;
      this.navigator.conflict = this;
      this.resolution = null;
    }

    Conflict.prototype.isResolved = function() {
      return this.resolution != null;
    };

    Conflict.prototype.resolveAs = function(side) {
      this.resolution = side;
      return this.emit("conflict:resolved");
    };

    Conflict.prototype.scrollTarget = function() {
      return this.ours.marker.getTailBufferPosition();
    };

    Conflict.prototype.toString = function() {
      return "[conflict: " + this.ours + " " + this.theirs + "]";
    };

    Conflict.all = function(state, editor) {
      var marker, previous, results;
      results = [];
      previous = null;
      marker = new Marker(state, editor);
      editor.getBuffer().scan(CONFLICT_REGEX, function(m) {
        var c, nav, ours, theirs;
        marker.start(m);
        if (state.isRebase) {
          theirs = marker.markTheirs();
          nav = marker.markSeparator();
          ours = marker.markOurs();
        } else {
          ours = marker.markOurs();
          nav = marker.markSeparator();
          theirs = marker.markTheirs();
        }
        marker.finish();
        c = new Conflict(ours, theirs, null, nav, state);
        results.push(c);
        nav.linkToPrevious(previous);
        return previous = c;
      });
      return results;
    };

    return Conflict;

  })();

}).call(this);

//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAiZmlsZSI6ICIiLAogICJzb3VyY2VSb290IjogIiIsCiAgInNvdXJjZXMiOiBbCiAgICAiIgogIF0sCiAgIm5hbWVzIjogW10sCiAgIm1hcHBpbmdzIjogIkFBQUE7QUFBQSxNQUFBLHFIQUFBOztBQUFBLEVBQUMsSUFBSyxPQUFBLENBQVEsTUFBUixFQUFMLENBQUQsQ0FBQTs7QUFBQSxFQUNDLFVBQVcsT0FBQSxDQUFRLFVBQVIsRUFBWCxPQURELENBQUE7O0FBQUEsRUFHQSxPQUE2QixPQUFBLENBQVEsUUFBUixDQUE3QixFQUFDLFlBQUEsSUFBRCxFQUFPLGVBQUEsT0FBUCxFQUFnQixpQkFBQSxTQUhoQixDQUFBOztBQUFBLEVBSUEsU0FBQSxHQUFZLE9BQUEsQ0FBUSxhQUFSLENBSlosQ0FBQTs7QUFBQSxFQU1BLGNBQUEsR0FBaUIsNkRBTmpCLENBQUE7O0FBQUEsRUFRQSxPQUFBLEdBQVUsSUFSVixDQUFBOztBQUFBLEVBU0EsR0FBQSxHQUFNLEtBVE4sQ0FBQTs7QUFBQSxFQVVBLE1BQUEsR0FBUyxRQVZULENBQUE7O0FBQUEsRUFXQSxNQUFBLEdBQVMsUUFYVCxDQUFBOztBQUFBLEVBYU07QUFFSixRQUFBLE9BQUE7O0FBQUEsSUFBQSxPQUFBLEdBQ0U7QUFBQSxNQUFBLFVBQUEsRUFBWSxLQUFaO0FBQUEsTUFDQSxVQUFBLEVBQVksT0FEWjtLQURGLENBQUE7O0FBSWEsSUFBQSxnQkFBRSxLQUFGLEVBQVUsTUFBVixHQUFBO0FBQ1gsTUFEWSxJQUFDLENBQUEsUUFBQSxLQUNiLENBQUE7QUFBQSxNQURvQixJQUFDLENBQUEsU0FBQSxNQUNyQixDQUFBO0FBQUEsTUFBQSxJQUFDLENBQUEsUUFBRCxHQUFZLE9BQVosQ0FEVztJQUFBLENBSmI7O0FBQUEscUJBT0EsS0FBQSxHQUFPLFNBQUUsQ0FBRixHQUFBO0FBQ0wsTUFETSxJQUFDLENBQUEsSUFBQSxDQUNQLENBQUE7QUFBQSxNQUFBLElBQUMsQ0FBQSxRQUFELEdBQVksSUFBQyxDQUFBLENBQUMs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
//# sourceURL=/Users/jmuraski/.atom/packages/merge-conflicts/lib/conflict.coffee