<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style type="text/css">
	#menu-bar{
		position: fixed;
		z-index: 9999;
		top: 40%;
		right: 0%;
		background: white;
		border-radius: 4%;
	}
	.btn{
		text-align: center;
		padding: 2px;
		font-weight: bolder;
		font-size: 300;
	}
	#blur-back{
		position: fixed;
		height: 100vh;
		width: 100vw;
		background-color: black;
		opacity: 50%;
		z-index: 999999;
		display: none;
	}
	#loading-back{
		position: fixed;
		top: 47%;
		left: 47%;
	}
	#loading{
		background: transparent;
		height: 1em;
		width: 1em;
	}
	/*
	  Set the color of the icon
	*/
	svg path,
	svg rect{
	  	fill: #fff;
	}
</style>
</head>
<body>
<div id="blur-back">
	<div id="loading-back" title="Loading...">
		<div id="loading">
  <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
     width="128px" height="64px" viewBox="0 0 128 64" style="enable-background:new 0 0 50 50;" xml:space="preserve">
    <rect x="0" y="16" width="16" height="32" fill="#fff" >
      <animate attributeName="opacity" attributeType="XML" values="0.2; 1; .2" begin="0s" dur="1s" repeatCount="indefinite" />
      <animate attributeName="height" attributeType="XML" values="32; 64; 32" begin="0s" dur="1s" repeatCount="indefinite" />
      <animate attributeName="y" attributeType="XML" values="16; 8; 16" begin="0s" dur="1s" repeatCount="indefinite" />
    </rect>
    <rect x="32" y="16" width="16" height="32" fill="#fff" >
      <animate attributeName="opacity" attributeType="XML" values="0.2; 1; .2" begin="0.2s" dur="1s" repeatCount="indefinite" />
      <animate attributeName="height" attributeType="XML" values="32; 64; 32" begin="0.2s" dur="1s" repeatCount="indefinite" />
      <animate attributeName="y" attributeType="XML" values="16; 8; 16" begin="0.2s" dur="1s" repeatCount="indefinite" />
    </rect>
    <rect x="64" y="16" width="16" height="32" fill="#fff" >
      <animate attributeName="opacity" attributeType="XML" values="0.2; 1; .2" begin="0.4s" dur="1s" repeatCount="indefinite" />
      <animate attributeName="height" attributeType="XML" values="32; 64; 32" begin="0.4s" dur="1s" repeatCount="indefinite" />
      <animate attributeName="y" attributeType="XML" values="16; 8; 16" begin="0.4s" dur="1s" repeatCount="indefinite" />
    </rect>
  </svg>
</div>
	</div>
</div>
<div id="menu-bar" class="show" onclick='hide_show_menu(this)'>
	<div class="btn">&rightarrow;</div>
	<div><a class="btn" href="/">&#127968;</a></div>
	<div><a class="btn" href="/anime">&#9655;</a></div>
	<div><a class="btn" href="/add">&#10010;</a></div>
</div>
<script type="text/javascript">
	function hide_show_menu(menu){
		console.log(menu)
		var menu_items = menu.children
		if(menu.getAttribute('class')==='show'){
			for(let i=0; i<menu_items.length;i++){
				if(i===0)	{menu_items[i].innerHTML='&leftarrow;';}
				else	{hide_show(menu_items[i]);}
			}
			menu.setAttribute('class','hide')
			menu.style.top='50%'
		}else{
			for(let i=0; i<menu_items.length;i++){
				if(i===0)	{menu_items[i].innerHTML='&rightarrow;';}
				else	{hide_show(menu_items[i]);}
			}
			menu.setAttribute('class','show')
			menu.style.top='40%'
		}
	}
	function hide_show(item){
		var dis = item.style.display
		console.log(dis)
		if(dis==='none') item.style.display = 'block';
		else item.style.display = 'none';
	}
</script>
</body>
</html>