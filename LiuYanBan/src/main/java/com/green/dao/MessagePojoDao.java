package com.green.dao;

import com.green.pojo.MessagePojo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MessagePojoDao extends JpaRepository<MessagePojo,String>, JpaSpecificationExecutor<MessagePojo> {

    @Modifying
    @Query(value = "select *  from message where address=?1", nativeQuery = true)
    List<MessagePojo> findAllByAddress(String address);
}
