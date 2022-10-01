package com.nbc.controllers;

import java.util.List;
import java.util.Map;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nbc.model.Anime;
import com.nbc.service.AnimeService;

@Controller
public class HomeController {
	
	final Log log = LogFactory.getLog(HomeController.class);
	final String anchortag = "<a href='/anime'>Go Home</a>";
	final String goHomeScript = "<script>setTimeout(()=>{location.replace('http://localhost:2021/anime')},1000);</script>";
	@Autowired
	AnimeService service;

	@GetMapping("/")
	public String homePageControl(Model model) {
		return "index.jsp";
	}
	@GetMapping("/anime")
	public String animeHomePageControl(Model model) {
		List<Anime> allAnime = service.getAllAnime();
		model.addAttribute("list", allAnime);
		model.addAttribute("names",service.getAllAnimeIdForSearch());
		model.addAttribute("total", service.getNoOfAnime());
		return "homePage.jsp";
	}
	@PostMapping("/filter")
	public ResponseEntity<Object> applyFilter(@RequestParam("watched") String watched,@RequestParam("plus18") String plus18){
		log.debug(watched+plus18);
		Map<String,Object> filteredAnimes = null;
		if(watched.equals("0")&&plus18.equals("0"))
			filteredAnimes = service.getAllAnimeWithTotal();
		else {
			
			filteredAnimes = service.applyfilter(watched,plus18);
		}
		log.debug(filteredAnimes);
		return new ResponseEntity<>(filteredAnimes, HttpStatus.OK);
	}
	@PostMapping("/page/{no}")
	public ResponseEntity<List<Anime>> getNextPage(@PathVariable("no")Integer no,@RequestParam("watched") String watched,@RequestParam("plus18") String plus18){
		log.debug(no+"  "+watched+"  "+plus18);
		List<Anime> nextPageAnimes = service.getNextPageAnimes(no,watched,plus18);
		return new ResponseEntity<>(nextPageAnimes, HttpStatus.OK);
	}
	@GetMapping("/genre/{genre}")
	public String animeByGenre(@PathVariable("genre")String genre,Model model) {
		model.addAttribute("list",service.getAllAnimeByGenre(genre));
		model.addAttribute("names", service.getAllAnimeIdForSearch());
		return "homePage.jsp";
	}
	@GetMapping("/search")
	public String searchByInput(@RequestParam("search") String search,Model model) {
		if(search.contains("$")) {
			int i = search.indexOf("$");
			search = search.substring(0, i).toLowerCase().replace(" ", "-");
			log.debug("inside $ if "+search);
			return "redirect:/view/"+search;
		}
		List<Anime> animeList= service.searchAlgorithm(search);
		if(animeList.size()== 1) {
			return "redirect:/view/"+animeList.get(0).getId();
		}
		if(animeList.size()<1) {
			return "redirect:/notfound";
		}
		model.addAttribute("list",animeList);
		model.addAttribute("names",service.getAllAnimeIdForSearch());
		return "homePage.jsp";
	}
	@GetMapping("/notfound")
	@ResponseBody
	public String notFound() {
		return "Couldn't find what you are looking for!\n"+anchortag+goHomeScript;
	}
	//dubbacore
	@GetMapping("/search/{query}")
	@ResponseBody
	public ResponseEntity<List<Anime>> search(@PathVariable("query") String query){
		List<Anime> allAnime = service.searchAlgorithm(query);
//		List<String> result = new ArrayList<>();
		for (Anime anime : allAnime) {
//			result.add(anime.getId()+"(id)"+anime.getEngName()+"$"+anime.getJapName()+"(next)");
			System.out.println(anime);
		}
//		HttpHeaders h = new HttpHeaders();
//		h.add("content-type", "text/json");
		return new ResponseEntity<>(allAnime, HttpStatus.FOUND);
	}
	@GetMapping("/add")
	public String addNewAnime(Model model) {
		model.addAttribute("anime",new Anime());
		return "addNewSeries.jsp";
	}
	@GetMapping("/view/{id}")
	public String viewAnime(@PathVariable("id") String id,Model model) {
		model.addAttribute("anime",service.getAnimeById(id));
		return "viewAnime.jsp";
	}
	@GetMapping("/edit/{id}")
	public String editAnime(@PathVariable("id") String id,Model model) {
		model.addAttribute("anime",service.getAnimeById(id));
		return "addNewSeries.jsp";
	}
	@GetMapping("/delete/{id}")
	@ResponseBody
	public String deleteAnime(@PathVariable("id") String id,Model model) {
		service.deleteAnimeById(id);
		return "Deleted Successfully\n"+anchortag+goHomeScript;
	}
	@PostMapping("/add")
	@ResponseBody
	public String addNewSeriesToDB(Model model, @ModelAttribute("anime") Anime anime) {
		anime.setId(anime.getEngName().toLowerCase().replace(" ", "-"));
		log.debug(anime);
		service.save(anime);
		return "Saved successfully\n"+anchortag+goHomeScript;
	}
	
	
}