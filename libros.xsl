<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:key name="readings-by-year" match="library/book/comment" use="@date"/>
<xsl:key name="books-by-category" match="library/book/category" use="."/>
<xsl:key name="books-by-year" match="library/book/edition" use="year"/>
<xsl:key name="books-by-author" match="library/book/author" use="."/>
<xsl:key name="books-by-publisher" match="library/book/edition/publisher" use="."/>
<xsl:template match="/">
<html>
<head>
<TITLE>Biblioteca Personal</TITLE>
<META NAME="Author" CONTENT="Fernando Berzal Galiano"/>
</head>
<STYLE TYPE="text/css" TITLE="">
BODY { background-image: url(../image/csharp.gif); color: #000000; margin-left: 10%; margin-right: 10%; margin-top: 5%; margin-bottom: 5%; } P, BLOCKQUOTE, LI { text-align: justify; } TABLE, TR, TH, TD, BLOCKQUOTE { padding: 5px; } PRE { font-size: 9pt; } .title { background-color: #BCBCDE; } .author { background-color: #cCcCeE; } .edition { background-color: #cCcCeE; } .info { background-color: #D9D9D9; } .idea { background-color: #FFFFCC; } .comment { background-color: #e9e9e9; } .classification { background-color: #c9c9c9; } .copyright { text-align: right; } A { text-decoration: none; } A:hover { color: #009999; } UL,OL { list-style: outside; margin: 1em; } CODE { display: inline; white-space: pre; text-align: left; } H1 { font-size: 200%; font-weight: bold;	color: #000000; text-align: center; } .title { color: #006699; } H2 { color: #003366; font-size: 150%; font-weight: bold;	text-align: left; } H3 { font-size: 125%; font-weight: bold;	text-align: left; } H4 { font-size: 100%; font-weight: bold;	text-align: left; }
</STYLE>
<BODY>
<H1 ALIGN="center">
<FONT COLOR="#006699">Biblioteca</FONT>
</H1>
<HR/>
<center>
<A HREF="#books">Título original</A>
|
<A HREF="#books.es">Título en castellano</A>
|
<A HREF="#authors">Autores</A>
|
<A HREF="#categories">Categorías</A>
|
<A HREF="#years">Cronología</A>
|
<A HREF="#readings">Lecturas</A>
<!--  | <A HREF="#reviews">Reviews</A>  -->
|
<A HREF="#details">Detalles</A>
</center>
<HR/>
<blockquote>
<A NAME="books"/>
<H2>Listado por título original</H2>
<OL>
<xsl:for-each select="library/book">
<xsl:sort select="title" data-type="text" order="ascending"/>
<li>
<xsl:for-each select="author">
<xsl:value-of select="."/>
,
</xsl:for-each>
<xsl:for-each select="editor">
<xsl:value-of select="."/>
(ed.),
</xsl:for-each>
<br/>
<b>
<A>
<xsl:attribute name="href">
#
<xsl:value-of select="edition/isbn"/>
</xsl:attribute>
<xsl:value-of select="title"/>
</A>
</b>
<!--

          <br/>
          <xsl:value-of select="edition/publisher"/>, <xsl:value-of select="edition/year"/>
          
-->
</li>
</xsl:for-each>
</OL>
<A NAME="books.es"/>
<H2>Listado por título en castellano</H2>
<OL>
<xsl:for-each select="library/book">
<xsl:sort select="title[@language='es']" data-type="text" order="ascending"/>
<li>
<xsl:for-each select="author">
<xsl:value-of select="."/>
,
</xsl:for-each>
<xsl:for-each select="editor">
<xsl:value-of select="."/>
(ed.),
</xsl:for-each>
<br/>
<b>
<A>
<xsl:attribute name="href">
#
<xsl:value-of select="edition/isbn"/>
</xsl:attribute>
<xsl:value-of select="title[@language='es']"/>
</A>
</b>
<!--

          <br/>
          <xsl:value-of select="edition/publisher"/>, <xsl:value-of select="edition/year"/>
          
-->
</li>
</xsl:for-each>
</OL>
<A NAME="authors"/>
<H2>Listado por autor</H2>
<table border="0">
<xsl:for-each select="library/book/author">
<xsl:sort select="." data-type="text" order="ascending"/>
<xsl:sort select="../title" data-type="text" order="ascending"/>
<tr>
<td valign="top">
<xsl:value-of select="."/>
:
</td>
<td>
<A>
<xsl:attribute name="href">
#
<xsl:value-of select="../edition/isbn"/>
</xsl:attribute>
<xsl:value-of select="../title"/>
</A>
<br/>
<i>
<xsl:value-of select="../title[@language='es']"/>
</i>
</td>
</tr>
</xsl:for-each>
</table>
<A NAME="#summary-author"/>
<H3>Resumen por autor</H3>
<table border="0" cell-padding="0" cell-spacing="0">
<xsl:for-each select="library/book/author[count(. | key('books-by-author', .)[1]) = 1]">
<xsl:sort select="count(key('books-by-author', .))" data-type="number" order="descending"/>
<xsl:sort select="."/>
<xsl:variable name="A" select="."/>
<xsl:variable name="N" select="count(/library/book[author=$A])"/>
<xsl:if test="$N>=1">
<tr>
<td width="50" align="right" class="edition">
<xsl:value-of select="$N"/>
</td>
<td width="350">
<A>
<xsl:attribute name="name">
<xsl:value-of select="$A"/>
</xsl:attribute>
</A>
<xsl:value-of select="$A"/>
</td>
</tr>
</xsl:if>
</xsl:for-each>
</table>
<A NAME="categories"/>
<H2>Listado por categorías</H2>
<table border="0" cell-padding="0" cell-spacing="0">
<xsl:for-each select="library/book/category[count(. | key('books-by-category', .)[1]) = 1]">
<xsl:sort select="." data-type="text" order="ascending"/>
<tr class="edition">
<xsl:variable name="C" select="."/>
<xsl:variable name="N" select="count(/library/book/category[.=$C])"/>
<td width="50" align="right" valign="top">
<xsl:value-of select="$N"/>
</td>
<td>
<b>
<xsl:value-of select="$C"/>
</b>
</td>
</tr>
<tr>
<td/>
<td>
<UL>
<xsl:for-each select="/library/book/category[.=$C]">
<!--
<xsl:sort select="." data-type="text" order="ascending"/>
-->
<xsl:sort select="../title" data-type="text" order="ascending"/>
<li>
<!-- [<xsl:value-of select="."/>] -->
<xsl:for-each select="../author">
<xsl:value-of select="."/>
,
</xsl:for-each>
<A>
<xsl:attribute name="href">
#
<xsl:value-of select="../edition/isbn"/>
</xsl:attribute>
<xsl:value-of select="../title"/>
</A>
(
<i>
<xsl:value-of select="../title[@language='es']"/>
</i>
)
</li>
</xsl:for-each>
</UL>
</td>
</tr>
</xsl:for-each>
</table>
<A NAME="#summary-category"/>
<H3>Resumen por categorías</H3>
<table border="0" cell-padding="0" cell-spacing="0">
<xsl:for-each select="library/book/category[count(. | key('books-by-category', .)[1]) = 1]">
<xsl:sort select="count(key('books-by-category', .))" data-type="number" order="descending"/>
<xsl:sort select="."/>
<tr>
<xsl:variable name="A" select="."/>
<xsl:variable name="N" select="count(/library/book[category=$A])"/>
<td width="50" align="right" class="edition">
<xsl:value-of select="$N"/>
</td>
<td width="350">
<A>
<xsl:attribute name="name">
<xsl:value-of select="$A"/>
</xsl:attribute>
</A>
<xsl:value-of select="$A"/>
</td>
</tr>
</xsl:for-each>
</table>
<A NAME="years"/>
<H2>Listado cronológico</H2>
<!--

<table border="0" cell-padding="0" cell-spacing="0">
<xsl:for-each select="library/book/edition[count(. | key('books-by-year', year)[1]) = 1]">
  <xsl:sort select="year" data-type="text" order="ascending"/>
 <xsl:if test="year">
 <tr class="edition">
  <xsl:variable name="Y" select="year"/>
  <xsl:variable name="N" select="count(/library/book/edition[year=$Y])"/>
  <td width="50" align="right"><xsl:value-of select="$N"/></td>
  <td width="50"><xsl:value-of select="$Y"/></td>
 </tr>
 </xsl:if>
</xsl:for-each>
 <tr class="title">
  <td align="right"><xsl:value-of select="count(library/book/edition)"/></td>
  <td></td>
 </tr>
</table>
-->
<UL>
<xsl:for-each select="library/book/edition">
<xsl:sort select="year" data-type="number" order="ascending"/>
<xsl:sort select="title" data-type="text" order="ascending"/>
<li>
[
<xsl:value-of select="year"/>
]
<xsl:for-each select="../author">
<xsl:value-of select="."/>
,
</xsl:for-each>
<A>
<xsl:attribute name="href">
#
<xsl:value-of select="isbn"/>
</xsl:attribute>
<xsl:value-of select="title"/>
</A>
(
<xsl:value-of select="publisher"/>
,
<xsl:value-of select="year"/>
)
</li>
</xsl:for-each>
</UL>
<!--

<A NAME="#summary-publisher"/>
<H3>Resumen por editoriales</H3>

<table border="0" cell-padding="0" cell-spacing="0">
<xsl:for-each select="library/book/edition/publisher[count(. | key('books-by-publisher', .)[1]) = 1]">
 <xsl:sort select="count(key('books-by-publisher', .))" data-type="number" order="descending"/>
 <xsl:sort select="."/>
 <tr class="edition">
  <xsl:variable name="A" select="."/>
  <xsl:variable name="N" select="count(/library/book/edition[publisher=$A])"/>
  <td width="50" align="right"><xsl:value-of select="$N"/></td>
  <td width="350">
    <A>
    <xsl:attribute name="name"><xsl:value-of select="$A"/></xsl:attribute>
    </A>
    <xsl:value-of select="$A"/>
  </td>
 </tr>
</xsl:for-each>
</table>
-->
<!--

<A NAME="reviews"/>
<H2>Reviews</H2>


<ol>
 <xsl:for-each select="library/book">
 <xsl:sort select="title" data-type="text" order="ascending"/>
 <xsl:if test="comment/@file">
      <li>
          <xsl:for-each select="author">
             <xsl:value-of select="."/>,
          </xsl:for-each>
          <A>
          <xsl:attribute name="href">#<xsl:value-of select="edition/isbn"/></xsl:attribute>
 	      <xsl:value-of select="title"/> 
          </A>
          (<xsl:value-of select="edition/publisher"/>, <xsl:value-of select="edition/year"/>)
      </li>
 </xsl:if>
 </xsl:for-each>
</ol>
-->
<A NAME="readings"/>
<H2>Registro de lecturas</H2>
<table>
<tr>
<td valign="top">
<table border="0" cell-padding="0" cell-spacing="0">
<xsl:for-each select="library/book/comment[count(. | key('readings-by-year', @date)[1]) = 1]">
<xsl:sort select="@date" data-type="text" order="descending"/>
<xsl:if test="@date">
<tr class="edition">
<xsl:variable name="Y" select="@date"/>
<xsl:variable name="N" select="count(/library/book/comment[@date=$Y])"/>
<td width="50" align="right">
<xsl:value-of select="$N"/>
</td>
<td width="50">
<xsl:value-of select="$Y"/>
</td>
</tr>
</xsl:if>
</xsl:for-each>
<!--

 <tr class="title">
  <td align="right"><xsl:value-of select="count(library/book/comment)"/></td>
  <td></td>
 </tr>
-->
</table>
</td>
<td valign="top" align="right" width="40%">
<table border="0" cell-padding="0" cell-spacing="0">
<tr>
<th colspan="2" align="left">To be done...</th>
</tr>
<xsl:for-each select="library/book/category[count(. | key('books-by-category', .)[1]) = 1]">
<xsl:sort select="." data-type="text" order="ascending"/>
<xsl:variable name="TBRC" select="."/>
<xsl:variable name="TBRN" select="count(/library/book[comment/@date='TBD' and category=$TBRC])"/>
<xsl:if test="$TBRN>0">
<tr>
<!--  class="edition"  -->
<td width="50" align="right">
<xsl:value-of select="$TBRN"/>
</td>
<td width="250">
<xsl:value-of select="$TBRC"/>
</td>
</tr>
</xsl:if>
</xsl:for-each>
</table>
</td>
<td valign="top" align="right" width="40%"></td>
</tr>
</table>
<table>
<xsl:for-each select="library/book/comment">
<xsl:sort select="@date" data-type="text" order="descending"/>
<xsl:sort select="../title" data-type="text" order="ascending"/>
<xsl:if test="@date">
<tr>
<td valign="top">
[
<xsl:value-of select="@date"/>
]
</td>
<td>
<xsl:for-each select="../author">
<xsl:value-of select="."/>
,
</xsl:for-each>
<A>
<xsl:attribute name="href">
#
<xsl:value-of select="../edition/isbn"/>
</xsl:attribute>
<xsl:value-of select="../title"/>
</A>
(
<i>
<xsl:value-of select="../title[@language='es']"/>
</i>
)
</td>
<td valign="top">
<xsl:if test="@rating!=''">
<img>
<xsl:attribute name="src">
clipart/stars-
<xsl:value-of select="@rating"/>
.gif
</xsl:attribute>
</img>
</xsl:if>
</td>
</tr>
</xsl:if>
</xsl:for-each>
</table>
<HR/>
<!--  Content  -->
<A NAME="details"/>
<xsl:apply-templates/>
<!--  Footer  -->
</blockquote>
<HR/>
<P CLASS="copyright">
©
<A HREF="mailto:berzal@acm.org">Fernando Berzal</A>
</P>
</BODY>
</html>
</xsl:template>
<!--  Subdocumentos  -->
<xsl:template match="library/book">
<P>
<xsl:for-each select="edition/isbn">
<A>
<xsl:attribute name="name">
<xsl:value-of select="."/>
</xsl:attribute>
</A>
</xsl:for-each>
<center>
<table width="80%">
<tr class="title">
<td align="center" valign="center" rowspan="4" width="150">
<A target="_blank">
<xsl:attribute name="id">
lnk
<xsl:value-of select="edition/isbn"/>
</xsl:attribute>
<xsl:attribute name="href">
cover/
<xsl:value-of select="edition/isbn"/>
.jpg
</xsl:attribute>
<img border="0" height="200">
<xsl:attribute name="name">
img
<xsl:value-of select="edition/isbn"/>
</xsl:attribute>
<xsl:attribute name="src">
cover/
<xsl:value-of select="edition/isbn"/>
.jpg
</xsl:attribute>
</img>
</A>
</td>
<th align="left" valign="middle">
<xsl:if test="library!=''">
<img align="right">
<xsl:attribute name="src">
clipart/
<xsl:value-of select="library"/>
.gif
</xsl:attribute>
</img>
</xsl:if>
<font size="+2" color="#003366">
<xsl:value-of select="title"/>
</font>
<br/>
<font size="+1" color="#003366">
<i>
<xsl:value-of select="title[@language='es']"/>
</i>
</font>
</th>
</tr>
<tr class="author">
<td>
<xsl:for-each select="editor">
<b>
<xsl:value-of select="."/>
</b>
(editor)
<br/>
</xsl:for-each>
<xsl:for-each select="author">
<b>
<xsl:value-of select="."/>
</b>
<br/>
</xsl:for-each>
</td>
</tr>
<tr class="edition">
<td>
<xsl:for-each select="edition">
<xsl:if test="title">
<div>
<A target="_blank">
<xsl:attribute name="onmouseover">
document['img
<xsl:value-of select="../edition/isbn"/>
'].src = 'cover/
<xsl:value-of select="isbn"/>
.jpg'; document.getElementById('lnk
<xsl:value-of select="../edition/isbn"/>
').href = 'cover/
<xsl:value-of select="isbn"/>
.jpg';
</xsl:attribute>
<xsl:attribute name="href">
cover/
<xsl:value-of select="isbn"/>
.jpg
</xsl:attribute>
<i>
<xsl:value-of select="title"/>
</i>
</A>
</div>
</xsl:if>
<xsl:value-of select="publisher"/>
,
<xsl:if test="edition">
<xsl:value-of select="edition"/>
,
</xsl:if>
<xsl:value-of select="year"/>
<br/>
<div align="right">
ISBN
<A target="_blank">
<xsl:attribute name="onmouseover">
document['img
<xsl:value-of select="../edition/isbn"/>
'].src = 'cover/
<xsl:value-of select="isbn"/>
.jpg'; document.getElementById('lnk
<xsl:value-of select="../edition/isbn"/>
').href = 'cover/
<xsl:value-of select="isbn"/>
.jpg';
</xsl:attribute>
<xsl:attribute name="href">
cover/
<xsl:value-of select="isbn"/>
.jpg
</xsl:attribute>
<xsl:value-of select="isbn"/>
</A>
</div>
</xsl:for-each>
</td>
</tr>
<tr>
<td align="right" class="classification">
<xsl:for-each select="category">
<b>
<xsl:value-of select="."/>
</b>
<br/>
</xsl:for-each>
</td>
</tr>
<!--  Reviews  -->
<xsl:for-each select="comment">
<tr>
<td valign="top" align="right">
<xsl:if test="@rating!=''">
<img>
<xsl:attribute name="src">
clipart/stars-
<xsl:value-of select="@rating"/>
.gif
</xsl:attribute>
</img>
</xsl:if>
</td>
<td class="comment" align="justify">
<font size="-1">
<xsl:if test="@source">
<b>
<xsl:value-of select="@source"/>
:
</b>
</xsl:if>
<xsl:if test="@file">
<a>
<xsl:attribute name="href">
<xsl:value-of select="@file"/>
</xsl:attribute>
· FULL REVIEW ·
</a>
</xsl:if>
<!-- 

 -->
<xsl:apply-templates/>
</font>
</td>
</tr>
</xsl:for-each>
<!--  INFO  -->
<xsl:for-each select="idea">
<tr>
<td/>
<td class="idea">
<li/>
<font size="-1">
<xsl:apply-templates/>
</font>
</td>
</tr>
</xsl:for-each>
<xsl:for-each select="info">
<tr>
<td/>
<td class="info">
<font size="-1">
<xsl:apply-templates/>
</font>
</td>
</tr>
</xsl:for-each>
</table>
</center>
</P>
</xsl:template>
<!--  URLs  -->
<xsl:template match="url">
<A target="_blank">
<xsl:attribute name="href">
<xsl:value-of select="."/>
</xsl:attribute>
<xsl:value-of select="."/>
</A>
</xsl:template>
<xsl:template match="ref">
<A>
<xsl:attribute name="href">
#
<xsl:value-of select="@isbn"/>
</xsl:attribute>
<xsl:value-of select="."/>
</A>
</xsl:template>
<!--  END  -->
</xsl:stylesheet>