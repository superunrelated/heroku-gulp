
/**
 * The CSSTransitionGroup component uses the 'transitionend' event, which
 * browsers will not send for any number of reasons, including the
 * transitioning node not being painted or in an unfocused tab.
 *
 * This TimeoutTransitionGroup instead uses a user-defined timeout to determine
 * when it is a good time to remove the component. Currently there is only one
 * timeout specified, but in the future it would be nice to be able to specify
 * separate timeouts for enter and leave, in case the timeouts for those
 * animations differ. Even nicer would be some sort of inspection of the CSS to
 * automatically determine the duration of the animation or transition.
 *
 * This is adapted from Facebook's CSSTransitionGroup which is in the React
 * addons and under the Apache 2.0 License.
 */
var EVENT_NAME_MAP, React, ReactTransitionGroup, TICK, TimeoutTransitionGroup, TimeoutTransitionGroupChild, addClass, animationSupported, endEvents, hasClass, removeClass;

React = require('react/addons');

ReactTransitionGroup = React.addons.TransitionGroup;

TICK = 17;


/**
 * EVENT_NAME_MAP is used to determine which event fired when a
 * transition/animation ends, based on the style property used to
 * define that event.
 */

EVENT_NAME_MAP = {
  transitionend: {
    'transition': 'transitionend',
    'WebkitTransition': 'webkitTransitionEnd',
    'MozTransition': 'mozTransitionEnd',
    'OTransition': 'oTransitionEnd',
    'msTransition': 'MSTransitionEnd'
  },
  animationend: {
    'animation': 'animationend',
    'WebkitAnimation': 'webkitAnimationEnd',
    'MozAnimation': 'mozAnimationEnd',
    'OAnimation': 'oAnimationEnd',
    'msAnimation': 'MSAnimationEnd'
  }
};

endEvents = [];

(function() {
  var baseEventName, baseEvents, style, styleName, testEl, _results;
  if (typeof window === 'undefined') {
    return;
  }
  testEl = document.createElement('div');
  style = testEl.style;
  if (window.AnimationEvent == null) {
    delete EVENT_NAME_MAP.animationend.animation;
  }
  if (window.TransitionEvent == null) {
    delete EVENT_NAME_MAP.transitionend.transition;
  }
  _results = [];
  for (baseEventName in EVENT_NAME_MAP) {
    if (EVENT_NAME_MAP.hasOwnProperty(baseEventName)) {
      baseEvents = EVENT_NAME_MAP[baseEventName];
      _results.push((function() {
        var _results1;
        _results1 = [];
        for (styleName in baseEvents) {
          if (style[styleName] != null) {
            endEvents.push(baseEvents[styleName]);
            break;
          } else {
            _results1.push(void 0);
          }
        }
        return _results1;
      })());
    } else {
      _results.push(void 0);
    }
  }
  return _results;
})();

animationSupported = function() {
  return endEvents.length !== 0;
};


/**
 * Functions for element class management to replace dependency on jQuery
 * addClass, removeClass and hasClass
 */

addClass = function(element, className) {
  if (element.classList) {
    element.classList.add(className);
  } else if (!hasClass(element, className)) {
    element.className = element.className + ' ' + className;
  }
  return element;
};

removeClass = function(element, className) {
  if (hasClass(className)) {
    if (element.classList) {
      element.classList.remove(className);
    } else {
      element.className = (' ' + element.className + ' ').replace(' ' + className + ' ', ' ').trim();
    }
  }
  return element;
};

hasClass = function(element, className) {
  if (element.classList) {
    return element.classList.contains(className);
  } else {
    return (' ' + element.className + ' ').indexOf(' ' + className + ' ') > -1;
  }
};

TimeoutTransitionGroupChild = React.createClass({
  transition: function(animationType, finishCallback) {
    var activeClassName, className, endCallback, endListener, node;
    node = this.getDOMNode();
    className = this.props.name + '-' + animationType;
    activeClassName = className + '-active';
    endCallback = this.props[animationType + 'Callback'];
    endListener = function() {
      removeClass(node, className);
      removeClass(node, activeClassName);
      finishCallback && finishCallback();
      endCallback && endCallback();
    };
    if (!animationSupported()) {
      endListener();
    } else {
      if (animationType === 'enter') {
        this.animationTimeout = setTimeout(endListener, this.props.enterTimeout);
      } else if (animationType === 'leave') {
        this.animationTimeout = setTimeout(endListener, this.props.leaveTimeout);
      }
    }
    addClass(node, className);
    this.queueClass(activeClassName);
  },
  queueClass: function(className) {
    this.classNameQueue.push(className);
    if (!this.timeout) {
      this.timeout = setTimeout(this.flushClassNameQueue, TICK);
    }
  },
  flushClassNameQueue: function() {
    if (this.isMounted()) {
      this.classNameQueue.forEach((function(name) {
        addClass(this.getDOMNode(), name);
      }).bind(this));
    }
    this.classNameQueue.length = 0;
    this.timeout = null;
  },
  componentWillMount: function() {
    this.classNameQueue = [];
  },
  componentWillUnmount: function() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
    if (this.animationTimeout) {
      clearTimeout(this.animationTimeout);
    }
  },
  componentWillEnter: function(done) {
    if (this.props.enter) {
      this.transition('enter', done);
    } else {
      done();
    }
  },
  componentWillLeave: function(done) {
    if (this.props.leave) {
      this.transition('leave', done);
    } else {
      done();
    }
  },
  render: function() {
    return React.Children.only(this.props.children);
  }
});

TimeoutTransitionGroup = React.createClass({
  propTypes: {
    enterTimeout: React.PropTypes.number.isRequired,
    leaveTimeout: React.PropTypes.number.isRequired,
    transitionName: React.PropTypes.string.isRequired,
    transitionEnter: React.PropTypes.bool,
    transitionLeave: React.PropTypes.bool,
    enterCallback: React.PropTypes.func,
    leaveCallback: React.PropTypes.func
  },
  getDefaultProps: function() {
    return {
      transitionEnter: true,
      transitionLeave: true
    };
  },
  _wrapChild: function(child) {
    return React.createElement(TimeoutTransitionGroupChild, {
      "enterTimeout": this.props.enterTimeout,
      "leaveTimeout": this.props.leaveTimeout,
      "name": this.props.transitionName,
      "enter": this.props.transitionEnter,
      "leave": this.props.transitionLeave,
      "enterCallback": this.props.enterCallback,
      "leaveCallback": this.props.leaveCallback
    }, child);
  },
  render: function() {
    return React.createElement(ReactTransitionGroup, React.__spread({}, this.props, {
      "childFactory": this._wrapChild
    }));
  }
});

module.exports = TimeoutTransitionGroup;
