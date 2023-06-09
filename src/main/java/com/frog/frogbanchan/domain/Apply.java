package com.frog.frogbanchan.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.io.Serializable;
import java.sql.Timestamp;

@Entity
@Getter  @Setter  @ToString
@SuppressWarnings("serial")
public class Apply implements Serializable {
	@Id
	private int applyId;
	private int partyId;
	private String writer;
	private Timestamp writtenDate;
	private String content;
	
	public Apply() {
		
	}
	public Apply(int applyId, int partyId, String writer, String content) {
		super();
		this.applyId = applyId;
		this.partyId = partyId;
		this.writer = writer;
		this.content = content;
	}
	public Apply(int applyId, int partyId, String writer, Timestamp writtenDate, String content) {
		super();
		this.applyId = applyId;
		this.partyId = partyId;
		this.writer = writer;
		this.writtenDate = writtenDate;
		this.content = content;
	}
	
}
