/*
 * @name DoubleScroll
 * @desc displays scroll bar on top and on the bottom of the div
 * @requires jQuery, jQueryUI
 *
 * @author Pawel Suwala - http://suwala.eu/
 * @version 0.2 (07-06-2012)
 *
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 */
(function(l){l.widget("suwala.doubleScroll",{options:{contentElement:void 0,// Widest element, if not specified first child element will be used
topScrollBarMarkup:'<div class="suwala-doubleScroll-scroll-wrapper"><div class="suwala-doubleScroll-scroll" style="height: 1px;"></div></div>',topScrollBarInnerSelector:".suwala-doubleScroll-scroll",scrollCss:{"overflow-x":"scroll","overflow-y":"hidden"},contentCss:{"overflow-x":"scroll","overflow-y":"hidden"}},_create:function(){var e,o=this,t=l(l(o.options.topScrollBarMarkup));o.element.before(t),// find the content element (should be the widest one)			
e=void 0!==o.options.contentElement&&0!==o.element.find(o.options.contentElement).length?o.element.find(o.options.contentElement):o.element.find(">:first-child"),// bind upper scroll to bottom scroll
t.scroll(function(){o.element.scrollLeft(t.scrollLeft())}),// bind bottom scroll to upper scroll
o.element.scroll(function(){t.scrollLeft(o.element.scrollLeft())}),// apply css
t.css(o.options.scrollCss),o.element.css(o.options.contentCss),// set the width of the wrappers
l(o.options.topScrollBarInnerSelector,t).width(e.outerWidth()),t.width(o.element.width())}})})(jQuery);