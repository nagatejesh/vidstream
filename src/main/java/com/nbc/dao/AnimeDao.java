package com.nbc.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.nbc.model.Anime;

@Repository
public interface AnimeDao extends JpaRepository<Anime, String> {

	@Query(value = "Select * from anime limit 20", nativeQuery = true)
	public List<Anime> getAllAnime();
	
	@Query(value = "SELECT * FROM anime where name = ?1 ", nativeQuery = true)
	public Anime getSeriesByName(String name);

	@Query(value = "SELECT eng_name FROM anime", nativeQuery = true)
	public List<String> getAllAnimeEngNames();

	@Query(value = "SELECT id FROM anime WHERE eng_name LIKE ?1 OR jap_name LIKE ?2",nativeQuery = true)
	public List<String> searchForName(String word1,String word2);

	@Query(value = "SELECT CONCAT(eng_name,\'$\',jap_name) AS names FROM anime", nativeQuery = true)
	public List<String> getAllAnimeIdForSearch();

	@Query(value = "SELECT * FROM anime WHERE tags LIKE ?", nativeQuery = true)
	public List<Anime> getAllAnimeByGenre(String genre);

	@Query(value = "SELECT * FROM anime WHERE watched=? LIMIT 20", nativeQuery = true)
	public List<Anime> applyFilterByWatch(String watched);
	
	@Query(value = "SELECT * FROM anime WHERE plus18=? LIMIT 20", nativeQuery = true)
	public List<Anime> applyFilterByPlus18(String plus18);
	
	@Query(value = "SELECT * FROM anime WHERE watched=?1 AND plus18=?2 LIMIT 20", nativeQuery = true)
	public List<Anime> applyFilterByWatchAndPlus18(String watched,String plus18);
	
	@Query(value = "SELECT COUNT(id) FROM anime WHERE plus18 = ?",nativeQuery = true)
	public long getCountByPlus18(String plus18);
	
	@Query(value = "SELECT COUNT(id) FROM anime WHERE watched = ?",nativeQuery = true)
	public long getCountByWatch(String watched);

	@Query(value = "SELECT COUNT(id) FROM anime WHERE watched = ?1 AND plus18 = ?2",nativeQuery = true)
	public Object getCountByWatchAndPlus18(String watched, String plus18);

	@Query(value = "SELECT * FROM anime LIMIT 10 OFFSET ?", nativeQuery = true)
	public List<Anime> getLimited(int no);

	@Query(value = "SELECT * FROM anime WHERE plus18 = ?1 LIMIT 10 OFFSET ?2", nativeQuery = true)
	public List<Anime> getLimitedByPlus18(String plus18, int no);

	@Query(value = "SELECT * FROM anime WHERE watched = ?1 LIMIT 10 OFFSET ?2", nativeQuery = true)
	public List<Anime> getLimitedByWatch(String watched, int no);

	@Query(value = "SELECT * FROM anime WHERE watched = ?1 AND plus18 = ?2 LIMIT 10 OFFSET ?3", nativeQuery = true)
	public List<Anime> getLimitedByWatchAndPlus18(String watched, String plus18, int no);
}
