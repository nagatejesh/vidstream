<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<%@ include file="navigation.jsp" %>
<html>
<head>
<%@ include file="file.txt"%>
<meta charset="ISO-8859-1">
<title>VidStream | Animes</title>
<style>
html, body {
	padding: 0;
	margin: 0;
	height: 100%;
	background: repeating-linear-gradient(45deg,#ccffff,#ffcccc);
	overflow-x:hidden;
}

.container {
	margin-top:2rem;
}
.card{
	background: repeating-linear-gradient(45deg,#ffcccc,#ccffff);
	box-shadow: 2px 2px gray;
	/*background-color: wheat;*/
}
.card:hover{
	transform: translate(-2px,-2px);
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container">
		<div class="container-fluid row justify-content">
		<div class="col-sm-2">
			<a href="/add" class="btn btn-success">Add</a>
		</div>
		<form action="#" name="filterform" class="row col-sm-6">
			<div class="col-sm-12 col-lg-4">
				<label>
				<select class="form-control" name="watched" id="watched">
					<option value="0">All
					<option value="1">Watched
					<option value="2">Yet to Watch
				</select>
				Watched</label>
			</div>
			<div class="col-sm-12 col-lg-4">
				<label>
				<select class="form-control" name="_18Plus"
				 id="_18Plus">
				<!--  onchange="filter()" -->
					<option value="0">All
					<option value="1">18+
					<option value="2">Under 18
				</select>
				&#128286;</label>
			</div>
			<div class="col-sm-12 col-lg-4">
				<button onclick="applyfilter()" type="button" class="btn btn-danger">Apply</button>
			</div>
			</form>
			<div class="col-sm-4">
					<form method="get" action="/search" name='searchform'>
				<label class="form-group">
					<input class='form-control' list='ids'
					name='search'  type='search' id='search' onchange="search()"/>
					<!-- onchange='search(this.value)' 
					--> 
				</label>
					</form>
				<datalist id="ids">
					<c:forEach var="value" items="${names}">
						<option value="${value}" />
					</c:forEach>
				</datalist>
			</div>
		</div>
		<div class="card-columns" id="container">
			<c:forEach var="anime" items="${list}">
				<div class="card" onclick="view('${anime.id}')">
					<div class="card-body">
							<h5 class="card-title">${anime.engName}</h5>
							<h5 class="card-subtitle text-muted">${anime.japName}</h5>
							<div class="card-text">
									<p class="float-left">
										<c:if test="${anime.isWatched()}"><span class="text-success">&#x2714;</span></c:if>
										<c:if test="${not anime.isWatched()}"><span class="text-danger">&#x2716;</span></c:if>
									</p>
									<p class="float-right">
										<c:if test="${anime.isPlus18()}"><span class="text-danger">&#128286;</span></c:if>
									</p>
							</div>
							<br/>
							<br/>
							<div>
									<a class="btn btn-success float-right"
										href="/view/${anime.id}" target="blank">View</a>
							</div>
							<br/>
					</div>

				</div>
			</c:forEach>
		</div>

		<div id="more" class="container-fluid row justify-content">
			<button class=" btn btn-lg btn-danger" id='showless' onclick="showless()">Show less</button>
			<button class=" btn btn-lg btn-danger" id='loadmore' onclick="loadmore()">Load more</button>
		</div>
	</div>
	<script defer>
		var total = ${total}
		console.log(total)
		var curpage = 1;
		var showless_btn = document.getElementById('showless')
		var loadmore_btn = document.getElementById('loadmore')
		var loading_scn = document.getElementById('blur-back')
		var xhttp = new XMLHttpRequest()
		var cards = document.getElementsByClassName('card')
		
		function checkforloadmore(){
			showless_btn.style.display = 'none';
			console.log(total)
			if(!total || total<=20){
				document.getElementById('more').style.display = 'none';
			}else{
				document.getElementById('more').style.display = 'block';
			}
		}
		checkforloadmore();
		function view(value){
			console.log(value)
			location.replace('http://localhost:2021/view/'+value);
		}
		function showless(){
			show(loading_scn)
			curpage=1
			for(let i =20;i<cards.length;i++){
				cards[i].remove()
			}
			loadmore_btn.style.display = 'block'
			showless_btn.style.display = 'none'
			hide(loading_scn)
		}
		function applyfilter(){
			show(loading_scn)
			var watch = document.filterform.watched.value;
			var plus18 = document.filterform._18Plus.value;
			xhttp.open('post','/filter');
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.responseType = 'json';
			xhttp.send('watched='+watch+'&plus18='+plus18);
			xhttp.onload = ()=>{
				var result = xhttp.response
				console.log(result)
				total = result['total']
				var anilist = result['animes'] 
				var cardcol = document.getElementsByClassName('card-columns')[0]
				cardcol.innerHTML = ''
				for(let i=0;i<anilist.length;i++){
					var obj = anilist[i]
					var card = getCard(obj);
					console.log(card)
					cardcol.appendChild(card)
				}
				curpage=1;
				checkforloadmore()
			}
			hide(loading_scn)
		}
		function loadmore(){
			show(loading_scn)
			curpage+=1;
			var watch = document.filterform.watched.value;
			var plus18 = document.filterform._18Plus.value;
			xhttp.open('post','/page/'+curpage);
			xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
			xhttp.responseType = 'json';
			xhttp.send('watched='+watch+'&plus18='+plus18);

			xhttp.onload = ()=>{
				var result = xhttp.response
				var cardcol = document.getElementsByClassName('card-columns')[0]
				console.log(result)
				for(let i=0;i<result.length;i++){
					var obj = result[i]
					var card = getCard(obj);
					console.log(card)
					cardcol.appendChild(card)
				}
				showless_btn.style.display = 'block'
				if((curpage+1)*10>total){
					loadmore_btn.style.display = 'none'
				}
			}
			hide(loading_scn)
		}
		function show(item){
			item.style.display = 'block'
		}
		function hide(item){
			var x= setTimeout(()=>{
			item.style.display = 'none'
				},1000)
		}
		function getCard(obj){
			var div1 = document.createElement('div');
			div1.setAttribute('class','card');
			div1.setAttribute('onclick','view(\''+obj.id+'\')');

			var div2 = document.createElement('div')
			div2.setAttribute('class','card-body')

			var h51 = document.createElement('h5')
			h51.setAttribute('class','card-title')
			h51.innerText = obj.engName

			var h52 = document.createElement('h5')
			h52.setAttribute('class','card-subtitle text-muted')
			h52.innerText = obj.japName

			var div3 = document.createElement('div')
			div3.setAttribute('class','card-text')

			var p1 = document.createElement('p')
			p1.setAttribute('class','float-left')

			var span1 = document.createElement('span')
			if(obj.watched){
			span1.setAttribute('class','text-success')
			span1.innerHTML = '&#x2714;'
			}else{
			span1.setAttribute('class','text-danger')
			span1.innetHTML = '&#x2716;'
			}

			var p2 = document.createElement('p')
			p2.setAttribute('class','float-right')
			if(obj.plus18){
			var span2 = document.createElement('span')
			span2.setAttribute('class','text-danger')
			span2.innerHTML = '&#128286;'

			p2.appendChild(span2);
			}

			var br = document.createElement('br')

			var div4 = document.createElement('div')

			var a = document.createElement('a')
			a.setAttribute('class','btn btn-success float-right')
			a.setAttribute('href','/view/'+obj.id)
			a.setAttribute('target','blank')
			a.innerText = 'View'

			div4.appendChild(a);
			p1.appendChild(span1);
			div3.appendChild(p1)
			div3.appendChild(p2)

			div2.appendChild(h51)
			div2.appendChild(h52)
			div2.appendChild(div3)
			var temp = div2.innerHTML
			div2.innerHTML = temp+'<br/><br/>'
			div2.appendChild(div4)
			div2.appendChild(br)

			div1.appendChild(div2)

			return div1;
		}
		async function search(){
				var value = document.getElementById('search').value
				console.log(value)
				xhttp.open('get','/search/'+value)
				xhttp.responseType = 'json'
				xhttp.send()
				
				xhttp.onload =()=>{
					var result = xhttp.response
					console.log(result)
				}
				/*
				var splitresult = result.split('(next)')
				var finalresult = []
				var list = document.getElementById('ids')
				for(let i=0; i<splitresult.length-1;i++){
						finalresult[i]=splitresult.split('(id)')
						var option = document.createElement('option')
						option.setAttribute('value',finalresult[i][0])
						option.innerText = finalresult[i][1]
						list.appendChild(option)
					}*/				
		}
	</script>
	
<%@ include file="./script.txt" %>
</body>
</html>