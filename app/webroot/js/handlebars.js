/*

Copyright (C) 2011 by Yehuda Katz

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
// lib/handlebars/base.js
/*jshint eqnull:true*/
this.Handlebars={},function(r){r.VERSION="1.0.0-rc.3",r.COMPILER_REVISION=2,r.REVISION_CHANGES={1:"<= 1.0.rc.2",// 1.0.rc.2 is actually rev2 but doesn't report it
2:">= 1.0.0-rc.3"},r.helpers={},r.partials={},r.registerHelper=function(r,e,n){n&&(e.not=n),this.helpers[r]=e},r.registerPartial=function(r,e){this.partials[r]=e},r.registerHelper("helperMissing",function(r){if(2===arguments.length)return void 0;throw Error("Could not find property '"+r+"'")});var e=Object.prototype.toString,n="[object Function]";r.registerHelper("blockHelperMissing",function(t,a){var o=a.inverse||function(){},i=a.fn,l=e.call(t);return l===n&&(t=t.call(this)),t===!0?i(this):t===!1||null==t?o(this):"[object Array]"===l?t.length>0?r.helpers.each(t,a):o(this):i(t)}),r.K=function(){},r.createFrame=Object.create||function(e){r.K.prototype=e;var n=new r.K;return r.K.prototype=null,n},r.logger={DEBUG:0,INFO:1,WARN:2,ERROR:3,level:3,methodMap:{0:"debug",1:"info",2:"warn",3:"error"},// can be overridden in the host environment
log:function(e,n){if(e>=r.logger.level){var t=r.logger.methodMap[e];"undefined"!=typeof console&&console[t]&&console[t].call(console,n)}}},r.log=function(e,n){r.logger.log(e,n)},r.registerHelper("each",function(e,n){var t,a=n.fn,o=n.inverse,i=0,l="";if(n.data&&(t=r.createFrame(n.data)),e&&"object"==typeof e)if(e instanceof Array)for(var s=e.length;s>i;i++)t&&(t.index=i),l+=a(e[i],{data:t});else for(var p in e)e.hasOwnProperty(p)&&(t&&(t.key=p),l+=a(e[p],{data:t}),i++);return 0===i&&(l=o(this)),l}),r.registerHelper("if",function(t,a){var o=e.call(t);return o===n&&(t=t.call(this)),!t||r.Utils.isEmpty(t)?a.inverse(this):a.fn(this)}),r.registerHelper("unless",function(e,n){var t=n.fn,a=n.inverse;return n.fn=a,n.inverse=t,r.helpers["if"].call(this,e,n)}),r.registerHelper("with",function(r,e){return e.fn(r)}),r.registerHelper("log",function(e,n){var t=n.data&&null!=n.data.level?parseInt(n.data.level,10):1;r.log(t,e)})}(this.Handlebars);// lib/handlebars/utils.js
var errorProps=["description","fileName","lineNumber","message","name","number","stack"];Handlebars.Exception=function(){// Unfortunately errors are not enumerable in Chrome (at least), so `for prop in tmp` doesn't work.
for(var r=Error.prototype.constructor.apply(this,arguments),e=0;errorProps.length>e;e++)this[errorProps[e]]=r[errorProps[e]]},Handlebars.Exception.prototype=Error(),// Build out our basic SafeString type
Handlebars.SafeString=function(r){this.string=r},Handlebars.SafeString.prototype.toString=function(){return""+this.string},function(){var r={"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#x27;","`":"&#x60;"},e=/[&<>"'`]/g,n=/[&<>"'`]/,t=function(e){return r[e]||"&amp;"};Handlebars.Utils={escapeExpression:function(r){// don't escape SafeStrings, since they're already safe
// don't escape SafeStrings, since they're already safe
return r instanceof Handlebars.SafeString?""+r:null==r||r===!1?"":n.test(r)?r.replace(e,t):r},isEmpty:function(r){return r||0===r?"[object Array]"===Object.prototype.toString.call(r)&&0===r.length?!0:!1:!0}}}(),// lib/handlebars/runtime.js
Handlebars.VM={template:function(r){// Just add water
var e={escapeExpression:Handlebars.Utils.escapeExpression,invokePartial:Handlebars.VM.invokePartial,programs:[],program:function(r,e,n){var t=this.programs[r];return n?Handlebars.VM.program(e,n):t?t:t=this.programs[r]=Handlebars.VM.program(e)},programWithDepth:Handlebars.VM.programWithDepth,noop:Handlebars.VM.noop,compilerInfo:null};return function(n,t){t=t||{};var a=r.call(e,Handlebars,n,t.helpers,t.partials,t.data),o=e.compilerInfo||[],i=o[0]||1,l=Handlebars.COMPILER_REVISION;if(i!==l){if(l>i){var s=Handlebars.REVISION_CHANGES[l],p=Handlebars.REVISION_CHANGES[i];throw"Template was precompiled with an older version of Handlebars than the current runtime. Please update your precompiler to a newer version ("+s+") or downgrade your runtime to an older version ("+p+")."}// Use the embedded version info since the runtime doesn't know about this revision yet
throw"Template was precompiled with a newer version of Handlebars than the current runtime. Please update your runtime to a newer version ("+o[1]+")."}return a}},programWithDepth:function(r,e){var n=Array.prototype.slice.call(arguments,2);return function(t,a){return a=a||{},r.apply(this,[t,a.data||e].concat(n))}},program:function(r,e){return function(n,t){return t=t||{},r(n,t.data||e)}},noop:function(){return""},invokePartial:function(r,e,n,t,a,o){var i={helpers:t,partials:a,data:o};if(void 0===r)throw new Handlebars.Exception("The partial "+e+" could not be found");if(r instanceof Function)return r(n,i);if(Handlebars.compile)return a[e]=Handlebars.compile(r,{data:void 0!==o}),a[e](n,i);throw new Handlebars.Exception("The partial "+e+" could not be compiled when running in runtime-only mode")}},Handlebars.template=Handlebars.VM.template;