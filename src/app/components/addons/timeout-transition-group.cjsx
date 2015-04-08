###*
# The CSSTransitionGroup component uses the 'transitionend' event, which
# browsers will not send for any number of reasons, including the
# transitioning node not being painted or in an unfocused tab.
#
# This TimeoutTransitionGroup instead uses a user-defined timeout to determine
# when it is a good time to remove the component. Currently there is only one
# timeout specified, but in the future it would be nice to be able to specify
# separate timeouts for enter and leave, in case the timeouts for those
# animations differ. Even nicer would be some sort of inspection of the CSS to
# automatically determine the duration of the animation or transition.
#
# This is adapted from Facebook's CSSTransitionGroup which is in the React
# addons and under the Apache 2.0 License.
###

React = require('react/addons')

ReactTransitionGroup = React.addons.TransitionGroup

TICK = 17

###*
# EVENT_NAME_MAP is used to determine which event fired when a
# transition/animation ends, based on the style property used to
# define that event.
###

EVENT_NAME_MAP = 
  transitionend:
    'transition': 'transitionend'
    'WebkitTransition': 'webkitTransitionEnd'
    'MozTransition': 'mozTransitionEnd'
    'OTransition': 'oTransitionEnd'
    'msTransition': 'MSTransitionEnd'
  animationend:
    'animation': 'animationend'
    'WebkitAnimation': 'webkitAnimationEnd'
    'MozAnimation': 'mozAnimationEnd'
    'OAnimation': 'oAnimationEnd'
    'msAnimation': 'MSAnimationEnd'
endEvents = []

(->
  if typeof window == 'undefined'
    return
  testEl = document.createElement('div')
  style = testEl.style
  # On some platforms, in particular some releases of Android 4.x, the
  # un-prefixed "animation" and "transition" properties are defined on the
  # style object but the events that fire will still be prefixed, so we need
  # to check if the un-prefixed events are useable, and if not remove them
  # from the map
  if not window.AnimationEvent?
    delete EVENT_NAME_MAP.animationend.animation
  if not window.TransitionEvent?
    delete EVENT_NAME_MAP.transitionend.transition
  for baseEventName of EVENT_NAME_MAP
    if EVENT_NAME_MAP.hasOwnProperty(baseEventName)
      baseEvents = EVENT_NAME_MAP[baseEventName]
      for styleName of baseEvents
        if style[styleName]?
          endEvents.push baseEvents[styleName]
          break
)()

animationSupported = ->
  endEvents.length != 0

###*
# Functions for element class management to replace dependency on jQuery
# addClass, removeClass and hasClass
###

addClass = (element, className) ->
  if element.classList
    element.classList.add className
  else if !hasClass(element, className)
    element.className = element.className + ' ' + className
  element

removeClass = (element, className) ->
  if hasClass(className)
    if element.classList
      element.classList.remove className
    else
      element.className = (' ' + element.className + ' ').replace(' ' + className + ' ', ' ').trim()
  element

hasClass = (element, className) ->
  if element.classList
    element.classList.contains className
  else
    (' ' + element.className + ' ').indexOf(' ' + className + ' ') > -1

TimeoutTransitionGroupChild = React.createClass(
  transition: (animationType, finishCallback) ->
    node = @getDOMNode()
    className = @props.name + '-' + animationType
    activeClassName = className + '-active'
    endCallback = @props[animationType + 'Callback']

    endListener = ->
      removeClass node, className
      removeClass node, activeClassName
      # Usually this optional callback is used for informing an owner of
      # a leave animation and telling it to remove the child.
      finishCallback and finishCallback()
      endCallback and endCallback()
      return

    if !animationSupported()
      endListener()
    else
      if animationType == 'enter'
        @animationTimeout = setTimeout(endListener, @props.enterTimeout)
      else if animationType == 'leave'
        @animationTimeout = setTimeout(endListener, @props.leaveTimeout)
    addClass node, className
    # Need to do this to actually trigger a transition.
    @queueClass activeClassName
    return
  queueClass: (className) ->
    @classNameQueue.push className
    if !@timeout
      @timeout = setTimeout(@flushClassNameQueue, TICK)
    return
  flushClassNameQueue: ->
    if @isMounted()
      @classNameQueue.forEach ((name) ->
        addClass @getDOMNode(), name
        return
      ).bind(this)
    @classNameQueue.length = 0
    @timeout = null
    return
  componentWillMount: ->
    @classNameQueue = []
    return
  componentWillUnmount: ->
    if @timeout
      clearTimeout @timeout
    if @animationTimeout
      clearTimeout @animationTimeout
    return
  componentWillEnter: (done) ->
    if @props.enter
      @transition 'enter', done
    else
      done()
    return
  componentWillLeave: (done) ->
    if @props.leave
      @transition 'leave', done
    else
      done()
    return
  render: ->
    React.Children.only @props.children
)
TimeoutTransitionGroup = React.createClass(
  propTypes:
    enterTimeout: React.PropTypes.number.isRequired
    leaveTimeout: React.PropTypes.number.isRequired
    transitionName: React.PropTypes.string.isRequired
    transitionEnter: React.PropTypes.bool
    transitionLeave: React.PropTypes.bool
    enterCallback: React.PropTypes.func
    leaveCallback: React.PropTypes.func
  getDefaultProps: ->
    {
      transitionEnter: true
      transitionLeave: true
    }
  _wrapChild: (child) ->
    return (
            <TimeoutTransitionGroupChild
                    enterTimeout={this.props.enterTimeout}
                    leaveTimeout={this.props.leaveTimeout}
                    name={this.props.transitionName}
                    enter={this.props.transitionEnter}
                    leave={this.props.transitionLeave}
                    enterCallback={this.props.enterCallback}
                    leaveCallback={this.props.leaveCallback}>
                {child}
            </TimeoutTransitionGroupChild>
        )
  render: ->
    return (
            <ReactTransitionGroup
                {...this.props}
                childFactory={this._wrapChild} />
        )
)
module.exports = TimeoutTransitionGroup
