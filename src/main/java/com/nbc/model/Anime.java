package com.nbc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import com.sun.istack.Nullable;

@Entity
@Table(name="anime")
public class Anime {

	@Id
	private String id;
	private String engName;
	private String japName;
	@Column(name = "description",length = 1000)
	private String description;
	private String tags;
	private int noOfSeasons;
	private int noOfEpisodes;
	@Nullable
	private boolean watched;
	@Nullable
	private boolean plus18;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEngName() {
		return engName;
	}
	public void setEngName(String engName) {
		this.engName = engName;
	}
	public String getJapName() {
		return japName;
	}
	public void setJapName(String japName) {
		this.japName = japName;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getTags() {
		return tags;
	}
	public void setTags(String tags) {
		this.tags = tags;
	}
	public int getNoOfSeasons() {
		return noOfSeasons;
	}
	public void setNoOfSeasons(int noOfSeasons) {
		this.noOfSeasons = noOfSeasons;
	}
	public int getNoOfEpisodes() {
		return noOfEpisodes;
	}
	public void setNoOfEpisodes(int noOfEpisodes) {
		this.noOfEpisodes = noOfEpisodes;
	}
	public void setWatched(boolean watched) {
		this.watched = watched;
	}
	public boolean isWatched() {
		return watched;
	}
	public boolean isPlus18() {
		return plus18;
	}
	public void setPlus18(boolean plus18) {
		this.plus18 = plus18;
	}
	public String toString() {
		return id+","+engName+","+japName+","+noOfEpisodes+","+noOfSeasons+","+watched+",";
	}
	
}
