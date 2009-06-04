/**
 * RUZEE.ShadedBorder 0.6.1
 * (c) 2006 Steffen Rusitschka
 *
 * RUZEE.ShadedBorder is freely distributable under the terms of an MIT-style license.
 * For details, see http://www.ruzee.com/
 *
 * Tweaked by Piotr.
 *
 * Called by the example page 'Simple.html', in a way like:
 *
 * var renderer = new ShaBoRenderer();
 * renderer.Init({ corner:8, shadow:16 });
 * renderer.RenderElement('my-border');
 * renderer.Dispose();
 * renderer = null;
 */

//-----------------------------------------------------------------------------------------
// Static
//-----------------------------------------------------------------------------------------

//
// Add our styles to the document
//
document.write('\
	<style type="text/css">\
  	.sb, .sbi, .sb *, .sbi * { position:relative; z-index:1; }\
  	* html .sb, * html .sbi { height:1%; }\
  	.sbi { display:inline-block; }\
  	.sb-inner { background:#ddd; }\
  	.sb-shadow { background:#000; }\
  	.sb-border { background:#bbb; }\
  	</style>\
');

//-----------------------------------------------------------------------------------------
// Object ShaBoRenderer
//-----------------------------------------------------------------------------------------

function ShaBoRenderer() {

    //-----------------------------------------------------------------------------------------
	// Public methods
    //-----------------------------------------------------------------------------------------

	this.Init = init;
	this.RenderElement = renderElement;
	this.RenderElements = renderElements;
	this.Dispose = dispose;

	//-----------------------------------------------------------------------------------------
	// Private member fields - String
    //-----------------------------------------------------------------------------------------

	// Shadow class name
	//
	var sclass;

	// Border class name
	//
	var bclass;

	// Inner class name
	//
	var iclass;

	// innerHTML strings
	//
	var tlInnerHTML;
	var trInnerHTML;
	var brInnerHTML;
	var blInnerHTML;
	var tsInnerHTML;
	var bsInnerHTML;
	var mwInnerHTML;

	//-----------------------------------------------------------------------------------------
	// Private member fields - integer
    //-----------------------------------------------------------------------------------------

  	// Shadow size (radius)
  	//
  	var sr;

	// Corder size (radius)
	//
	var r;

	// Border radius?
	//
	var bor;

	// Border width
	//
	var bow;

	// Border opacity
	//
	var boo;

	// Left width
	//
	var lw;

	// Right width
	//
	var rw;

	// Top height
	//
	var th;

	// Bottom height
	//
	var bh;

	// Center point x?
	//
	var cx;

	// Center point y?
	//
	var cy;

	// Center point shadow?
	//
	var cs;

	//-----------------------------------------------------------------------------------------
	// Private member fields - boolean
    //-----------------------------------------------------------------------------------------

	// Debug flag
	//
	var debug = false;

	// Boolean whether the user agent is IE.
	//
	var isie = /msie/i.test(navigator.userAgent) && !window.opera;

  	// Boolean whether the user agent is IE6.
  	//
  	var isie6 = isie && !window.XMLHttpRequest;

    //-----------------------------------------------------------------------------------------
	// Public initializing
    //-----------------------------------------------------------------------------------------

	// Initialize the borders
	// @param opts An array with options.
	// @return void
	//
	function init(opts) {
		//
		// (Re-)initialize member fields as per options passed
		//
	  	sr = opts.shadow || 0;
	  	r = opts.corner || 0;
	  	bor = 0;
	  	bow = opts.border || 0;
	  	boo = opts.borderOpacity || 1;
	  	lw = r > sr ? r : sr;
	  	rw = lw;
	  	th = lw;
	  	bh = lw;
	  	//
	  	if (bow > 0) {
	    	bor = r;
	    	r = r - bow;
	  	}
	    //
	  	cx = r != 0 && sr != 0 ? Math.round(lw / 3) : 0;
	  	cy = cx;
	  	cs = Math.round(cx / 2);
	  	//
	  	// The edges String - Defaults to "trlb" (Top Right Left Bottom)
	  	// Used to initialize th, bh, lw and rw
	  	//
		var edges = opts.edges || "trlb";
	  	//
	  	if (!/t/i.test(edges)) th = 0;
	  	if (!/b/i.test(edges)) bh = 0;
	  	if (!/l/i.test(edges)) lw = 0;
	  	if (!/r/i.test(edges)) rw = 0;
	  	//
	  	edges = null;

	  	// ------------------------------------------------------------------------------------
	  	// Start Style Classes Hack
		// ------------------------------------------------------------------------------------

		/*
			This is a small hack to allow for setting different pseudo class names than
			the default: sb-inner, sb-border and sb-shadow
			This is important since it allows for shaded border elements to contain
			other shaded border elements. Using the default pseudo class names for both,
			often (in GWT) results in the parent element's psuedo class name overriding the
			one of the element, and, thus, unpredicted behaviour.

			The following options may be added:

			innerClassName
			borderClassName
			shadowClassName

			The original code was:

		  	var iclass = r > 0 ? "sb-inner" : "sb-shadow";
		  	var sclass = "sb-shadow";
		  	var bclass = "sb-border";

	  	*/

		//
		// Style classes
		//
	  	sclass = (opts.shadowClassName ? opts.shadowClassName : "sb-shadow");
	  	bclass = (opts.borderClassName ? opts.borderClassName : "sb-border");
	  	iclass = r > 0 ? (opts.innerClassName ? opts.innerClassName : "sb-inner") : sclass;

	  	// ------------------------------------------------------------------------------------
	  	// End hack
	  	// ------------------------------------------------------------------------------------

	  	// ------------------------------------------------------------------------------------
	  	// Memory Leaks Notes
		//
		// Below shows the structure of the original code:
		//
		// corner(tl, true, true);
	  	// corner(tr, true, false);
	  	// corner(bl, false, true);
	  	// corner(br, false, false);
	  	// mid(mw);
	  	// tb(t, true);
	  	// tb(b, false);
	  	//
		// Running the code as above causes hugh memory leaks in IE.
		//
	  	// TESTED as follows with 'Drip':
	  	// @see http://www.outofhanwell.com/ieleak/index.php?title=Main_Page
	  	//
	  	// var s = corner(true, true);
	  	// if (true) return; // NO mem leak showing in Drip
	  	// tl.innerHTML = s;
	  	//
	  	// var s = corner(true, true);
	  	// /* if (true) return;*/
	  	// tl.innerHTML = s; // Mem leak in Drip after this statement
	  	//
	  	// On the 'Simple.html' page this setup causes approx. 396 leaks!
		//
		// @see: http://msdn.microsoft.com/library/default.asp?url=/library/en-us/IETechCol/dnwebgen/ie_leak_patterns.asp
		// @see: http://ecmascript.stchur.com/blogcode/ie_innerhtml_memleak/leak.html
		// @see: http://jibbering.com/faq/faq_notes/closures.html#clMem
		// @see: http://tests.novemberborn.net/javascript/memory-leakage/memory-leakage.html
		// @see: http://blog.grimpoteuthis.org/2005/01/dhtml-leaks-like-sieve.html
		// @see: http://www.quirksmode.org/blog/archives/2005/02/javascript_memo.html
		//
		// The problem is that, in the functions as called, the passed element's innerHTML is set,
		// before the element has been added to the DOM. Actually, the element is never added, but
		// used for cloning. Still, setting the innerHTML like this causes the leaks.
		//
		// To avoid memory leaks we'll have to add the elements to the DOM first,
		// then set the innerHTML.
		//
		// @see: http://ecmascript.stchur.com/blogcode/ie_innerhtml_memleak/noleak.html
		// @see: http://tests.novemberborn.net/javascript/memory-leakage/event-cache.html
		//
		// A different approach has been made.
		//
		// - The elements, that are used for cloning, are created, and added to a hidden div container.
		// - innerHTML as required for the elements are created but left in class member fields
		// - Upon cloning the base elements in the render operation, the innerHTML is set just before
		//   the cloned element is added to the DOM.
		// - The dispose method will set the innerHTML member fields to null.
		// - The hidden div container is (for now) left, since removing it also causes a (small) memory
		//   leak. [TODO]

		// The hidden div that will contain the div's to be cloned
		//
	  	ensureDivContainer();
		//
	  	// An array used to style the div elements
	  	//
	  	var styles = { position: "absolute",
		  				left: "0",
		  				top: "0",
		  				width: lw + "px",
		  				height: th + "px",
		            	ie_fontSize: "1px",
		            	overflow: "hidden",
		            	margin: "0",
		            	padding: "0"
	            	};

	  	//
	  	// Initialize elements that are cloned - TODO: Check MemLeaks - DONE
	  	//
	  	// Top Left Element
	  	//
	  	ensureDiv("_shaboren_tl", styles, true);
		//
		// Re-adjust array
		//
	  	delete styles.left;
	  	styles.right = "0";
	  	styles.width = rw + "px";
	  	//
	  	// Top Right Element
	  	//
	  	ensureDiv("_shaboren_tr", styles, true);
		//
		// Readjust array
		//
	  	delete styles.top;
	  	styles.bottom = "0";
	  	styles.height = bh + "px";
	  	//
	  	// Bottom Right Element
	  	//
	  	ensureDiv("_shaboren_br", styles, true);
		//
		// Readjust array
		//
	  	delete styles.right;
	  	styles.left = "0";
	  	styles.width = lw + "px";
	  	//
	  	// Bottom Left Element
	  	//
	  	ensureDiv("_shaboren_bl", styles, true);
		//
	  	// T W Element
	  	//
	  	var tw = ensureDiv("_shaboren_tw",
  						{ position: "absolute",
  						width: "100%",
  						height: th + "px",
  						ie_fontSize: "1px",
  						top: "0",
  						left: "0",
  						overflow: "hidden",
  						margin: "0",
  						padding: "0"},
  						true);
	  	//
	  	// T Element
	  	//
	  	var t = ensureDiv("_shaboren_t",
	  					{ position: "relative",
  						height: th + "px",
  						ie_fontSize: "1px",
                  		margin: "0 "+ rw + "px 0 " + lw + "px",
                  		overflow: "hidden",
                  		padding: "0"},
                  		false);
	  	//
	  	if (tw.firstChild == null) {
	  		tw.appendChild(t);
	  	}
		//
	  	// B W Element
	  	//
	  	var bw = ensureDiv("_shaboren_bw",
	  					{ position: "absolute",
  						left: "0",
  						bottom: "0",
  						width: "100%",
  						height: bh + "px",
                 		ie_fontSize: "1px",
                 		overflow: "hidden",
                 		margin: "0",
                 		padding: "0" },
                 		true);
	    //
	  	// B Element
	  	//
	  	var b = ensureDiv("_shaboren_b",
	  					{ position: "relative",
  						height: bh + "px",
  						ie_fontSize: "1px",
                  		margin: "0 "+ rw + "px 0 " + lw + "px",
                  		overflow: "hidden",
                  		padding: "0" },
                  		false);
	    //
	  	if (bw.firstChild == null) {
	  		bw.appendChild(b);
	  	}
		//
	  	// M W Element
	  	//
	  	ensureDiv("_shaboren_mw",
	  					{ position: "absolute",
  						top: (-bh) + "px",
  						left: "0",
  						width: "100%",
  						height: "100%",
                   		overflow: "hidden",
                   		ie_fontSize: "1px",
                   		padding: "0",
                   		margin: "0" },
                   		true);
		//
		styles = null;
		//
		// Create innerHTML
		//
	  	tlInnerHTML = corner(true, true);
	  	trInnerHTML = corner(true, false);
	  	blInnerHTML = corner(false, true);
	  	brInnerHTML = corner(false, false);
	  	mwInnerHTML = mid();
	  	tsInnerHTML = tb(true);
	  	bsInnerHTML = tb(false);
		//
	  	// TESTED with Drip: No leaks after the above
		//
		tw = null;
		t = null;
		bw = null;
		b = null;
	}

	//-----------------------------------------------------------------------------------------
	// Public rendering
    //-----------------------------------------------------------------------------------------

	// Renders the border for passed element.
	// @param elementId The element object or element id string.
	// @return void
	//
	function renderElement(element) {
		doRender(element);
	}

	// Renders the borders of elements within passed array.
	// @param elementArray The array with element objects or element id strings.
	// @return void
	//
	function renderElements(elementArray) {
		if (elementArray.length != undefined) {
    		for (var i = 0; i < elementArray.length; ++i) {
    			doRender(elementArray[i]);
    		}
  		}
	}

	//-----------------------------------------------------------------------------------------
	// Private rendering
    //-----------------------------------------------------------------------------------------

	// Renders the border for passed element id.
	// @param elementId The element id to render for.
	// @return void
	//
	function doRender(element) {
		if (debug) {
			if (typeof element.outerHTML !== 'undefined') {
				// IE
				alert("Render for \n" + element.outerHTML);
			}
			else {
				alert("Render for \n" + element.innerHTML);
			}
		}
		var el;
		if (typeof element == 'string') {
			el = document.getElementById(element);
			if (el == undefined) {
				if (debug) {
					alert("Element not found: " + element);
				}
				return;
			}
		}
		else {
			el = element;
		}
		//
      	// Changed by Piotr - Do not add the style name if it is already present
      	// ORG code: el.className += (" sb");
  		//
  		if (el.className.indexOf(" sb") == -1) {
    		el.className += (" sb");
  		}
		//
  		// Apply style
  		//
  		applyStyle(el, { position:"relative", background:"transparent" });
  		//
  		// Remove 'any former' generated children
  		// For instance on a second time rendering
  		//
  		var node = el.firstChild;
  		var nextNode;
  		while (node) {
    		nextNode = node.nextSibling;
    		if (node.nodeType == 1 && node.className == 'sb-gen') {
      			el.removeChild(node);
      		}
    		node = nextNode;
  		}
  		nextNode = null;
		node = null;
		//
		// Clone elements and set innerHTML
		//
  		var iel = el.firstChild;
		//
		// Fields required for IE
		//
  		var twc = createClone("_shaboren_tw"); // child = t
  		var mwc = createClone("_shaboren_mw");
  		var bwc = createClone("_shaboren_bw"); // child = b
		//
		var tl = createClone("_shaboren_tl");
		el.insertBefore(tl, iel);
		tl.innerHTML = tlInnerHTML;
		//
		var tr = createClone("_shaboren_tr");
		el.insertBefore(tr, iel);
		tr.innerHTML = trInnerHTML;
		//
		var bl = createClone("_shaboren_bl");
		el.insertBefore(bl, iel);
		bl.innerHTML = blInnerHTML;
		//
		var br = createClone("_shaboren_br");
		el.insertBefore(br, iel);
		br.innerHTML = brInnerHTML;
		//

		el.insertBefore(twc, iel);
  		twc.firstChild.innerHTML = tsInnerHTML;


		el.insertBefore(mwc, iel);
  		mwc.innerHTML = mwInnerHTML;



		el.insertBefore(bwc, iel);
  		bwc.firstChild.innerHTML = bsInnerHTML;

  		tl = null;
		tr = null;
		br = null;
		bl = null;

  		//
  		// IE6 mouse and IE resize handling
  		//

  		if (isie6) {
    		el.onmouseover = function() {
    			//
    			// Piotr, note: 'this' is the element that has this function ;-)
    			//
    			this.className += " hover";
    		}
    		el.onmouseout = function() {
    			this.className = this.className.replace(/ hover/,"");
    		}
  		}

  		if (isie) {
  			//
    		function resize() {
      			twc.style.width = bwc.style.width = mwc.style.width = el.offsetWidth + "px";
      			mwc.firstChild.style.height = el.offsetHeight + "px";
    		}
    		el.onresize = resize;
    		resize();
  		}
  		//
  		// We cannot set the values to null, since they are used
  		// within the resize handler above
  		//
  		//iel = null;
  		//twc = null;
  		//bwc = null;
  		//mwc = null;
  		//el = null;

	}

	//-----------------------------------------------------------------------------------------
	// Public dispose
    //-----------------------------------------------------------------------------------------

	// Disposes member field objects within this object.
	// @return void
	//
	function dispose() {
		tlInnerHTML = trInnerHTML = brInnerHTML = blInnerHTML = tsInnerHTML = bsInnerHTML = mwInnerHTML = null;
		sclass = bclass = iclass = null;
		removeDivContainer(); // Note: Function removeDivContainer is disabled until the small Mem leak solved
	}

    //-----------------------------------------------------------------------------------------
	// Private utilities
    //-----------------------------------------------------------------------------------------

	// Creates a clone of an element that has passed id
	// @param id The id
	// @return The cloned element
	//
	function createClone(id) {
		var element = document.getElementById(id);
		if (element != null) {
			var clone = element.cloneNode(true);
			clone.removeAttribute("id");
			if (clone.firstChild) {
				clone.firstChild.removeAttribute("id");
			}
			return clone;
		}
		return null;
	}

	// Deletes a node, by deleting all it's children and their children and theirs... ;-)
	// @param node The node.
  	// @return void
  	//
	function deleteNode(node) {
		if (node) {
			//
 	    	deleteChildren(node);
	        if (typeof node.outerHTML !== 'undefined') {
	        	node.outerHTML = ''; //prevent pseudo-leak in IE
	        }
	        else {
	        	if (node.parentNode) {
	            	node.parentNode.removeChild(node);
	            }
	            delete node; //clean up just to be sure
	       }
		}
	}

	// Deletes a node's children', by deleting all it's children and their children and theirs... ;-)
	// @param node The node.
  	// @return void
  	//
	function deleteChildren(node) {
		if (node) {
			for (var i = node.childNodes.length - 1; i >= 0; i--) {
				var childNode = node.childNodes[i];
  				if (childNode.hasChildNodes()) {
          			deleteChildren(childNode);
          		}
  				if (typeof childNode.outerHTML !== 'undefined') {
          			childNode.outerHTML = ''; //prevent pseudo-leak in IE
          		}
          		else {
	          		node.removeChild(childNode);
          		}
  				delete childNode; //clean up just to be sure
	       	}
		}
	}

	// Ensures a hidden div container.
  	// @return The hidden div container.
  	//
	function ensureDivContainer() {
		var cont = document.getElementById("__ShaBoRendererDivContainer");
		if (cont == null) {
			cont = document.createElement("div");
			cont.setAttribute("id", "__ShaBoRendererDivContainer");
		  	document.body.appendChild(cont);
		  	cont.style["position"] = "absolute";
		  	cont.style["left"] = "-9999px";
		  	cont.style["display"] = "none";
		}
		return cont;
	}

	// Gets the hidden div container.
	// Null if not created.
  	// @return The hidden div container.
  	//
  	function getDivContainer() {
		return document.getElementById("__ShaBoRendererDivContainer");
	}

	// Remove the hidden div container.
	// THIS FUNCTION IS DISABLED UNTIL THE SMALL MEM LEAK THAT IS CAUSED IS RESOLVED
	// This isn't a hugh problem since the container only contains a small amount of nodes.
  	// @return void
  	//
	function removeDivContainer() {
		/*
		var cont = getDivContainer();
		if (cont != undefined) {
			//
			// Causes small memory leak: document.body.removeChild(cont);
			// Also causes small memory leak: deleteNode(cont);
			//
		}
		*/
	}

	// Ensures a DIV with passed id exists within the hidden div container.
	// Assumes the hidden div container is available.
	// Styles the div with passed styles.
	// Assumes the passed style names are alwyas the same.
	// @param id The div's id.
  	// @param stylesArray an array with styles.
  	// @param doAdd Whether to add the element if created.
  	// @return The created DIV element
  	//
  	function ensureDiv(id, stylesArray, doAdd) {
  		var element = document.getElementById(id);
  		if (element == null) {
  			return createDiv(id, stylesArray, doAdd);
  		}
  		//
  		// No need to remove styles first, the style names
  		// are assumed to be always the same
  		//
  		applyStyle(element, stylesArray);
    	return element;
  	}

	// Creates a DIV with passed id in the hidden div container.
	// Assumes the hidden div container is available.
	// Styles the div with passed styles.
	// Assumes the passed style names are alwyas the same.
	// @param id The div's id.
  	// @param stylesArray an array with styles.
  	// @param doAdd Whether to add the element if created.
  	// @return The created DIV element
  	//
  	function createDiv(id, stylesArray, doAdd) {
    	var element = document.createElement("div");
    	element.setAttribute("id", id);
    	element.className = "sb-gen";
    	applyStyle(element, stylesArray);
    	if (doAdd) {
	    	var cont = getDivContainer();
    		cont.appendChild(element);
    	}
    	return element;
  	}

  	// Styles the passed element with passed styles array.
  	// param element The element.
  	// param stylesArray An array with styles.
  	// @return void
  	//
  	function applyStyle(element, stylesArray) {
    	for (name in stylesArray) {
      		if (/ie_/.test(name)) {
        		if (isie) {
        			element.style[name.substr(3)] = stylesArray[name];
        		}
      		}
      		else {
      			element.style[name] = stylesArray[name];
      		}
    	}
  	}

  	// Creates an opacity string.
  	// param value integer The requested opacity.
  	// @return The opacity string
  	//
  	function createOpacityString(value) {
    	if (value > 0.99999) {
    		return "";
    	}
    	value = value < 0 ? 0 : value;
    	return isie ? " filter:alpha(opacity=" + (value * 100) + ");" : " opacity:" + value + ';';
  	}

  	// Create the corners inner htnl.
  	// @param isTop boolean Whether top.
  	// @param isLeft boolean Whether left.
  	// String The innerHTML for an element.
  	//
  	function corner(isTop, isLeft) {
    	// Arrays
    	//
    	var dsb = [];
    	var dsi = [];
    	var dss = [];

    	// ints
    	//
    	var w = isLeft ? lw : rw;
    	var h = isTop ? th : bh;
    	var s = isTop ? cs : -cs;

    	// ints - const values
    	//
    	var xd = isLeft ? -1 : 1;
   		var yd = isTop ? 1 : -1;

    	// This value is changed as per loop
    	//
    	var xp = isLeft ? (w - 1) : 0;

    	for (var x = 0; x < w; ++x) {

      		// This value is changed as per loop
    		//
      		var yp = isTop ? 0 : h - 1;

      		var finished = false;

      		for (var y = h - 1 ; y >= 0 && !finished; --y) {

        		var div = '<div style="position:absolute; top:' + yp + 'px; left:' + xp + 'px; ' +
                  	'width:1px; height:1px; overflow:hidden; margin:0; padding:0;';

        		var xc = x - cx;
        		var yc = y - cy - s;
        		var d = Math.sqrt(xc * xc + yc * yc);
        		var doShadow = false;

        		if (r > 0) {
        			//
          			// draw border
          			//
          			if (xc < 0 && yc < bor && yc >= r || yc < 0 && xc < bor && xc >= r) {
            			dsb.push(div + createOpacityString(boo) + '" class="' + bclass + '"></div>');
          			}
          			else if (d < bor && d >= r - 1 && xc >= 0 && yc >= 0) {
            			var dd = div;
            			if (d >= bor - 1) {
              				dd += createOpacityString((bor - d) * boo);
              				doShadow = true;
            			}
            			else {
            				dd += createOpacityString(boo);
            			}
            			dsb.push(dd + '" class="' + bclass + '"></div>');
          			}

          			//
          			// draw inner
          			//
          			var dd = div + ' z-index:2;' + (isTop ? 'background-position:0 -' + (r - yc - 1) + 'px;' : 'background-image:none;');
			        var doFinish = false;

          			if (xc < 0 && yc < r || yc < 0 && xc < r) {
            			doFinish = true;
          			}
          			else if (d < r && xc >= 0 && yc >= 0) {
            			if (d >= r - 1) {
              				dd += createOpacityString(r - d);
              				doShadow = true;
              				dsi.push(dd + '" class="' + iclass + '"></div>');
            			}
            			else {
              				doFinish = true;
            			}
          			}
          			else {
          				doShadow = true;
          			}

          			//
          			// Finish
          			//
          			if (doFinish) {
            			if (!isTop) {
            				dd = dd.replace(/top\:\d+px/, "top:0px");
            			}
            			dd = dd.replace(/height\:1px/, "height:" + (y + 1) + "px");
            			dsi.push(dd + '" class="' + iclass + '"></div>');
            			finished = true;
          			}

        		} // if r > 0
        		else {
        			doShadow = true;
        		}

        		//
        		// draw shadow
        		//
        		if (sr > 0 && doShadow) {
          			d = Math.sqrt(x * x + y * y);
          			if (d < sr) {
            			dss.push(div + ' z-index:0; ' + createOpacityString(1 - (d / sr)) + '" class="' + sclass + '"></div>');
          			}
        		}
        		yp += yd;

      		} // for var y loop

      	xp += xd;

    	} // for var x loop

    	var iHTML = dss.concat(dsb.concat(dsi)).join('');
    	dsb = null;
    	dsi = null;
    	dss = null;
    	return iHTML;
  	}

	// Creates the middle element innerHTML (?)
  	// @return String The innerHTML for an element.
  	//
  	function mid() {

		// Array
		//
		var ds = [];

	    ds.push('<div style="position:relative; top:' + (th + bh) + 'px; height:2048px; ' +
	    		' margin:0 ' + (rw - r - cx) + 'px 0 ' + (lw - r - cx) + 'px; ' +
	            ' padding:0; overflow:hidden;' +
	            ' background-position:0 ' + (th > 0 ? -(r + cy + cs) : '0') + 'px;"' +
	            ' class="' + iclass + '"></div>');

	    var dd = '<div style="position:absolute; width:1px;' +
	        	' top:' + (th + bh) + 'px; height:2048px; padding:0; margin:0;';

	    if (sr > 0) {

	    	for (var x = 0; x < lw - r - cx; ++x) {
	        	ds.push(dd + ' left:' + x + 'px;' + createOpacityString((x + 1.0) / lw) +
	            '" class="' + sclass + '"></div>');
	      	}

	      	for (var x = 0; x < rw - r - cx; ++x) {
	        	ds.push(dd + ' right:' + x + 'px;' + createOpacityString((x + 1.0) / rw) +
	            '" class="' + sclass + '"></div>');
	      	}
	    }

	    if (bow > 0) {
	      	var su = ' width:' + bow + 'px;' + createOpacityString(boo) + '" class="' + bclass + '"></div>';
	      	ds.push(dd + ' left:' + (lw - bor - cx) + 'px;' + su);
	      	ds.push(dd + ' right:' + (rw - bor - cx) + 'px;' + su);
	    }

	    var iHTML = ds.join('');
	    ds = null;
	    return iHTML;
	}

	// Creates the top bottom innerHTML
  	// @param isTop Whether top.
  	// @return String The innerHTML for an element.
  	//
  	function tb(isTop) {

	    // Array
	    //
	    var ds = [];

	    // int
	    //
	    var h = isTop ? th : bh;

	    var dd = '<div style="height:1px; overflow:hidden; position:absolute; margin:0; padding:0;' +
	    	    ' width:100%; left:0px; ';

	    // int
	    //
	    var s = isTop ? cs : -cs;

	    for (var y = 0; y < h - s - cy - r; ++y) {
	      	if (sr > 0) {
	      		ds.push(dd + (isTop ? 'top:' : 'bottom:') + y + 'px;' + createOpacityString((y + 1) * 1.0 / h) +
	          	'" class="' + sclass + '"></div>');
	        }
	    }

	    if (y >= bow) {
	      ds.push(dd + (isTop ? 'top:' : 'bottom:') + (y - bow) + 'px;' + createOpacityString(boo) +
	          ' height:' + bow + 'px;" class="' + bclass + '"></div>');
	    }

	    ds.push(dd + (isTop ? 'background-position-y:0; top:' :
	        'background-image:none; bottom:') + y + 'px;' +
	        ' height:' + (r + cy + s) + 'px;" class="' + iclass + '"></div>');

	    var iHTML = ds.join('');
	    ds = null;
	    return iHTML;
  	}

} // End ShaBoRenderer
