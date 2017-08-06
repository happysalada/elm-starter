(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
"use strict";function _defineProperty(e,n,r){return n in e?Object.defineProperty(e,n,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[n]=r,e}require("./autotrack.custom.js");var dimensions={TRACKING_VERSION:"dimension1",CLIENT_ID:"dimension2",WINDOW_ID:"dimension3",HIT_ID:"dimension4",HIT_TIME:"dimension5",HIT_TYPE:"dimension6"},metrics={RESPONSE_END_TIME:"metric1",DOM_LOAD_TIME:"metric2",WINDOW_LOAD_TIME:"metric3"},TRACKING_VERSION="v1",uuid=function e(n){return n?(n^16*Math.random()>>n/4).toString(16):([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g,e)},trackError=function(e){var n=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{};ga("send","event",Object.assign({eventCategory:"Script",eventAction:"error",eventLabel:e&&e.stack||"(not set)",nonInteraction:!0},n))},trackErrors=function(){var e=window.__e&&window.__e.q||[],n={eventAction:"uncaught error"},r=!0,t=!1,i=void 0;try{for(var o,a=e[Symbol.iterator]();!(r=(o=a.next()).done);r=!0){var c=o.value;trackError(c.error,n)}}catch(e){t=!0,i=e}finally{try{!r&&a.return&&a.return()}finally{if(t)throw i}}window.addEventListener("error",function(e){trackError(e.error,n)})},sendNavigationTimingMetrics=function e(){if(window.performance&&window.performance.timing){if("complete"!=document.readyState)return void window.addEventListener("load",e);var n=performance.timing,r=n.navigationStart,t=Math.round(n.responseEnd-r),i=Math.round(n.domContentLoadedEventStart-r),o=Math.round(n.loadEventStart-r);if(function(){for(var e=arguments.length,n=Array(e),r=0;r<e;r++)n[r]=arguments[r];return n.every(function(e){return e>0&&e<1e6})}(t,i,o)){var a;ga("send","event",(a={eventCategory:"Navigation Timing",eventAction:"track",nonInteraction:!0},_defineProperty(a,metrics.RESPONSE_END_TIME,t),_defineProperty(a,metrics.DOM_LOAD_TIME,i),_defineProperty(a,metrics.WINDOW_LOAD_TIME,o),a))}}};window.ga=window.ga||function(){(ga.q=ga.q||[]).push(arguments)},ga("create","UA-99079083-1","auto"),ga("set","transport","beacon"),ga("set",dimensions.TRACKING_VERSION,TRACKING_VERSION),ga("set",dimensions.WINDOW_ID,uuid()),ga(function(e){var n=e.get("clientId");e.set(dimensions.CLIENT_ID,n)}),ga(function(e){var n=e.get("buildHitTask");e.set("buildHitTask",function(e){e.set(dimensions.HIT_ID,uuid(),!0),e.set(dimensions.HIT_TIME,(new Date).toISOString().replace(/[TZ]/g," "),!0),e.set(dimensions.HIT_TYPE,e.get("hitType"),!0),n(e)})}),ga("require","maxScrollTracker",{maxScrollMetricIndex:4}),ga("require","urlChangeTracker"),sendNavigationTimingMetrics(),trackErrors(),ga("require","pageVisibilityTracker",{sendInitialPageview:!0,visibleMetricIndex:5});
},{"./autotrack.custom.js":2}],2:[function(require,module,exports){
(function (global){
"use strict";var _typeof="function"==typeof Symbol&&"symbol"==typeof Symbol.iterator?function(t){return typeof t}:function(t){return t&&"function"==typeof Symbol&&t.constructor===Symbol&&t!==Symbol.prototype?"symbol":typeof t};!function(){function t(){t=function(){},Z.Symbol||(Z.Symbol=e)}function e(t){return"jscomp_symbol_"+(t||"")+q++}function i(){t();var e=Z.Symbol.iterator;e||(e=Z.Symbol.iterator=Z.Symbol("iterator")),"function"!=typeof Array.prototype[e]&&U(Array.prototype,e,{configurable:!0,writable:!0,value:function(){return n(this)}}),i=function(){}}function n(t){var e=0;return o(function(){return e<t.length?{done:!1,value:t[e++]}:{done:!0}})}function o(t){return i(),t={next:t},t[Z.Symbol.iterator]=function(){return this},t}function s(t){if(!(t instanceof Array)){i();var e=t[Symbol.iterator];t=e?e.call(t):n(t);for(var o=[];!(e=t.next()).done;)o.push(e.value);t=o}return t}function r(t){if(t=t&&"."!=t?t:location.href,B[t])return B[t];if(N.href=t,"."==t.charAt(0)||"/"==t.charAt(0))return r(N.href);var e="80"==N.port||"443"==N.port?"":N.port,e="0"==e?"":e,i=N.host.replace(J,"");return B[t]={hash:N.hash,host:i,hostname:N.hostname,href:N.href,origin:N.origin?N.origin:N.protocol+"//"+i,pathname:"/"==N.pathname.charAt(0)?N.pathname:"/"+N.pathname,port:e,protocol:N.protocol,search:N.search}}function a(t,e){var i=this;this.context=t,this.u=e,this.f=(this.c=/Task$/.test(e))?t.get(e):t[e],this.b=[],this.a=[],this.g=function(t){for(var e=[],n=0;n<arguments.length;++n)e[n-0]=arguments[n];return i.a[i.a.length-1].apply(null,[].concat(s(e)))},this.c?t.set(e,this.g):t[e]=this.g}function h(t,e,i){t=l(t,e),t.b.push(i),u(t)}function c(t,e,i){t=l(t,e),-1<(i=t.b.indexOf(i))&&(t.b.splice(i,1),0<t.b.length?u(t):-1<(i=G.indexOf(t))&&(G.splice(i,1),t.c?t.context.set(t.u,t.f):t.context[t.u]=t.f))}function u(t){t.a=[];for(var e,i=0;e=t.b[i];i++){var n=t.a[i-1]||t.f.bind(t.context);t.a.push(e(n))}}function l(t,e){var i=G.filter(function(i){return i.context==t&&i.u==e})[0];return i||(i=new a(t,e),G.push(i)),i}function d(t,e,i,n){if("function"==typeof n){var o=i.get("buildHitTask");return{buildHitTask:function(i){i.set(t,null,!0),i.set(e,null,!0),n(i,void 0,void 0),o(i)}}}return $({},t,e)}function f(t){var e;return function(i){for(var n=[],o=0;o<arguments.length;++o)n[o-0]=arguments[o];clearTimeout(e),e=setTimeout(function(){return t.apply(null,[].concat(s(n)))},500)}}function p(t,e){function i(){clearTimeout(o.timeout),o.send&&c(t,"send",o.send),delete R[n],o.w.forEach(function(t){return t()})}var n=t.get("trackingId"),o=R[n]=R[n]||{};clearTimeout(o.timeout),o.timeout=setTimeout(i,0),o.w=o.w||[],o.w.push(e),o.send||(o.send=function(t){return function(e){for(var n=[],o=0;o<arguments.length;++o)n[o-0]=arguments[o];i(),t.apply(null,[].concat(s(n)))}},h(t,"send",o.send))}function v(t,e){var i=window.GoogleAnalyticsObject||"ga";window[i]=window[i]||function(t){for(var e=[],n=0;n<arguments.length;++n)e[n-0]=arguments[n];(window[i].q=window[i].q||[]).push(e)},window.gaDevIds=window.gaDevIds||[],0>window.gaDevIds.indexOf("i5iSjo")&&window.gaDevIds.push("i5iSjo"),window[i]("provide",t,e),window.gaplugins=window.gaplugins||{},window.gaplugins[t.charAt(0).toUpperCase()+t.slice(1)]=e}function g(){this.a={}}function b(t,e){(t.a.externalSet=t.a.externalSet||[]).push(e)}function m(t,e){e=void 0===e?{}:e,this.a={},this.b=t,this.l=e,this.i=null}function y(t,e,i){return t=["autotrack",t,e].join(":"),z[t]||(z[t]=new m(t,i),Q||(window.addEventListener("storage",T),Q=!0)),z[t]}function w(){if(null!=Y)return Y;try{window.localStorage.setItem("autotrack","autotrack"),window.localStorage.removeItem("autotrack"),Y=!0}catch(t){Y=!1}return Y}function S(t){if(t.i={},w())try{window.localStorage.removeItem(t.b)}catch(t){}}function I(t){delete z[t.b],Object.keys(z).length||(window.removeEventListener("storage",T),Q=!1)}function T(t){var e=z[t.key];if(e){var i=$({},e.l,x(t.oldValue));t=$({},e.l,x(t.newValue)),e.i=t,e.D("externalSet",t,i)}}function x(t){var e={};if(t)try{e=JSON.parse(t)}catch(t){}return e}function j(t,e,i){this.f=t,this.timeout=e||X,this.timeZone=i,this.b=this.b.bind(this),h(t,"sendHitTask",this.b);try{this.c=new Intl.DateTimeFormat("en-US",{timeZone:this.timeZone})}catch(t){}this.a=y(t.get("trackingId"),"session",{hitTime:0,isExpired:!1}),this.a.get().id||this.a.set({id:K()})}function k(t,e,i){var n=t.get("trackingId");return W[n]?W[n]:W[n]=new j(t,e,i)}function E(t){return t.a.get().id}function O(t){c(t.f,"sendHitTask",t.b),I(t.a),delete W[t.f.get("trackingId")]}function L(t,e){t.set("&_av","2.4.1");var i=t.get("&_au"),i=parseInt(i||"0",16).toString(2);if(i.length<et)for(var n=et-i.length;n;)i="0"+i,n--;e=et-e,i=i.substr(0,e)+1+i.substr(e+1),t.set("&_au",parseInt(i||"0",2).toString(16))}function D(t,e){L(t,tt.A),window.addEventListener&&(this.b=$({increaseThreshold:20,sessionTimeout:X,fieldsObj:{}},e),this.f=t,this.c=A(this),this.g=f(this.g.bind(this)),this.j=this.j.bind(this),this.a=y(t.get("trackingId"),"plugins/max-scroll-tracker"),this.h=k(t,this.b.sessionTimeout,this.b.timeZone),h(t,"set",this.j),M(this))}function M(t){100>(t.a.get()[t.c]||0)&&window.addEventListener("scroll",t.g)}function A(t){return t=r(t.f.get("page")||t.f.get("location")),t.pathname+t.search}function C(t,e){var i=this;L(t,tt.B),document.visibilityState&&(this.a=$({sessionTimeout:X,visibleThreshold:5e3,sendInitialPageview:!1,fieldsObj:{}},e),this.b=t,this.h=document.visibilityState,this.o=null,this.v=!1,this.j=this.j.bind(this),this.f=this.f.bind(this),this.m=this.m.bind(this),this.s=this.s.bind(this),this.c=y(t.get("trackingId"),"plugins/page-visibility-tracker"),b(this.c,this.s),this.g=k(t,this.a.sessionTimeout,this.a.timeZone),h(t,"set",this.j),window.addEventListener("unload",this.m),document.addEventListener("visibilitychange",this.f),p(this.b,function(){if("visible"==document.visibilityState)i.a.sendInitialPageview&&(F(i,{F:!0}),i.v=!0),i.c.set({time:+new Date,state:"visible",pageId:it,sessionId:E(i.g)});else if(i.a.sendInitialPageview&&i.a.pageLoadsMetricIndex){var t={},t=(t.transport="beacon",t.eventCategory="Page Visibility",t.eventAction="page load",t.eventLabel="(not set)",t["metric"+i.a.pageLoadsMetricIndex]=1,t.nonInteraction=!0,t);i.b.send("event",d(t,i.a.fieldsObj,i.b,i.a.hitFilter))}}))}function P(t){var e=t.c.get();return"visible"==t.h&&"hidden"==e.state&&e.pageId!=it&&(e.state="visible",e.pageId=it,t.c.set(e)),e}function H(t,e,i){i=(i||{}).hitTime;var n={hitTime:i},n=(n||{}).hitTime;(e=e.time?(n||+new Date)-e.time:0)&&e>=t.a.visibleThreshold&&(e=Math.round(e/1e3),n={transport:"beacon",nonInteraction:!0,eventCategory:"Page Visibility",eventAction:"track",eventValue:e,eventLabel:"(not set)"},i&&(n.queueTime=+new Date-i),t.a.visibleMetricIndex&&(n["metric"+t.a.visibleMetricIndex]=e),t.b.send("event",d(n,t.a.fieldsObj,t.b,t.a.hitFilter)))}function F(t,e){var i=e||{};e=i.hitTime;var i=i.F,n={transport:"beacon"};e&&(n.queueTime=+new Date-e),i&&t.a.pageLoadsMetricIndex&&(n["metric"+t.a.pageLoadsMetricIndex]=1),t.b.send("pageview",d(n,t.a.fieldsObj,t.b,t.a.hitFilter))}function _(t,e){L(t,tt.C),history.pushState&&window.addEventListener&&(this.a=$({shouldTrackUrlChange:this.shouldTrackUrlChange,trackReplaceState:!1,fieldsObj:{},hitFilter:null},e),this.g=t,this.h=location.pathname+location.search,this.c=this.c.bind(this),this.f=this.f.bind(this),this.b=this.b.bind(this),h(history,"pushState",this.c),h(history,"replaceState",this.f),window.addEventListener("popstate",this.b))}function V(t,e){setTimeout(function(){var i=t.h,n=location.pathname+location.search;i!=n&&t.a.shouldTrackUrlChange.call(t,n,i)&&(t.h=n,t.g.set({page:n,title:document.title}),(e||t.a.trackReplaceState)&&t.g.send("pageview",d({transport:"beacon"},t.a.fieldsObj,t.g,t.a.hitFilter)))},0)}var U="function"==typeof Object.defineProperties?Object.defineProperty:function(t,e,i){if(i.get||i.set)throw new TypeError("ES3 does not support getters and setters.");t!=Array.prototype&&t!=Object.prototype&&(t[e]=i.value)},Z="undefined"!=typeof window&&window===this?this:"undefined"!=typeof global&&null!=global?global:this,q=0,J=/:(80|443)$/,N=document.createElement("a"),B={},G=[],R={},$=Object.assign||function(t,e){for(var i=[],n=1;n<arguments.length;++n)i[n-1]=arguments[n];for(var n=0,o=i.length;n<o;n++){var s,r=Object(i[n]);for(s in r)Object.prototype.hasOwnProperty.call(r,s)&&(t[s]=r[s])}return t},K=function t(e){return e?(e^16*Math.random()>>e/4).toString(16):"10000000-1000-4000-8000-100000000000".replace(/[018]/g,t)};g.prototype.D=function(t,e){for(var i=[],n=1;n<arguments.length;++n)i[n-1]=arguments[n];(this.a[t]=this.a[t]||[]).forEach(function(t){return t.apply(null,[].concat(s(i)))})};var Y,z={},Q=!1;!function(t,e){function i(){}i.prototype=e.prototype,t.N=e.prototype,t.prototype=new i,t.prototype.constructor=t;for(var n in e)if(Object.defineProperties){var o=Object.getOwnPropertyDescriptor(e,n);o&&Object.defineProperty(t,n,o)}else t[n]=e[n]}(m,g),m.prototype.get=function(){if(this.i)return this.i;if(w())try{this.i=x(window.localStorage.getItem(this.b))}catch(t){}return this.i=$({},this.l,this.i)},m.prototype.set=function(t){if(this.i=$({},this.l,this.i,t),w())try{var e=JSON.stringify(this.i);window.localStorage.setItem(this.b,e)}catch(t){}};var W={};j.prototype.isExpired=function(t){if((t=void 0===t?E(this):t)!=E(this))return!0;if(t=this.a.get(),t.isExpired)return!0;var e=t.hitTime;return!!(e&&(t=new Date,e=new Date(e),t-e>6e4*this.timeout||this.c&&this.c.format(t)!=this.c.format(e)))},j.prototype.b=function(t){var e=this;return function(i){t(i);var n=i.get("sessionControl");i="start"==n||e.isExpired();var n="end"==n,o=e.a.get();o.hitTime=+new Date,i&&(o.isExpired=!1,o.id=K()),n&&(o.isExpired=!0),e.a.set(o)}};var X=30,tt={G:1,H:2,I:3,J:4,K:5,L:6,B:7,M:8,C:9,A:10},et=Object.keys(tt).length;D.prototype.g=function(){var t=document.documentElement,e=document.body,t=Math.min(100,Math.max(0,Math.round(window.pageYOffset/(Math.max(t.offsetHeight,t.scrollHeight,e.offsetHeight,e.scrollHeight)-window.innerHeight)*100))),e=E(this.h);if(e!=this.a.get().sessionId&&(S(this.a),this.a.set({sessionId:e})),this.h.isExpired(this.a.get().sessionId))S(this.a);else if(e=this.a.get()[this.c]||0,t>e&&(100!=t&&100!=e||window.removeEventListener("scroll",this.g),e=t-e,100==t||e>=this.b.increaseThreshold)){var i={};this.a.set((i[this.c]=t,i.sessionId=E(this.h),i)),t={transport:"beacon",eventCategory:"Max Scroll",eventAction:"increase",eventValue:e,eventLabel:String(t),nonInteraction:!0},this.b.maxScrollMetricIndex&&(t["metric"+this.b.maxScrollMetricIndex]=e),this.f.send("event",d(t,this.b.fieldsObj,this.f,this.b.hitFilter))}},D.prototype.j=function(t){var e=this;return function(i,n){t(i,n);var o={};("object"==(void 0===i?"undefined":_typeof(i))&&null!==i?i:(o[i]=n,o)).page&&(i=e.c,e.c=A(e),e.c!=i&&M(e))}},D.prototype.remove=function(){O(this.h),window.removeEventListener("scroll",this.g),c(this.f,"set",this.j)},v("maxScrollTracker",D);var it=K();C.prototype.f=function(){var t=this;if("visible"==document.visibilityState||"hidden"==document.visibilityState){var e=P(this),i={time:+new Date,state:document.visibilityState,pageId:it,sessionId:E(this.g)};"visible"==document.visibilityState&&this.a.sendInitialPageview&&!this.v&&(F(this),this.v=!0),"hidden"==document.visibilityState&&this.o&&clearTimeout(this.o),this.g.isExpired(e.sessionId)?(S(this.c),"hidden"==this.h&&"visible"==document.visibilityState&&(clearTimeout(this.o),this.o=setTimeout(function(){t.c.set(i),F(t,{hitTime:i.time})},this.a.visibleThreshold))):(e.pageId==it&&"visible"==e.state&&H(this,e),this.c.set(i)),this.h=document.visibilityState}},C.prototype.j=function(t){var e=this;return function(i,n){var o={},o="object"==(void 0===i?"undefined":_typeof(i))&&null!==i?i:(o[i]=n,o);o.page&&o.page!==e.b.get("page")&&"visible"==e.h&&e.f(),t(i,n)}},C.prototype.s=function(t,e){t.time!=e.time&&(e.pageId!=it||"visible"!=e.state||this.g.isExpired(e.sessionId)||H(this,e,{hitTime:t.time}))},C.prototype.m=function(){"hidden"!=this.h&&this.f()},C.prototype.remove=function(){I(this.c),O(this.g),c(this.b,"set",this.j),window.removeEventListener("unload",this.m),document.removeEventListener("visibilitychange",this.f)},v("pageVisibilityTracker",C),_.prototype.c=function(t){var e=this;return function(i){for(var n=[],o=0;o<arguments.length;++o)n[o-0]=arguments[o];t.apply(null,[].concat(s(n))),V(e,!0)}},_.prototype.f=function(t){var e=this;return function(i){for(var n=[],o=0;o<arguments.length;++o)n[o-0]=arguments[o];t.apply(null,[].concat(s(n))),V(e,!1)}},_.prototype.b=function(){V(this,!0)},_.prototype.shouldTrackUrlChange=function(t,e){return!(!t||!e)},_.prototype.remove=function(){c(history,"pushState",this.c),c(history,"replaceState",this.f),window.removeEventListener("popstate",this.b)},v("urlChangeTracker",_)}();
}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})

},{}]},{},[1])


//# sourceMappingURL=public/js/analytics.js.map