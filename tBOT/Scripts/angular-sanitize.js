﻿/*
 AngularJS v1.6.4
 (c) 2010-2017 Google, Inc. http://angularjs.org
 License: MIT
*/
(function (s, f) {
    'use strict'; function J(f) { var k = []; v(k, B).chars(f); return k.join("") } var w = f.$$minErr("$sanitize"), C, k, D, E, q, B, F, G, v; f.module("ngSanitize", []).provider("$sanitize", function () {
        function h(a, c) { var b = {}, d = a.split(","), l; for (l = 0; l < d.length; l++)b[c ? q(d[l]) : d[l]] = !0; return b } function K(a) { for (var c = {}, b = 0, d = a.length; b < d; b++) { var l = a[b]; c[l.name] = l.value } return c } function H(a) {
            return a.replace(/&/g, "&amp;").replace(L, function (a) {
                var b = a.charCodeAt(0); a = a.charCodeAt(1); return "&#" + (1024 * (b -
                    55296) + (a - 56320) + 65536) + ";"
            }).replace(M, function (a) { return "&#" + a.charCodeAt(0) + ";" }).replace(/</g, "&lt;").replace(/>/g, "&gt;")
        } function I(a) { for (; a;) { if (a.nodeType === s.Node.ELEMENT_NODE) for (var c = a.attributes, b = 0, d = c.length; b < d; b++) { var l = c[b], e = l.name.toLowerCase(); if ("xmlns:ns1" === e || 0 === e.lastIndexOf("ns1:", 0)) a.removeAttributeNode(l), b-- , d-- } (c = a.firstChild) && I(c); a = t("nextSibling", a) } } function t(a, c) { var b = c[a]; if (b && F.call(c, b)) throw w("elclob", c.outerHTML || c.outerText); return b } var x = !1; this.$get =
            ["$$sanitizeUri", function (a) { x && k(p, z); return function (c) { var b = []; G(c, v(b, function (b, c) { return !/^unsafe:/.test(a(b, c)) })); return b.join("") } }]; this.enableSvg = function (a) { return E(a) ? (x = a, this) : x }; C = f.bind; k = f.extend; D = f.forEach; E = f.isDefined; q = f.lowercase; B = f.noop; G = function (a, c) {
            null === a || void 0 === a ? a = "" : "string" !== typeof a && (a = "" + a); g.innerHTML = a; var b = 5; do { if (0 === b) throw w("uinput"); b--; s.document.documentMode && I(g); a = g.innerHTML; g.innerHTML = a } while (a !== g.innerHTML); for (b = g.firstChild; b;) {
                switch (b.nodeType) {
                    case 1: c.start(b.nodeName.toLowerCase(),
                        K(b.attributes)); break; case 3: c.chars(b.textContent)
                }var d; if (!(d = b.firstChild) && (1 === b.nodeType && c.end(b.nodeName.toLowerCase()), d = t("nextSibling", b), !d)) for (; null == d;) { b = t("parentNode", b); if (b === g) break; d = t("nextSibling", b); 1 === b.nodeType && c.end(b.nodeName.toLowerCase()) } b = d
            } for (; b = g.firstChild;)g.removeChild(b)
            }; v = function (a, c) {
                var b = !1, d = C(a, a.push); return {
                    start: function (a, e) {
                        a = q(a); !b && A[a] && (b = a); b || !0 !== p[a] || (d("<"), d(a), D(e, function (b, e) {
                            var f = q(e), g = "img" === a && "src" === f || "background" ===
                                f; !0 !== u[f] || !0 === n[f] && !c(b, g) || (d(" "), d(e), d('="'), d(H(b)), d('"'))
                        }), d(">"))
                    }, end: function (a) { a = q(a); b || !0 !== p[a] || !0 === e[a] || (d("</"), d(a), d(">")); a == b && (b = !1) }, chars: function (a) { b || d(H(a)) }
                }
            }; F = s.Node.prototype.contains || function (a) { return !!(this.compareDocumentPosition(a) & 16) }; var L = /[\uD800-\uDBFF][\uDC00-\uDFFF]/g, M = /([^#-~ |!])/g, e = h("area,br,col,hr,img,wbr"), y = h("colgroup,dd,dt,li,p,tbody,td,tfoot,th,thead,tr"), m = h("rp,rt"), r = k({}, m, y), y = k({}, y, h("address,article,aside,blockquote,caption,center,del,dir,div,dl,figure,figcaption,footer,h1,h2,h3,h4,h5,h6,header,hgroup,hr,ins,map,menu,nav,ol,pre,section,table,ul")),
                m = k({}, m, h("a,abbr,acronym,b,bdi,bdo,big,br,cite,code,del,dfn,em,font,i,img,ins,kbd,label,map,mark,q,ruby,rp,rt,s,samp,small,span,strike,strong,sub,sup,time,tt,u,var")), z = h("circle,defs,desc,ellipse,font-face,font-face-name,font-face-src,g,glyph,hkern,image,linearGradient,line,marker,metadata,missing-glyph,mpath,path,polygon,polyline,radialGradient,rect,stop,svg,switch,text,title,tspan"), A = h("script,style"), p = k({}, e, y, m, r), n = h("background,cite,href,longdesc,src,xlink:href"), r = h("abbr,align,alt,axis,bgcolor,border,cellpadding,cellspacing,class,clear,color,cols,colspan,compact,coords,dir,face,headers,height,hreflang,hspace,ismap,lang,language,nohref,nowrap,rel,rev,rows,rowspan,rules,scope,scrolling,shape,size,span,start,summary,tabindex,target,title,type,valign,value,vspace,width"),
                m = h("accent-height,accumulate,additive,alphabetic,arabic-form,ascent,baseProfile,bbox,begin,by,calcMode,cap-height,class,color,color-rendering,content,cx,cy,d,dx,dy,descent,display,dur,end,fill,fill-rule,font-family,font-size,font-stretch,font-style,font-variant,font-weight,from,fx,fy,g1,g2,glyph-name,gradientUnits,hanging,height,horiz-adv-x,horiz-origin-x,ideographic,k,keyPoints,keySplines,keyTimes,lang,marker-end,marker-mid,marker-start,markerHeight,markerUnits,markerWidth,mathematical,max,min,offset,opacity,orient,origin,overline-position,overline-thickness,panose-1,path,pathLength,points,preserveAspectRatio,r,refX,refY,repeatCount,repeatDur,requiredExtensions,requiredFeatures,restart,rotate,rx,ry,slope,stemh,stemv,stop-color,stop-opacity,strikethrough-position,strikethrough-thickness,stroke,stroke-dasharray,stroke-dashoffset,stroke-linecap,stroke-linejoin,stroke-miterlimit,stroke-opacity,stroke-width,systemLanguage,target,text-anchor,to,transform,type,u1,u2,underline-position,underline-thickness,unicode,unicode-range,units-per-em,values,version,viewBox,visibility,width,widths,x,x-height,x1,x2,xlink:actuate,xlink:arcrole,xlink:role,xlink:show,xlink:title,xlink:type,xml:base,xml:lang,xml:space,xmlns,xmlns:xlink,y,y1,y2,zoomAndPan",
                    !0), u = k({}, n, m, r), g; (function (a) { if (a.document && a.document.implementation) a = a.document.implementation.createHTMLDocument("inert"); else throw w("noinert"); var c = (a.documentElement || a.getDocumentElement()).getElementsByTagName("body"); 1 === c.length ? g = c[0] : (c = a.createElement("html"), g = a.createElement("body"), c.appendChild(g), a.appendChild(c)) })(s)
    }).info({ angularVersion: "1.6.4" }); f.module("ngSanitize").filter("linky", ["$sanitize", function (h) {
        var k = /((ftp|https?):\/\/|(www\.)|(mailto:)?[A-Za-z0-9._%+-]+@)\S*[^\s.;,(){}<>"\u201d\u2019]/i,
        q = /^mailto:/i, s = f.$$minErr("linky"), t = f.isDefined, x = f.isFunction, v = f.isObject, w = f.isString; return function (e, f, m) {
            function r(a) { a && n.push(J(a)) } function z(a, c) { var b, d = A(a); n.push("<a "); for (b in d) n.push(b + '="' + d[b] + '" '); !t(f) || "target" in d || n.push('target="', f, '" '); n.push('href="', a.replace(/"/g, "&quot;"), '">'); r(c); n.push("</a>") } if (null == e || "" === e) return e; if (!w(e)) throw s("notstring", e); for (var A = x(m) ? m : v(m) ? function () { return m } : function () { return {} }, p = e, n = [], u, g; e = p.match(k);)u = e[0], e[2] ||
                e[4] || (u = (e[3] ? "http://" : "mailto:") + u), g = e.index, r(p.substr(0, g)), z(u, e[0].replace(q, "")), p = p.substring(g + e[0].length); r(p); return h(n.join(""))
        }
    }])
})(window, window.angular);
//# sourceMappingURL=angular-sanitize.min.js.map