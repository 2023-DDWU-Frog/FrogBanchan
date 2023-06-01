package com.frog.frogbanchan.dao.mybatis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.frog.frogbanchan.dao.ReservationDao;
import com.frog.frogbanchan.dao.mybatis.mapper.ReservationMapper;
import com.frog.frogbanchan.domain.Reservation;

@Repository
public class MybatisReservationDao implements ReservationDao {

    @Autowired
    private ReservationMapper reservationMapper;

    // 예약처리
    public void insertReservation(Reservation reservation) throws DataAccessException {
        reservationMapper.insertReservation(reservation);
    };

    // 예약취소
    public void deleteReservation(int reservationId) throws DataAccessException {
        reservationMapper.deleteReservation(reservationId);
    };

    // 예약확인
    public Reservation findReservation(String placeId, String username) throws DataAccessException {
        return reservationMapper.findReservation(placeId, username);
    };

}