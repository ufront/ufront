class Func
{
/* TODO

bind_.bind(function, object, [*arguments])
Bind a function to an object, meaning that whenever the function is called, the value of this will be the object. Optionally, bind arguments to the function to pre-fill them, also known as partial application.

var func = function(greeting){ return greeting + ': ' + this.name };
func = _.bind(func, {name : 'moe'}, 'hi');
func();
=> 'hi: moe'

memoize_.memoize(function, [hashFunction])
Memoizes a given function by caching the computed result. Useful for speeding up slow-running computations. If passed an optional hashFunction, it will be used to compute the hash key for storing the result, based on the arguments to the original function. The default hashFunction just uses the first argument to the memoized function as the key.

var fibonacci = _.memoize(function(n) {
  return n < 2 ? n : fibonacci(n - 1) + fibonacci(n - 2);
});
delay_.delay(function, wait, [*arguments])
Much like setTimeout, invokes function after wait milliseconds. If you pass the optional arguments, they will be forwarded on to the function when it is invoked.

var log = _.bind(console.log, console);
_.delay(log, 1000, 'logged later');
=> 'logged later' // Appears after one second.
defer_.defer(function)
Defers invoking the function until the current call stack has cleared, similar to using setTimeout with a delay of 0. Useful for performing expensive computations or HTML rendering in chunks without blocking the UI thread from updating.

_.defer(function(){ alert('deferred'); });
// Returns from the function before the alert runs.
throttle_.throttle(function, wait)
Creates and returns a new, throttled version of the passed function, that, when invoked repeatedly, will only actually call the original function at most once per every wait milliseconds. Useful for rate-limiting events that occur faster than you can keep up with.

var throttled = _.throttle(updatePosition, 100);
$(window).scroll(throttled);
debounce_.debounce(function, wait)
Creates and returns a new debounced version of the passed function that will postpone its execution until after wait milliseconds have elapsed since the last time it was invoked. Useful for implementing behavior that should only happen after the input has stopped arriving. For example: rendering a preview of a Markdown comment, recalculating a layout after the window has stopped being resized, and so on.

var lazyLayout = _.debounce(calculateLayout, 300);
$(window).resize(lazyLayout);
once_.once(function)
Creates a version of the function that can only be called one time. Repeated calls to the modified function will have no effect, returning the value from the original call. Useful for initialization functions, instead of having to set a boolean flag and then check it later.

var initialize = _.once(createApplication);
initialize();
initialize();
// Application is only created once.
after_.after(count, function)
Creates a version of the function that will only be run after first being called count times. Useful for grouping asynchronous responses, where you want to be sure that all the async calls have finished, before proceeding.

var renderNotes = _.after(notes.length, render);
_.each(notes, function(note) {
  note.asyncSave({success: renderNotes});
});
// renderNotes is run once, after all notes have saved.
wrap_.wrap(function, wrapper)
Wraps the first function inside of the wrapper function, passing it as the first argument. This allows the wrapper to execute code before and after the function runs, adjust the arguments, and execute it conditionally.

var hello = function(name) { return "hello: " + name; };
hello = _.wrap(hello, function(func) {
  return "before, " + func("moe") + ", after";
});
hello();
=> 'before, hello: moe, after'
compose_.compose(*functions)
Returns the composition of a list of functions, where each function consumes the return value of the function that follows. In math terms, composing the functions f(), g(), and h() produces f(g(h())).

var greet    = function(name){ return "hi: " + name; };
var exclaim  = function(statement){ return statement + "!"; };
var welcome = _.compose(exclaim, greet);
welcome('moe');
=> 'hi: moe!'

*/
}