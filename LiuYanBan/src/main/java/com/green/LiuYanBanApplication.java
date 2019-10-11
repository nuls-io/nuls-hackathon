package com.green;
import com.green.dao.MessagePojoDao;
import com.green.pojo.MessagePojo;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;

import java.util.List;
import java.util.Optional;

@SpringBootApplication
public class LiuYanBanApplication {

	public static void main(String[] args) {
		SpringApplication.run(LiuYanBanApplication.class, args);
	}

}
