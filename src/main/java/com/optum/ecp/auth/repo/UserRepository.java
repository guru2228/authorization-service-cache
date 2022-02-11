package com.optum.ecp.auth.repo;


import com.optum.ecp.auth.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

    @Query("SELECT u.userId FROM User u")
    Iterable<String> getAllIds();

}
