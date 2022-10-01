package com.nbc.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.juli.logging.Log;
import org.apache.juli.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nbc.controllers.HomeController;
import com.nbc.dao.AnimeDao;
import com.nbc.model.Anime;

@Service
public class AnimeService {
	
	@Autowired
	AnimeDao animeDao;
	
	final Log log = LogFactory.getLog(AnimeService.class);
	
	public void save(Anime s) {
		animeDao.save(s);
	}
	
	public Anime getAnimeById(String id) {
		return animeDao.findById(id).orElse(null);
	}
	
	public List<Anime> searchById(String id){
		List<Anime> allAnime = getAllAnime();
		List<Anime> resultAnime = new ArrayList<>();
		
		for (Anime anime : allAnime) {
			String[] split = id.toLowerCase().split(" ");
			for (String str : split) {
				if(anime.getEngName().toLowerCase().contains(str)) {
					resultAnime.add(anime);
				}
			}
		}
		return resultAnime;
	}
	
	public List<Anime> getAllAnime(){
		return animeDao.getAllAnime();
	}
	
	public void deleteAnimeById(String id) {
		animeDao.deleteById(id);
	}
	
	public List<Anime> getAllMiniAnime(){
		List<Anime> outputList = new LinkedList<>();
		List<Anime> seriesList = getAllAnime();
		
		for (Anime s : seriesList)
			if(s.getNoOfSeasons()<4)
				outputList.add(s);
		
		return outputList;
	}

	public List<String> getAllAnimeEngNames() {
		// TODO Auto-generated method stub
		return animeDao.getAllAnimeEngNames();
	}

	public List<String> searchForName(String word) {
		// TODO Auto-generated method stub
		return animeDao.searchForName("%"+word+"%","%"+word+"%");
	}
	public Map<String, Integer> sortByValue(Map<String, Integer> unsortMap) {

        // 1. Convert Map to List of Map
        List<Map.Entry<String, Integer>> list =
                new LinkedList<Map.Entry<String, Integer>>(unsortMap.entrySet());

        // 2. Sort list with Collections.sort(), provide a custom Comparator
        //    Try switch the o1 o2 position for a different order
        Collections.sort(list, new Comparator<Map.Entry<String, Integer>>() {
            public int compare(Map.Entry<String, Integer> o1,
                               Map.Entry<String, Integer> o2) {
                return (o1.getValue()).compareTo(o2.getValue());
            }
        });

        // 3. Loop the sorted list and put it into a new insertion order Map LinkedHashMap
        Map<String, Integer> sortedMap = new LinkedHashMap<String, Integer>();
        for (Map.Entry<String, Integer> entry : list) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }

        /*
        //classic iterator example
        for (Iterator<Map.Entry<String, Integer>> it = list.iterator(); it.hasNext(); ) {
            Map.Entry<String, Integer> entry = it.next();
            sortedMap.put(entry.getKey(), entry.getValue());
        }*/


        return sortedMap;
    }

	public List<String> getAllAnimeIdForSearch() {
		// TODO Auto-generated method stub
		return animeDao.getAllAnimeIdForSearch();
	}

	public List<Anime> getAllAnimeByGenre(String genre) {
		// TODO Auto-generated method stub
		return animeDao.getAllAnimeByGenre("%"+genre+"%");
	}
	
	public List<Anime> searchAlgorithm(String search){
		List<Anime> animeList= new ArrayList<>();
		Map<String,Integer> animeMap = new HashMap<>();
		if(search.contains(" ")) {
			String[] words = search.split(" ");
			for(String word : words) {
				log.debug(word);
				List<String> result = searchForName(word);
				log.debug("result for "+word+"\n"+result);
				Map<String,Integer> dummyMap = new HashMap<>();
				for(String resultAnime : result) {
					int count=1;
					for(Map.Entry<String, Integer> pair : animeMap.entrySet()) {
						if(pair.getKey().equals(resultAnime)) {
							count=pair.getValue()+1;
//							dummyMap.put(pair.getKey(), pair.getValue()+1);
						}
					}
					dummyMap.put(resultAnime,count);
				}
				log.debug(dummyMap);
				animeMap = dummyMap;
			}
			animeMap = sortByValue(animeMap);
			for(String id : animeMap.keySet()) {
				log.debug(id);
				animeList.add(getAnimeById(id));
			}
		}else {
			log.debug(search);
			List<String> result = searchForName(search);
			for(String id : result) {
				animeList.add(getAnimeById(id));
			}
		}
		return animeList;
	}

	public long getNoOfAnime() {
		return animeDao.count();
	}

	public List<Anime> getNextPageAnimes(int no, String watched, String plus18) {
		if(watched.equals("0")&&plus18.equals("0"))
			return animeDao.getLimited(no*10);
		if(watched.equals("0") && !plus18.equals("0")) {
			if(plus18.equals("2")) plus18="0";
			return animeDao.getLimitedByPlus18(plus18,no*10);
		}
		if(!watched.equals("0") && plus18.equals("0")) {
			if(watched.equals("2")) watched="0";
			return animeDao.getLimitedByWatch(watched,no*10);
		}
		if(plus18.equals("2")) plus18="0";
		if(watched.equals("2")) watched="0";
		return animeDao.getLimitedByWatchAndPlus18(watched,plus18,no*10);
	}

	public Map<String,Object> applyfilter(String watched, String plus18) {
		Map<String,Object> m = new HashMap<>();
		if(watched.equals("0") && !plus18.equals("0")) {
			if(plus18.equals("2")) plus18="0";
			m.put("animes", animeDao.applyFilterByPlus18(plus18));
			m.put("total", animeDao.getCountByPlus18(plus18));
			return m;
		}
		if(!watched.equals("0") && plus18.equals("0")) {
			if(watched.equals("2")) watched="0";
			m.put("animes", animeDao.applyFilterByWatch(watched));
			m.put("total", animeDao.getCountByWatch(watched));
			return m;
		}
		if(plus18.equals("2")) plus18="0";
		if(watched.equals("2")) watched="0";
		m.put("animes", animeDao.applyFilterByWatchAndPlus18(watched,plus18));
		m.put("total", animeDao.getCountByWatchAndPlus18(watched,plus18));
		return m;
		
	}

	public Map<String,Object> getAllAnimeWithTotal() {
		Map<String,Object> m = new HashMap<>();
		m.put("animes", animeDao.getAllAnime());
		m.put("total", animeDao.count());
		return m;
	}
	
}
